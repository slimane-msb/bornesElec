

/**********************************************/
/***                BORNES                  ***/
/**********************************************/


CREATE TABLE bornes (
    numeroId INT AUTO_INCREMENT PRIMARY KEY,
    puissanceMax FLOAT CHECK (puissanceMax >= 7 AND puissanceMax < 400),
    type ENUM('lente', 'normale', 'rapide') DEFAULT 'normale'
);

-- pour le nombre de borne on utilise une jointure avec StationBorne
CREATE TABLE stations (
    numeroId INT AUTO_INCREMENT PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT, 
    codePostal VARCHAR(5),
    distanceMinARoute FLOAT,
    ouverture TIME,
    fermeture TIME
);


CREATE TABLE operateurs (
    numeroId INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255),
    adresse VARCHAR(255),
    telephone VARCHAR(20),
    tarifAbonne DECIMAL(10, 2) DEFAULT 0.00,
    tarifNonAbonne DECIMAL(10, 2) DEFAULT 0.00,
    UNIQUE(nom)
);



CREATE TABLE vehicules (
    marque VARCHAR(50),
    modele VARCHAR(50),
    puissanceMoteur INT,
    puissanceBatterie INT,
    PRIMARY KEY (marque, modele)
);






CREATE TABLE stationBorne (
    numeroIdStation INT,
    numeroIdBorne INT PRIMARY KEY,
    FOREIGN KEY (numeroIdStation) REFERENCES stations(numeroId),
    FOREIGN KEY (numeroIdBorne) REFERENCES bornes(numeroId)
);



CREATE TABLE operateurBorne (
    numeroIdOperateur INT, 
    numeroIdBorne INT PRIMARY KEY, 
    FOREIGN KEY (numeroIdOperateur) REFERENCES operateurs(numeroId),
    FOREIGN Key (numeroIdBorne) REFERENCES bornes(numeroId)
);

-- On peut avoir une borne avec deux fois la meme prise
CREATE TABLE prises (
    idPrise INT AUTO_INCREMENT PRIMARY KEY,
    idBorne INT,
    typePrise ENUM('E', 'T2', 'CSS1', 'CSS3', 'CHAMO') NOT NULL,
    FOREIGN KEY (idBorne) REFERENCES bornes(numeroId)
);



CREATE TABLE vehiculeBorne (
    marque VARCHAR(50),
    modele VARCHAR(50),
    numeroIdBorne INT,
    PRIMARY Key (marque, modele, numeroIdBorne),
    FOREIGN KEY (marque,modele) REFERENCES vehicules(marque,modele),
    FOREIGN Key (numeroIdBorne) REFERENCES bornes(numeroId)
);


CREATE TABLE departements (
    departement   VARCHAR(3)  PRIMARY KEY,
    region VARCHAR(100) NOT NULL 
);




CREATE INDEX idxTypePrise ON prises(typePrise);
CREATE INDEX idxNomOperateur ON operateurs(nom);



/**********************************************/
/***                USERS                   ***/
/**********************************************/

CREATE TABLE users (
    userId INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,

    UNIQUE(email,password)
);




/**********************************************/
/***                TRIGGER                 ***/
/**********************************************/

/*
Mettre a jour nbPrise pour chaque a jour de nouvelle ligne dans la table prise 
pour verifier que nbPrise ne depasse pas 3 

identifiant : 
    depuis prises (numeroIdBorne)
    dans   bornes (numeroId,nbPrises)
*/

DROP TRIGGER IF EXISTS nbPrises_increment;

DELIMITER //

CREATE TRIGGER nbPrises_increment BEFORE INSERT ON prises
FOR EACH ROW
BEGIN
    DECLARE prise_count INT;
    SELECT COUNT(idBorne) INTO prise_count
    FROM prises
    WHERE idBorne = NEW.idBorne;

    IF prise_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Le nombre de prise par bornes ne peut pas depasser 3';
    END IF;
END;

//

DELIMITER ;


/**********************************************/
/***                VIEWS                   ***/
/**********************************************/

-- Liste des véhicules (marque et modèle) 
-- ayant une batterie de puissance supérieure à 50 KW
CREATE VIEW vehiculesBatterieSup AS
SELECT marque, modele
    FROM vehicules 
    WHERE puissanceBatterie > 50 ;


-- Liste des bornes de recharge de la station de numéro 100
CREATE VIEW bornesStation AS
SELECT 
    B.puissanceMax 'Puissance Max', 
    B.type 'Type'
    FROM bornes B
    INNER JOIN stationBorne SB
    On SB.numeroIdBorne = B.numeroId
    WHERE SB.numeroIdStation = 100 ;



-- Liste des stations ayant au moins une borne compatible avec une Tesla modèle 3
CREATE VIEW stationTesla AS 
SELECT 
    S.numeroId 'Station', 
    S.codePostal 'Code postal',
    S.distanceMinARoute 'Distance Min autoroute',
    S.fermeture 'Fermeture',
    S.ouverture 'Ouverture',
    S.longitude 'Longiture',
    S.latitude 'Latitude'
FROM stations S
INNER JOIN (
    SELECT DISTINCT S.numeroId
        FROM stations S
        INNER JOIN  stationBorne SB
        on S.numeroId = SB.numeroIdStation
        INNER JOIN  vehiculeBorne VB 
        on SB.numeroIdBorne = VB.numeroIdBorne
        WHERE marque = 'Tesla'
        AND modele = 'Model 3'  
) AS DS
ON S.numeroId = DS.numeroId;



-- Nombre de bornes par stations situées dans les départements d’Ile de France 
-- (75, 77, 91, 92, 93, 94, 95).
CREATE VIEW stationIdf AS
SELECT 
    IDF.numeroId 'Station',
    count(SB.numeroIdBorne) 'Nombre de borne',
    IDF.codePostal 'Code postal',
    IDF.latitude 'Latitude',
    IDF.longitude 'Longitude',
    IDF.distanceMinARoute 'Distance Min autoroute',
    IDF.ouverture 'Ouverture',
    IDF.fermeture 'Fermeture'
    FROM (
        SELECT * 
        FROM stations S
        WHERE LEFT(S.codePostal, 2) IN ('75', '77', '91', '92', '93', '94', '95')
    ) AS IDF
    INNER JOIN stationBorne SB
    ON SB.numeroIdStation = IDF.numeroId
    GROUP BY IDF.numeroId;
    
    
-- Numéro du département qui a le plus de bornes de recharge
CREATE VIEW bornesParDepartement AS
SELECT 
    LEFT(S.codePostal, 2) AS 'Departement',
    count(SB.numeroIdBorne) 'Nombre de bornes'
    FROM stations S
    INNER JOIN stationBorne SB
    ON SB.numeroIdStation = S.numeroId
    GROUP BY LEFT(S.codePostal, 2)
    ORDER BY count(SB.numeroIdBorne) DESC;
    





/**********************************************/
/***                PROCEDURES              ***/
/**********************************************/



-- demande un code postal et un type de prise et affiche l’ensemble des
-- stations de recharge offrant au moins une borne correspondante
DELIMITER //

CREATE PROCEDURE GetStationParCodePostalPrise(IN codePostalParam VARCHAR(100), IN typePriseParam VARCHAR(100))
BEGIN
    SELECT 
        SB.numeroId AS 'Station',
        SB.codePostal AS 'Code postal',
        P.typePrise AS 'Type prise',
        SB.latitude AS 'Latitude',
        SB.longitude AS 'Longitude',
        SB.distanceMinARoute AS 'Distance Min autoroute',
        SB.ouverture AS 'Ouverture',
        SB.fermeture AS 'Fermeture'
    FROM (
        SELECT *
        FROM stations S
        INNER JOIN stationBorne SB ON SB.numeroIdStation = S.numeroId
        WHERE S.codePostal = codePostalParam
    ) AS SB
    INNER JOIN prises P ON P.idBorne = SB.numeroIdBorne
    WHERE P.typePrise = typePriseParam;
END //




-- Liste des stations ayant au moins une borne compatible avec un vehicule (marque,modele)
CREATE PROCEDURE GetStationParVehicule(IN marqueParam VARCHAR(100), IN modeleParam VARCHAR(100))
BEGIN    
    SELECT 
        S.numeroId 'Station', 
        S.codePostal 'Code postal',
        S.distanceMinARoute 'Distance Min autoroute',
        S.fermeture 'Fermeture',
        S.ouverture 'Ouverture',
        S.longitude 'Longiture',
        S.latitude 'Latitude'
    FROM stations S
    INNER JOIN (
        SELECT DISTINCT S.numeroId
            FROM stations S
            INNER JOIN  stationBorne SB
            on S.numeroId = SB.numeroIdStation
            INNER JOIN  vehiculeBorne VB 
            on SB.numeroIdBorne = VB.numeroIdBorne
            WHERE marque = marqueParam
            AND modele = modeleParam 
    ) AS DS
    ON S.numeroId = DS.numeroId;
END //


-- Liste des véhicules (marque et modèle) 
-- ayant une batterie de puissance supérieure à 50 KW
CREATE PROCEDURE GetVehiculeParPuissanceMin(IN puissanceMoteurMin INT, IN puissanceBatterieMin INT )
BEGIN  
    SELECT 
        marque 'Marque', 
        modele 'Modele', 
        puissanceBatterie 'Puissance batterie', 
        puissanceMoteur 'Puissance moteur'
    FROM vehicules 
    WHERE puissanceBatterie > puissanceBatterieMin 
    AND puissanceMoteur > puissanceMoteurMin;
END //

CREATE PROCEDURE GetStationParRegion(IN regionParam VARCHAR(100) )
BEGIN
    SELECT 
        IDF.numeroId 'Station',
        count(SB.numeroIdBorne) 'Nombre de borne',
        IDF.codePostal 'Code postal',
        IDF.latitude 'Latitude',
        IDF.longitude 'Longitude',
        IDF.distanceMinARoute 'Distance Min autoroute',
        IDF.ouverture 'Ouverture',
        IDF.fermeture 'Fermeture'
    FROM (
        SELECT * 
        FROM stations S
        INNER JOIN departements D
        ON LEFT(S.codePostal, 2) = D.departement
        WHERE D.region = regionParam
    ) AS IDF
    INNER JOIN stationBorne SB
    ON SB.numeroIdStation = IDF.numeroId
    GROUP BY IDF.numeroId;
END //


DELIMITER ;



    




/**********************************************/
/***                USERS insert            ***/
/**********************************************/

INSERT INTO users (name, email, password) VALUES
('johnsmith', 'johnsmith@gmail.com', '123'),
('janedoe', 'janedoe@gmail.com', '456'),
('alexjones', 'alexjones@gmail.com', '789');


/**********************************************/
/***                BORNES INSERT           ***/
/**********************************************/

-- insert ExitSuccess
INSERT INTO bornes (puissanceMax, type) VALUES (100.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (300.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (350.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (100.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (300.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (350.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (100.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (300.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (350.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (100.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (300.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (350.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (100.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (300.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (350.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (100.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (300.0, 'rapide');
INSERT INTO bornes (puissanceMax, type) VALUES (350.0, 'rapide');

INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (45.678, -73.567, '75000', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (40.712, -74.006, '06000', 3.2, '07:30:00', '17:30:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (34.052, -118.243, '13000', 4.7, '09:00:00', '19:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (51.507, -0.127, '10000', 1.8, '08:30:00', '18:30:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (48.856, 2.352, '33000', 2.1, '07:45:00', '17:45:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (52.520, 13.405, '67000', 3.0, '08:15:00', '18:15:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (35.689, 139.692, '40000', 1.5, '09:30:00', '19:30:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (40.416, -3.703, '28000', 2.8, '07:00:00', '17:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (37.774, -122.419, '69000', 2.3, '08:45:00', '18:45:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (55.755, 37.617, '59000', 3.6, '08:20:00', '18:20:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (51.507, -0.128, '67000', 1.2, '07:15:00', '17:15:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (41.902, 12.496, '33000', 2.9, '09:15:00', '19:15:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (45.501, -73.567, '69000', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (40.678, -74.067, '06000', 3.2, '07:30:00', '17:30:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (34.082, -118.243, '10000', 4.7, '09:00:00', '19:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (51.527, -0.127, '13000', 1.8, '08:30:00', '18:30:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (48.856, 2.352, '40000', 2.1, '07:45:00', '17:45:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (52.520, 13.405, '28000', 3.0, '08:15:00', '18:15:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (35.689, 139.692, '33000', 1.5, '09:30:00', '19:30:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (40.416, -3.703, '59000', 2.8, '07:00:00', '17:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (37.774, -122.419, '67000', 2.3, '08:45:00', '18:45:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (55.755, 37.617, '40000', 3.6, '08:20:00', '18:20:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (51.507, -0.128, '28000', 1.2, '07:15:00', '17:15:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (41.902, 12.496, '59000', 2.9, '09:15:00', '19:15:00');



INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope2', '2 avenue de la paix', '0625262544', 9.99, 14.99);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope3', '3 boulevard de la liberté', '0625262545', 8.99, 13.99);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope4', '4 rue du bonheur', '0625262546', 7.99, 12.99);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope5', '5 chemin de l''étoile', '0625262547', 10.99, 15.99);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope6', '6 rue de la victoire', '0625262548', 11.99, 16.99);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope7', '7 avenue des rêves', '0625262549', 9.50, 14.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope8', '8 route du succès', '0625262550', 9.75, 14.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope9', '9 sentier de la chance', '0625262551', 9.25, 14.25);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope10', '10 avenue de la gloire', '0625262552', 10.25, 15.25);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope11', '11 place de l''avenir', '0625262553', 10.50, 15.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope12', '12 avenue de la fortune', '0625262554', 11.25, 16.25);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope13', '13 rue de la prospérité', '0625262555', 11.50, 16.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope14', '14 chemin du succès', '0625262556', 10.75, 15.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope15', '15 boulevard de l''harmonie', '0625262557', 11.75, 16.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope16', '16 avenue de la sérénité', '0625262558', 12.00, 17.00);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope17', '17 chemin de la plénitude', '0625262559', 12.50, 17.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope18', '18 rue de la félicité', '0625262560', 13.25, 18.25);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope19', '19 avenue de l''épanouissement', '0625262561', 12.75, 17.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope20', '20 boulevard de la joie', '0625262562', 13.50, 18.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope21', '21 route du bonheur', '0625262563', 13.75, 18.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope22', '22 sentier de la réussite', '0625262564', 14.00, 19.00);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope23', '23 avenue de l''espoir', '0625262565', 14.50, 19.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope24', '24 chemin de l''accomplissement', '0625262566', 15.25, 20.25);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope25', '25 boulevard de la réussite', '0625262567', 15.50, 20.50);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope26', '26 avenue de l''épanouissement', '0625262568', 15.75, 20.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope27', '27 rue du succès', '0625262569', 16.00, 21.00);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope28', '28 chemin de la victoire', '0625262570', 16.25, 21.25);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope29', '29 avenue de la liberté', '0625262571', 16.50, 21.50);


INSERT INTO vehicules (marque, modele, puissanceMoteur, puissanceBatterie) VALUES ('Tesla', 'Model S', 350, 100);
INSERT INTO vehicules (marque, modele, puissanceMoteur, puissanceBatterie) VALUES ('Tesla', 'Model 3', 350, 100);
INSERT INTO vehicules (marque, modele, puissanceMoteur, puissanceBatterie) VALUES ('Nissan', 'Leaf', 150, 40);


INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (1, 1);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (1, 2);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (2, 3);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (3, 4);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (1, 5);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (2, 6);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (3, 7);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (4, 8);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (5, 9);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (6, 10);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (7, 11);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (8, 12);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (9, 13);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (10, 14);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (11, 15);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (12, 16);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (20, 17);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (24, 18);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (20, 19);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (23, 20);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (19, 21);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (16, 22);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (15, 23);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (4, 24);


INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (1, 1);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (1, 2);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (2, 3);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (3, 4);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (1, 5);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (2, 6);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (3, 7);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (4, 8);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (5, 9);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (6, 10);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (7, 11);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (8, 12);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (9, 13);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (10, 14);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (11, 15);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (12, 16);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (21, 17);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (24, 18);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (20, 19);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (23, 20);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (19, 21);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (16, 22);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (15, 23);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (4, 24);


INSERT INTO prises (idBorne, typePrise) VALUES (1, 'E');
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'T2'); 
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'CSS1'); 
INSERT INTO prises (idBorne, typePrise) VALUES (2, 'T2');
INSERT INTO prises (idBorne, typePrise) VALUES (2, 'T2');


INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model 3', 1);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model 3', 2);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model S', 1);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Nissan', 'Leaf', 2);





/**********************************************/
/***                REGION INSERT           ***/
/**********************************************/
INSERT INTO departements (departement, region) VALUES
    ('01', 'Auvergne-Rhône-Alpes'),
    ('02', 'Hauts-de-France'),
    ('03', 'Auvergne-Rhône-Alpes'),
    ('04', 'Provence-Alpes-Côte d''Azur'),
    ('05', 'Provence-Alpes-Côte d''Azur'),
    ('06', 'Provence-Alpes-Côte d''Azur'),
    ('07', 'Auvergne-Rhône-Alpes'),
    ('08', 'Grand Est'),
    ('09', 'Occitanie'),
    ('10', 'Grand Est'),
    ('11', 'Occitanie'),
    ('12', 'Occitanie'),
    ('13', 'Provence-Alpes-Côte d''Azur'),
    ('14', 'Normandie'),
    ('15', 'Auvergne-Rhône-Alpes'),
    ('16', 'Nouvelle-Aquitaine'),
    ('17', 'Nouvelle-Aquitaine'),
    ('18', 'Centre-Val de Loire'),
    ('19', 'Nouvelle-Aquitaine'),
    ('21', 'Bourgogne-Franche-Comté'),
    ('22', 'Bretagne'),
    ('23', 'Nouvelle-Aquitaine'),
    ('24', 'Nouvelle-Aquitaine'),
    ('25', 'Bourgogne-Franche-Comté'),
    ('26', 'Auvergne-Rhône-Alpes'),
    ('27', 'Normandie'),
    ('28', 'Centre-Val de Loire'),
    ('29', 'Bretagne'),
    ('2A', 'Corse'),
    ('2B', 'Corse'),
    ('30', 'Occitanie'),
    ('31', 'Occitanie'),
    ('32', 'Occitanie'),
    ('33', 'Nouvelle-Aquitaine'),
    ('34', 'Occitanie'),
    ('35', 'Bretagne'),
    ('36', 'Centre-Val de Loire'),
    ('37', 'Centre-Val de Loire'),
    ('38', 'Auvergne-Rhône-Alpes'),
    ('39', 'Bourgogne-Franche-Comté'),
    ('40', 'Nouvelle-Aquitaine'),
    ('41', 'Centre-Val de Loire'),
    ('42', 'Auvergne-Rhône-Alpes'),
    ('43', 'Auvergne-Rhône-Alpes'),
    ('44', 'Pays de la Loire'),
    ('45', 'Centre-Val de Loire'),
    ('46', 'Occitanie'),
    ('47', 'Nouvelle-Aquitaine'),
    ('48', 'Occitanie'),
    ('49', 'Pays de la Loire'),
    ('50', 'Normandie'),
    ('51', 'Grand Est'),
    ('52', 'Grand Est'),
    ('53', 'Pays de la Loire'),
    ('54', 'Grand Est'),
    ('55', 'Grand Est'),
    ('56', 'Bretagne'),
    ('57', 'Grand Est'),
    ('58', 'Bourgogne-Franche-Comté'),
    ('59', 'Hauts-de-France'),
    ('60', 'Hauts-de-France'),
    ('61', 'Normandie'),
    ('62', 'Hauts-de-France'),
    ('63', 'Auvergne-Rhône-Alpes'),
    ('64', 'Nouvelle-Aquitaine'),
    ('65', 'Occitanie'),
    ('66', 'Occitanie'),
    ('67', 'Grand Est'),
    ('68', 'Grand Est'),
    ('69', 'Auvergne-Rhône-Alpes'),
    ('70', 'Bourgogne-Franche-Comté'),
    ('71', 'Bourgogne-Franche-Comté'),
    ('72', 'Pays de la Loire'),
    ('73', 'Auvergne-Rhône-Alpes'),
    ('74', 'Auvergne-Rhône-Alpes'),
    ('75', 'Île-de-France'),
    ('76', 'Normandie'),
    ('77', 'Île-de-France'),
    ('78', 'Île-de-France'),
    ('79', 'Nouvelle-Aquitaine'),
    ('80', 'Hauts-de-France'),
    ('81', 'Occitanie'),
    ('82', 'Occitanie'),
    ('83', 'Provence-Alpes-Côte d''Azur'),
    ('84', 'Provence-Alpes-Côte d''Azur'),
    ('85', 'Pays de la Loire'),
    ('86', 'Nouvelle-Aquitaine'),
    ('87', 'Nouvelle-Aquitaine'),
    ('88', 'Grand Est'),
    ('89', 'Bourgogne-Franche-Comté'),
    ('90', 'Bourgogne-Franche-Comté'),
    ('91', 'Île-de-France'),
    ('92', 'Île-de-France'),
    ('93', 'Île-de-France'),
    ('94', 'Île-de-France'),
    ('95', 'Île-de-France');

