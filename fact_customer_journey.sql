SELECT *
FROM dbo.customer_journey;

--Finding Duplicate records
WITH DuplicateRecords AS(
SELECT JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		ROW_NUMBER() OVER(PARTITION BY JourneyID,CustomerID,ProductID,VisitDate,Stage,Action,
		Duration ORDER BY JourneyID) AS row_num
		FROM dbo.customer_journey 
)

SELECT * FROM DuplicateRecords
WHERE row_num>1;

--Now select the cleaned data
SELECT JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		COALESCE(Duration,avg_duration,0) AS Duration 
FROM 
	(
	SELECT JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		UPPER(Stage) AS Stage,
		Action,
		Duration,
		AVG(Duration) OVER(PARTITION BY VisitDate) AS avg_duration,
		ROW_NUMBER() OVER(PARTITION BY CustomerID,ProductID,VisitDate,UPPER(Stage),Action,
		Duration ORDER BY JourneyID) AS row_num
	FROM dbo.customer_journey) sub_query

	WHERE row_num=1;
	
