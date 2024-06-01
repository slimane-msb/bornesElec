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
    tarifNonAbonne DECIMAL(10, 2) DEFAULT 0.00
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






CREATE INDEX idxTypePrise ON prises(typePrise);
CREATE INDEX idxNomOperateur ON operateurs(nom);