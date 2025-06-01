SELECT ReviewID,
		CustomerID,
		ProductID,
	   ReviewDate,
	   Rating,
	   REPLACE(ReviewText,'  ',' ')
FROM dbo.customer_reviews;