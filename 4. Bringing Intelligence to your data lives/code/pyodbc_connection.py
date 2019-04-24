import pyodbc
import pandas


conn = pyodbc.connect(
    "Driver={SQL Server Native Client 11.0};"
    r"Server=DESKTOP-DT7RHCP\WIN10SQL17DEV;"
    "Database=WineQuality;"
    "Trusted_Connection=yes;"
)

sql = "SELECT * FROM [WineQuality].[dbo].[wine_data]"
data = pandas.read_sql(sql,conn)


print(data)

