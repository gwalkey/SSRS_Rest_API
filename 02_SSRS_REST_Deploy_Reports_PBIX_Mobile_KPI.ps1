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

# Get SSRS Verison
$SSRSVersion  = Invoke-RestMethod "$URI/system" -Method get -UseDefaultCredentials
$SSRSVersion | select ProductName, ProductVersion

Write-Output('Uploading RDL Reports')
# ------------------------------
# Upload Same Report 4 times
# ------------------------------
# Load as Binary Stream of Bytes
$uploadItemPath = 'c:\PSScripts\SSRS_Rest\RDL\Rest Demo.rdl'
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

Write-Output('Uploading PowerBI Reports')
# Upload 10 Power  BI Reports
$AllPBIX = Get-ChildItem -Path 'c:\psscripts\SSRS_Rest\PBIX' -Filter *.pbix
$URI="http://localhost/reports/api/v2.0/PowerBIReports"

foreach($PBIXFile in $AllPBIX)
{
    # Load File
    $SourceItemPath = $PBIXFile.FullName
    $PBIXShortName = $PBIXFile.BaseName
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


Write-Output('Uploading Mobile Reports')
# Upload SSRS Mobile Reports
$AllMobile = Get-ChildItem -LiteralPath 'C:\PSScripts\SSRS_Rest\SSRS_Mobile' -Filter *.rsmobile
$URI="http://localhost/reports/api/v2.0/MobileReports"

foreach($MobileFile in $AllMobile)
{
    # Load File
    $SourceItemPath = $MobileFile.FullName
    $MobileShortName = $MobileFile.BaseName
    $bytes = [System.IO.File]::ReadAllBytes($SourceItemPath)

    # Upload to PBI Server
    $payload = @{
        #"@odata.type" = "#Model.MobileReport";
        "ContentType"="";
        "Content" = [System.Convert]::ToBase64String($bytes);
        "Name" = $MobileShortName;
        "Path" = '/';
    } | ConvertTo-Json
    
    Invoke-WebRequest -Uri $URI -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null
}


# Upload SSRS KPIs
Write-Output('Uploading KPIs')
$AllKPI = Get-ChildItem -LiteralPath 'C:\PSScripts\SSRS_Rest\KPI' -Filter *.json
$URI="http://localhost/reports/api/v2.0/KPIs"

foreach($KPIFile in $AllKPI)
{
    # Load File
    $SourceItemPath = $KPIFile.FullName
    $KPIShortName = $KPIFile.BaseName
    $CatalogItemsUri = $Uri + "/KPI"
    $payload = Get-Content -LiteralPath $SourceItemPath -Raw
    
    Invoke-WebRequest -Uri $URI -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null
}
