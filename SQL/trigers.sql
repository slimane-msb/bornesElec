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
