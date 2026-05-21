# World Life Expectancy Project (Data Cleaning)


SELECT * FROM worldlifeexpectancy;

SELECT Country, Year , CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM worldlifeexpectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

SELECT *
FROM (
SELECT Row_ID,
	   CONCAT(Country, Year),
       ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
       FROM worldlifeexpectancy) as Row_Table
       WHERE Row_Num > 1
       ;
       
SET SQL_SAFE_UPDATES = 0;   
       
       
DELETE FROM worldlifeexpectancy
	WHERE 
         Row_ID IN (
         SELECT Row_ID
	FROM (
		 SELECT Row_ID,
	   CONCAT(Country, Year),
       ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
       FROM worldlifeexpectancy) as Row_Table
       WHERE Row_Num > 1
       )
       ;
       
SELECT * FROM worldlifeexpectancy
		WHERE Status = ''

;

SELECT DISTINCT(Status) 
FROM worldlifeexpectancy
		WHERE Status <> ''
        ;
        
        SELECT * FROM worldlifeexpectancy
;

UPDATE worldlifeexpectancy 
SET Status = 'Developing'
WHERE Country IN ( SELECT DISTINCT(Country)
					FROM worldlifeexpectancy
                    WHERE Status = 'Developing');
                    
UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

SELECT * 
FROM worldlifeexpectancy
WHERE `Life expectancy` = ''
;

SELECT * 
FROM worldlifeexpectancy
#WHERE `Life expectancy` = ''
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
ON t1.Country = t2.Country
AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3
ON t1.Country = t3.Country
AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
#WHERE `Life expectancy` = ''
;

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
ON t1.Country = t2.Country
AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3
ON t1.Country = t3.Country
AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


SELECT * 
FROM worldlifeexpectancy
LIMIT 5000
#WHERE `Life expectancy` = ''
;