SELECT
   @@version							as Version,
   SERVERPROPERTY ( 'ProductVersion' )	as Version,
   SERVERPROPERTY ( 'ProductLevel' )	as CTPVersion,
   SERVERPROPERTY ( 'Edition' )			as Edition
GO