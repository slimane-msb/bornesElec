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


INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 45.678, -73.567, '75000', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 45.678, -73.567, '75400', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 45.678, -73.567, '75090', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 45.678, -73.567, '91000', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 45.678, -73.567, '91110', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 40.123, -76.789, '91000', 3.2, '09:00:00', '20:00:00');
INSERT INTO stations (latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES ( 40.123, -76.789, '55140', 3.2, '09:00:00', '20:00:00');


INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope1', '1 rue de la joie', '0625262544', 10.50, 15.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope2', '2 rue de la joie', '0625262544', 9.99, 14.99);


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


INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (1, 1);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (2, 2);


INSERT INTO prises (idBorne, typePrise) VALUES (1, 'E');
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'T2'); 
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'CSS1'); 
INSERT INTO prises (idBorne, typePrise) VALUES (2, 'T2');
INSERT INTO prises (idBorne, typePrise) VALUES (2, 'T2');


INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model 3', 1);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model 3', 2);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model S', 1);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Nissan', 'Leaf', 2);



