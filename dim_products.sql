SELECT * FROM dbo.products;


SELECT ProductID,ProductName,Price,
CASE WHEN Price<50 THEN 'Low'
	WHEN Price>50 AND Price<200 THEN 'Medium'
	ELSE 'High' END AS PriceCategory
FROM dbo.products;

