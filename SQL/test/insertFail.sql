-- insert ExitSuccess
INSERT INTO bornes (puissanceMax, type) VALUES (500.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (1.0, 'normale');
INSERT INTO bornes (puissanceMax, type) VALUES (200.0, 'autre');



INSERT INTO vehicules (marque, modele, puissanceMoteur, puissanceBatterie) VALUES ('Tesla', 'Model S', 351, 101);


INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES (2, 1);


INSERT INTO operateurBorne (numeroIdOperateur, numeroIdBorne) VALUES (2, 1);


INSERT INTO prises (idBorne, typePrise) VALUES (1, 'E'); 
INSERT INTO prises (idBorne, typePrise) VALUES (1, 'CHAMO'); 


INSERT INTO vehiculeBorne (marque, modele, numeroIdBorne) VALUES ('Tesla', 'Model S', 1);


