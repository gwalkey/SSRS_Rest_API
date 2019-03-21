<#
.SYNOPSIS
    Updates ALL SSRS Reports Datasources Username/Password with new values
	
.DESCRIPTION
    Updates ALL SSRS Reports Datasources Username/Password with new values
	
.EXAMPLE
    

.Inputs


.Outputs

	
.NOTES
    
	
.LINK
    https://github.com/gwalkey
	
#>

Set-StrictMode -Version latest;

$SSRSServer='localhost'
$URI = "http://$SSRSServer/reports/api/v2.0"

# TLS 1.2 Needed if running with Modern Cert on SSRS Server
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

# Variables
$OldDSUsername = 'owner'
$NewDSUserName ='rdemo'
$NewDSPassword='rdemo'

# Get All Reports
$ALLRpts = Invoke-RestMethod "$URI/Reports" -Method get -UseDefaultCredentials

foreach ($Rpt in $ALLRpts.value)
{
    # Get Each Report's DataSources
    $RPTID = $Rpt.ID
    try
    {
        $rptProps= Invoke-RestMethod "$URI/Reports($RPTID)/DataSources" -Method get -UseDefaultCredentials
    }
    catch
    {
        Write-Output('API Error: [{0}]' -f $Error[0])      
    }   
    
    # Show Report Name  
    Write-Output('Checking: [{0}] ' -f $Rpt.path)

    # Only Scan Reports with Datasources
    if ($rptProps.value.Count -eq 0)
    {
        Write-Warning('Skipping - No Datasources')
        continue
    }

    # Show/Fix each DataSource
    [int]$i=0
    $changefound=$false   

    # Check Each DataSource in the Report
    #foreach($DSRC in $rptprops.value.credentialsinserver)
    foreach($DSRC in $rptprops.value)
    {
        # Skip Non-Stored Credential Datasources
        #if ($rptProps.value[$i].CredentialRetrieval -ne 'store')
        if ($DSRC.CredentialRetrieval -ne 'store')
        {
            $i++
            continue
        }

        # Change Datasource SQL Creds
        if ($DSRC.CredentialsInServer.UserName -ilike $OldDSUsername)
        {
            Write-Output('Credential Match Found: ReportName:[{0}], Path:[{1}], UserName:[{2}]' -f $Rpt.Name,$Rpt.path,$DSRC.CredentialsInServer.UserName)
            $changefound=$true
            $rptProps.value[$i].credentialsinserver.username = $NewDSUserName
            $rptProps.value[$i].credentialsinserver.password = $NewDSPassword
        }

        # Advance array index pointer to $rptprops
        $i++
    }

    # If Credential match Found, Update Report DataSources using REST API
    if ($changefound)
    {
        $newJSON = $rptProps.value | ConvertTo-Json
        Invoke-RestMethod "$URI/Reports($RPTID)/DataSources" -Method Put -ContentType 'application/json' -Body $NewJSON -UseDefaultCredentials
        Write-Output('Updated Credentials for Report:[{0}]' -f $Rpt.path)
    }

}
