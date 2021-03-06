/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	color
	,quality
	,count(quality) as [#total]
FROM [WineQuality].[dbo].[wine_data] 
WHERE color = 'white'
group by color,quality
order by quality

--run the same script in Azure Data Studio