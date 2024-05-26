/*
Mettre a jour nbPrise pour chaque a jour de nouvelle ligne dans la table prise 
pour verifier que nbPrise ne depasse pas 3 

identifiant : 
    depuis prises (numeroIdBorne)
    dans   bornes (numeroId,nbPrises)
*/


DELIMITER //

CREATE TRIGGER nbPrises_increment AFTER INSERT ON prises
FOR EACH ROW
BEGIN
    UPDATE bornes SET nbPrises = nbPrises + 1 WHERE numeroId = NEW.idBorne;
END;
//

CREATE TRIGGER nbPrises_decrement AFTER DELETE ON prises
FOR EACH ROW
BEGIN
    UPDATE bornes SET nbPrises = nbPrises - 1 WHERE numeroId = OLD.idBorne;
END;
//

DELIMITER ;
