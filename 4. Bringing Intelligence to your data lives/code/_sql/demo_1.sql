USE Demo
GO

DROP TABLE IF EXISTS dbo.EMP
GO

CREATE TABLE [dbo].[EMP](
	[empno]		[int]			NOT NULL
	,[ename]	[varchar](10)	NULL
	,[sal]		[float]			NULL
) 
GO
 
INSERT INTO EMP VALUES
    (1,'Employee1',18000)
INSERT INTO EMP VALUES
    (2,'Employee2',52000)
INSERT INTO EMP VALUES
    (3,'Employee3',25000)

--select * from  dbo.EMP
SELECT EMPNO,ENAME,SAL from dbo.EMP
 
EXECUTE sp_execute_external_script 
@language = N'Python',
@script=N'OutputDataSet = InputDataSet
for i in OutputDataSet["sal"]:
	OutputDataSet["Bonus"]=OutputDataSet["sal"]*0.05',
@input_data_1 = N'SELECT [empno],[ename],sal,0 as Bonus from EMP'
WITH RESULT SETS ((EMPNO int, ENAME varchar(10), SAL float, Bonus float))