<#
.SYNOPSIS
    Gets the local PC Battery Time Remaining and Charge Level
	
.DESCRIPTION

.EXAMPLE
	
.EXAMPLE

.Inputs
    

.Outputs
    json file with WMI Battery Info
	
.NOTES

.LINK
	https://github.com/gwalkey

	
#>


$BattStatus = @{
    ChargeLevel       = (Get-WmiObject win32_battery).estimatedChargeRemaining
    EstimatedRunTime  = (Get-WmiObject win32_battery).estimatedruntime
}

# Serialize to JSON File
$JSonBattery = $BattStatus | ConvertTo-Json
$JSonBattery | out-file -FilePath "c:\psscripts\batterystats.json" -Encoding ascii -Force
$JSonBattery

# Update SQL Table so SSRS KPI DataSet can read it
$RT = $BattStatus['EstimatedRunTime']
if ([long]$RT -gt 86400)
{
    $RT = 'On AC'
}
$PR =$BattStatus['ChargeLevel'] 
$SQLCmd1 = 
"
update OSMetrics.dbo.Metrics
  set Value='$RT', postTime = getdate()
  where Metric='BatteryEstimatedRunTime'
"
$SQLCmd2 = 
"
update OSMetrics.dbo.Metrics
  set Value='$PR', postTime = getdate()
  where Metric='BatteryChargeLevel'
"

$SQLConnectionString = "Data Source=localhost;Initial Catalog=OSMetrics;Integrated Security=SSPI;"
$Connection = New-Object System.Data.SqlClient.SqlConnection
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$Connection.ConnectionString = $SQLConnectionString
$SqlCmd.Connection = $Connection
$Connection.Open() 

# Update First Metric
$SqlCmd.CommandText = $SQLCmd1
try
{
    $ExecResponse = $SqlCmd.ExecuteNonQuery()
}
catch
{
    Write-Output('Cant Connect to SQL to update Run Time')
    exit
}

# Update Next Metric
$SqlCmd.CommandText = $SQLCmd2
try
{
   $ExecResponse = $SqlCmd.ExecuteNonQuery()
}
catch
{
    Write-Output('Cant Connect to SQL to update Percent Remaining')
}
$Connection.Close()

$BattStatus
