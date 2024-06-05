
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
    



