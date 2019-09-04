### Steps to Create the BatteryLevel KPI

1) Create a SQL Server Database with SQL Script *1 - Create Database.sql*
2) Create Table in database with SQL script *2 - Create Table.sql*
3) Create a SQL Agent job that calls the Powershell script with *3 - Create SQL Agent Job.sql*
4) Create a work folder C:\PSScripts and place the Powershell script there
5) Make sure the SQL Agent Job is updating the Metrics SQL table (SSMS)
6) Upload the KPI using a modified version of the demo Powershell script *02_SSRS_REST_Deploy_Reports_PBIX_Mobile_KPI.ps1*
(you cannot upload KPI JSON fragment straight into the SSRS Portal)
7) Create a Shared Datasource in the SSRS Portal (The API does not support creating DataSources), and connect it to 
the Metrics Table with your own credentials (Windows or SQL Auth login and User) and verify the connection works.
8) Upload the SharedDataset *OSMetrics.rsd*
Now the KPI should work and read from the SQL Table
