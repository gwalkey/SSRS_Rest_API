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

# -------------------------------------------------
# Change Datasource Creds on Report "Rest Demo 1"
# -------------------------------------------------
$rpt= Invoke-RestMethod "$URI/Reports(path='/Rest Demo 1')" -Method get -UseDefaultCredentials
$rptID = $rpt.Id

$rptProps= Invoke-RestMethod "$URI/Reports($rptID)/DataSources" -Method get -UseDefaultCredentials
$rptProps.value[0]
$rptProps.value[0].CredentialRetrieval='store'

# Add Property to Object
if ($rptProps.value[0].CredentialsInServer -eq $null)
{
    $myObject = [PSCustomObject]@{
        UserName = 'rdemo'
        Password = 'rdemo'
        UseAsWindowsCredentials = 'false'
        ImpersonateAuthenticatedUser = 'false'
    }

    $rptProps.value[0].PSObject.Properties.Remove('CredentialsInServer')
    Add-Member -InputObject $rptProps.value[0] -MemberType NoteProperty -Name CredentialsInServer -Value $myObject
}
else
{
    $rptProps.value[0].CredentialsInServer.UserName='rdemo'
    $rptProps.value[0].CredentialsInServer.Password='rdemo'
    $rptProps.value[0].CredentialsInServer.UseAsWindowsCredentials=$false
    $rptProps.value[0].CredentialsInServer.ImpersonateAuthenticatedUser=$false
}
  
$newJSON = $rptProps.value | convertto-json -Depth 4
$newJSON = '['+$newJSON  +']'

$params = @{
    ContentType = 'application/json'
    Headers = @{'accept'='application/json'}
    Body = $newJSON
    Method = 'Put'
    URI = $URI+'/Reports('+$RPTID+')/DataSources'
}

try
{
    Invoke-RestMethod @params  -UseDefaultCredentials -ErrorAction Stop
}
catch {

    $_.Exception.Response
    
    $_.Exception.Message
    
    $_.ErrorDetails.Message    
 }
