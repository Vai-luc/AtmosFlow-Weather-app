SELECT * FROM blinkit_data ;
DESCRIBE blinkit_data;
SELECT COUNT(*) FROM blinkit_data ;
/*DATA CLEANING*/
UPDATE blinkit_data 
SET `Item Fat Content` =
CASE 
WHEN LOWER(`Item Fat Content`) IN ('lf','low fat') THEN 'Low Fat'
WHEN LOWER(`Item Fat Content`) = 'reg' THEN 'Regular'
ELSE `Item Fat Content`
END;
SELECT DISTINCT(`Item Fat Content`) FROM blinkit_data;
SELECT CAST(SUM(`Total Sales`)/1000000 AS DECIMAL(10,2)) AS 'Total_sales_Million'
FROM blinkit_data;

SELECT ROUND(AVG(`Total Sales`), 1) AS Avg_Sales
FROM blinkit_data;


SELECT COUNT(*) AS NO_Of_Iteams FROM  blinkit_data;

SELECT CAST(SUM(`Total Sales`)/1000000 AS DECIMAL(10,2)) AS 'Total_sales_Million'
FROM blinkit_data
/*WHERE `Item Fat Content` = 'Low Fat'*/
WHERE `Outlet Establishment Year` = 2022;

SELECT CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating FROM blinkit_data;



SELECT `Item Type`/*`Item Fat Content`*/, CONCAT(CAST(SUM(`Total Sales`)/1000 AS DECIMAL(10,2)),'K') AS  Total_Sales_thousand,
						COUNT(*) AS NO_Of_Iteams ,
						CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating ,
                       CAST(AVG(`Total Sales`) AS DECIMAL(10,2)) AS Avg_Total_Sales
FROM Blinkit_data
WHERE `Outlet Establishment Year` = 2022
GROUP BY `Item Type`/*`Item Fat Content`*/
ORDER BY  Total_Sales_thousand DESC
limit 5;



SELECT 
    `Outlet Location Type`,
    
    SUM(CASE 
            WHEN `Item Fat Content` = 'Low Fat' 
            THEN `Total Sales` 
            ELSE 0 
        END) AS Low_Fat,

    SUM(CASE 
            WHEN `Item Fat Content` = 'Regular' 
            THEN `Total Sales` 
            ELSE 0 
        END) AS Regular

FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;
        

 
SELECT 
		`Outlet Size`,
        CAST(SUM(`Total Sales`)AS DECIMAL(10,2)) AS Total_Sales,
        CONCAT(CAST((SUM(`Total Sales`)*100.0/SUM(SUM(`Total Sales`)) OVER()) AS DECIMAL(10,2)),'%') AS Sales_Percentage
FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY Total_Sales DESC ;






 SELECT `Outlet Location Type`, 
						CONCAT(CAST(SUM(`Total Sales`)/1000 AS DECIMAL(10,2)),'K') AS  Total_Sales_thousand,
						COUNT(*) AS NO_Of_Iteams ,
                         CONCAT(CAST((SUM(`Total Sales`)*100.0/SUM(SUM(`Total Sales`)) OVER()) AS DECIMAL(10,2)),'%') AS Sales_Percentage,
						CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating ,
                       CAST(AVG(`Total Sales`) AS DECIMAL(10,2)) AS Avg_Total_Sales
FROM Blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY  Total_Sales_thousand DESC;



 SELECT `Outlet Type`, 
						CONCAT(CAST(SUM(`Total Sales`)/1000 AS DECIMAL(10,2)),'K') AS  Total_Sales_thousand,
						COUNT(*) AS NO_Of_Iteams ,
                         CONCAT(CAST((SUM(`Total Sales`)*100.0/SUM(SUM(`Total Sales`)) OVER()) AS DECIMAL(10,2)),'%') AS Sales_Percentage,
						CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating ,
                       CAST(AVG(`Total Sales`) AS DECIMAL(10,2)) AS Avg_Total_Sales
FROM Blinkit_data
GROUP BY `Outlet Type`
ORDER BY  SUM(`Total Sales`) DESC;

	
