# World Life Expectancy Project (Exploratory Data Analysis)


SELECT * FROM worldlifeexpectancy;

SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`), 
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) as Life_Increase_15_Years
FROM worldlifeexpectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY 
 Life_Increase_15_Years ASC
;

#Average Life Expectancy

SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM worldlifeexpectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;


#GDP Correlation on Life Expectancy

SELECT Country,
 ROUND(AVG(`Life expectancy`),2)as Life_Exp,
 ROUND(AVG(GDP),1) as GDP
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0 
AND GDP > 0
ORDER BY GDP ASC
;

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) High_GDP_Life_Exp,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) Low_GDP_Life_Exp
FROM worldlifeexpectancy
;


#Status to Life Expectancy correlation 

SELECT Status, ROUND(AVG(`Life expectancy`),1)
 FROM worldlifeexpectancy
 GROUP BY Status
 ;
 
 SELECT Status, COUNT(DISTINCT(Country)), ROUND(AVG(`Life expectancy`),1)
 FROM worldlifeexpectancy
 GROUP BY Status
 ;
 
 # BMI Correlations
 
 SELECT Country,
 ROUND(AVG(`Life expectancy`),2)as Life_Exp,
 ROUND(AVG(BMI),1) as BMI
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0 
AND BMI > 0
ORDER BY BMI DESC
;

# Adult Mortality correlations

SELECT Country,
  Year,
 `Life expectancy`,
 `Adult Mortality`,
 SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) as Rolling_Total
FROM worldlifeexpectancy
#WHERE Country LIKE '%Bul%'
;