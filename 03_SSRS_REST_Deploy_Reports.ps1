# ---
# Upload RDL and PBIX files using the REST API
# Requires SQL Server Reporting Services 2017+ or the Power BI Reporting Server
# ---

# https://raw.githubusercontent.com/Microsoft/Reporting-Services/master/APISamples/powershell/powershellSamples.ps1

# Copyright (c) 2016 Microsoft Corporation. All Rights Reserved.
# Licensed under the MIT License (MIT)

<#============================================================================
  File:     powershellSamples.ps1
  Summary:  Demonstrates examples to upload/download/delete an item in RS. 
--------------------------------------------------------------------
    
 This source code is intended only as a supplement to Microsoft
 Development Tools and/or on-line documentation. See these other
 materials for detailed information regarding Microsoft code 
 samples.
 THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
 ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
 THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 PARTICULAR PURPOSE.
===========================================================================#>

$SSRSServer='localhost'
$URI = "http://$SSRSServer/reports/api/v2.0"

# Set TLS on SSL
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;


# ------------------------------
# Upload Same Report 4 times
# ------------------------------
# Load as Binary Stream of Bytes
$uploadItemPath = 'c:\PSScripts\SSRS_Rest\Rest Demo.rdl'
$catalogItemsUri = $Uri + "/CatalogItems"
$bytes = [System.IO.File]::ReadAllBytes($uploadItemPath)

$payload = @{
    "@odata.type" = "#Model.Report";
    "Content" = [System.Convert]::ToBase64String($bytes);
    "ContentType"="";
    "Name" = 'Rest Demo 1';
    "Path" = '/';
    } | ConvertTo-Json
Invoke-WebRequest -Uri $catalogItemsUri -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null

$payload = @{
    "@odata.type" = "#Model.Report";
    "Content" = [System.Convert]::ToBase64String($bytes);
    "ContentType"="";
    "Name" = 'Rest Demo 2';
    "Path" = '/';
    } | ConvertTo-Json
Invoke-WebRequest -Uri $catalogItemsUri -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null

$payload = @{
    "@odata.type" = "#Model.Report";
    "Content" = [System.Convert]::ToBase64String($bytes);
    "ContentType"="";
    "Name" = 'Rest Demo 3';
    "Path" = '/';
    } | ConvertTo-Json
Invoke-WebRequest -Uri $catalogItemsUri -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null

$payload = @{
    "@odata.type" = "#Model.Report";
    "Content" = [System.Convert]::ToBase64String($bytes);
    "ContentType"="";
    "Name" = 'Rest Demo 4';
    "Path" = '/';
    } | ConvertTo-Json
Invoke-WebRequest -Uri $catalogItemsUri -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null

# ------------------------
# Upload Power BI Reports
# ------------------------
$AllPBIX = Get-ChildItem -LiteralPath 'C:\psscripts\SSRS_Rest\PBIX\' -Filter *.pbix
$URI="http://localhost/reports/api/v2.0/PowerBIReports"

foreach($PBIXFile in $AllPBIX)
{
    # Load File
    $SourceItemPath = $PBIXFile.FullName
    $PBIXShortName = $PBIXFile.BaseName
    $CatalogItemsUri = $Uri + "/CatalogItems"
    $bytes = [System.IO.File]::ReadAllBytes($SourceItemPath)

    # Upload to PBI Server
    $payload = @{
        "@odata.type" = "#Model.PowerBIReport";
        "Content" = [System.Convert]::ToBase64String($bytes);
        "Name" = $PBIXShortName;
        "Path" = '/Power BI Reports';
    } | ConvertTo-Json
    
    Invoke-WebRequest -Uri $URI -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null
}

# ------------
# Deploy KPIs
# ------------
$URI="http://localhost/reports/api/v2.0/Kpis"
$myKPI = Get-Content -LiteralPath 'C:\PSScripts\SSRS_Rest\SampleKPI.json' 
Invoke-RestMethod $Uri -Method post -Body $myKPI -ContentType 'application/json'  -UseDefaultCredentials | Out-Null

$URI="http://localhost/reports/api/v2.0/Kpis"
$myKPI = Get-Content -LiteralPath 'C:\PSScripts\SSRS_Rest\BatteryLevel_KPI.json' 
Invoke-RestMethod $Uri -Method post -Body $myKPI -ContentType 'application/json'  -UseDefaultCredentials | Out-Null


# -----------------------------
# Deploy DataZen Mobile Reports
# -----------------------------
$AllDZ = Get-ChildItem -LiteralPath 'C:\PSScripts\SSRS_Rest\SSRS_Mobile\' -Filter *.rsmobile
$URI="http://localhost/reports/api/v2.0/MobileReports"

foreach($DZFile in $AllDZ)
{
    # Load File
    $SourceItemPath  = $DZFile.FullName
    $DZShortName     = $DZFile.BaseName
    $CatalogItemsUri = $Uri + "/CatalogItems"
    $bytes = [System.IO.File]::ReadAllBytes($SourceItemPath)

    # Upload to PBI Server
    $payload = @{
        "@odata.type" = "#Model.MobileReport";
        "Content" = [System.Convert]::ToBase64String($bytes);
        "Name" = $DZShortName;
        "Path" = '/';
    } | ConvertTo-Json
    
    Invoke-WebRequest -Uri $URI -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null
}
