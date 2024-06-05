CREATE USER 'conducteur'@'localhost' IDENTIFIED BY '123';

CREATE USER 'operateur'@'localhost' IDENTIFIED BY '456';


-- conducteur : tables
GRANT SELECT ON vehiculeBorne TO 'conducteur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON vehicules TO 'conducteur'@'localhost';
GRANT SELECT ON bornes TO 'conducteur'@'localhost';
GRANT SELECT ON departements TO 'conducteur'@'localhost';
GRANT SELECT ON operateurBorne TO 'conducteur'@'localhost';
GRANT SELECT ON operateurs TO 'conducteur'@'localhost';
GRANT SELECT ON prises TO 'conducteur'@'localhost';
GRANT SELECT ON stationBorne TO 'conducteur'@'localhost';
GRANT SELECT ON stations TO 'conducteur'@'localhost';

-- operateur : vues 
GRANT SELECT ON bornesParDepartement TO 'operateur'@'localhost';
GRANT SELECT ON bornesStation TO 'operateur'@'localhost';
GRANT SELECT ON stationIdf TO 'operateur'@'localhost';
GRANT SELECT ON stationTesla TO 'operateur'@'localhost';
GRANT SELECT ON vehiculesBatterieSup TO 'operateur'@'localhost';


-- operateur : tables 

GRANT SELECT ON vehicules TO 'operateur'@'localhost';
GRANT SELECT ON vehiculeBorne TO 'operateur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON bornes TO 'operateur'@'localhost';
GRANT SELECT ON departements TO 'operateur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON operateurBorne TO 'operateur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON operateurs TO 'operateur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON prises TO 'operateur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON stationBorne TO 'operateur'@'localhost';
GRANT SELECT,INSERT,UPDATE ON stations TO 'operateur'@'localhost';


-- operateur : vues 
GRANT SELECT ON bornesParDepartement TO 'operateur'@'localhost';
GRANT SELECT ON bornesStation TO 'operateur'@'localhost';
GRANT SELECT ON stationIdf TO 'operateur'@'localhost';
GRANT SELECT ON stationTesla TO 'operateur'@'localhost';
GRANT SELECT ON vehiculesBatterieSup TO 'operateur'@'localhost';
