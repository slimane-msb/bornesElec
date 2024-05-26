-- insert ExitSuccess
INSERT INTO bornes (puissanceMax, type, nbPrises) VALUES (100.0, 'normale', 2);
INSERT INTO bornes (puissanceMax, type, nbPrises) VALUES (200.0, 'rapide', 1);


INSERT INTO stations (nombreBornes, latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (5, 45.678, -73.567, '75000', 2.5, '08:00:00', '18:00:00');
INSERT INTO stations (nombreBornes, latitude, longitude, codePostal, distanceMinARoute, ouverture, fermeture) VALUES (3, 40.123, -76.789, '91000', 3.2, '09:00:00', '20:00:00');


INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope1', '1 rue de la joie', '0625262544', 10.50, 15.75);
INSERT INTO operateurs (nom, adresse, telephone, tarifAbonne, tarifNonAbonne) VALUES ('Ope2', '2 rue de la joie', '0625262544', 9.99, 14.99);


INSERT INTO vehicules (marque, modele, puissanceMoteur, puissanceBatterie) VALUES ('Tesla', 'Model S', 350, 100);
INSERT INTO vehicules (marque, modele, puissanceMoteur, puissanceBatterie) VALUES ('Nissan', 'Leaf', 150, 40);


INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (1, 1);
INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (1, 2);


INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (1, 1);
INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (2, 2);


INSERT INTO prises (idBorne, typePrise) VALUES (1, 'E');
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'T2'); 
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'CSS1'); 
INSERT INTO prises (idBorne, typePrise) VALUES (2, 'T2');


INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model S', 1);
INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Nissan', 'Leaf', 2);



