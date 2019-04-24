#install.packages("RODBC")

library(RODBC, lib.loc = "C:/Program Files/Microsoft SQL Server/140/R_SERVER/library")

con <- odbcConnect("Demo")
df <- sqlQuery(con, "SELECT [facidity]
      ,[vacidity]
      ,[citric]
      ,[sugar]
      ,[chlorides]
      ,[fsulfur]
      ,[tsulfur]
      ,[density]
      ,[pH]
      ,[sulphates]
      ,[alcohol]
      ,[quality]
      ,[color]
  FROM [WineQuality].[dbo].[wine_data]")
