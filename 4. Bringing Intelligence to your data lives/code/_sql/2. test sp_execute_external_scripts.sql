--sp_execute_external_script

--example 1
sp_execute_external_script   
    @language	= N'Python' ,   
    @script		= N'print("Hello, ING")'


--example 2
execute sp_execute_external_script 
@language = N'Python',
@script = N'
print([x for x in range(1,100) if x%7==0])
'

--example 3
execute sp_execute_external_script 
@language = N'Python',
@script = N'
OutputDataSet["Multiplu_de_7"] = [x for x in range(1,100) if x%7==0]
'
WITH RESULT SETS ((Multiplu_de_7 int))


--example 4
IF OBJECT_ID('tempdb..#emp') IS NOT NULL
    DROP TABLE #emp

CREATE TABLE #emp(
	[empno]		[int]			NOT NULL
	,[ename]	[varchar](10)	NULL
	,[sal]		[float]			NULL
) 
GO
 
INSERT INTO #emp VALUES
    (1,'Employee1',18000)
INSERT INTO #emp VALUES
    (2,'Employee2',52000)
INSERT INTO #emp VALUES
    (3,'Employee3',25000)

SELECT EMPNO,ENAME,SAL from #emp
 
EXECUTE sp_execute_external_script 
@language = N'Python',
@script=N'
OutputDataSet = InputDataSet
for i in OutputDataSet["sal"]:
	OutputDataSet["Bonus"]=OutputDataSet["sal"]*0.05
',
@input_data_1 = N'SELECT [empno],[ename],sal,0 as Bonus from #emp'
WITH RESULT SETS ((EMPNO int, ENAME varchar(10), SAL float, Bonus float))


--example 5
GO
CREATE PROCEDURE get_bonuses
as
BEGIN

IF OBJECT_ID('tempdb..#emp') IS NOT NULL
	DROP TABLE #emp
IF OBJECT_ID('tempdb..#rez') IS NOT NULL
	DROP TABLE #rez

CREATE TABLE #emp(
	[empno]		[int]			NOT NULL
	,[ename]	[varchar](10)	NULL
	,[sal]		[float]			NULL
) 
	
INSERT INTO #emp VALUES
	(1,'Employee1',18000)
INSERT INTO #emp VALUES
	(2,'Employee2',52000)
INSERT INTO #emp VALUES
	(3,'Employee3',25000)

--SELECT EMPNO,ENAME,SAL from #emp
CREATE TABLE #rez(
[empno]		[int]			NOT NULL
,[ename]	[varchar](10)	NULL
,[sal]		[float]			NULL
,[bonus]	[float]			NULL
) 

insert into #rez --([empno],[ename],[sal],[bonus])
EXECUTE sp_execute_external_script 
@language = N'Python',
@script=N'
OutputDataSet = InputDataSet
for i in OutputDataSet["sal"]:
	OutputDataSet["Bonus"]=OutputDataSet["sal"]*0.05
',
@input_data_1 = N'SELECT [empno],[ename],sal,0 as Bonus from #emp',
@output_data_1_name = N'OutputDataSet';

select * from #rez

END

--exec dbo.get_bonuses