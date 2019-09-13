# ---
# Update SSRS Report Data Sources
# ---

$SSRSServer='localhost'
$URI = "http://$SSRSServer/reports/api/v2.0"

# Turn On TLS over SSL
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

# -------------------------------------------------
# Change Datasource Creds on Report "Rest Demo 1"
# -------------------------------------------------
$rpt= Invoke-RestMethod "$URI/Reports(path='/Rest Demo 1')" -Method get -UseDefaultCredentials
$rptID = $rpt.Id

$rptProps= Invoke-RestMethod "$URI/Reports($rptID)/DataSources" -Method get -UseDefaultCredentials
$rptProps.value[0]

# Set Breakpoint Here
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
