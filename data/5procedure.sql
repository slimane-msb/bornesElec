

/**********************************************/
/***                PROCEDURES              ***/
/**********************************************/

DROP PROCEDURE IF EXISTS GetStationParCodePostalPrise;
DROP PROCEDURE IF EXISTS GetStationParVehicule;
DROP PROCEDURE IF EXISTS GetVehiculeParPuissanceMin;

DELIMITER //


-- demande un code postal et un type de prise et affiche l’ensemble des
-- stations de recharge offrant au moins une borne correspondante
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



    
