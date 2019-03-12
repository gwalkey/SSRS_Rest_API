
# ---
# Create/Modify/Move/Delete SSRS objects using the REST API
# Requires SQL Server Reporting Services 2017+ or the Power BI Reporting Server
# ---

# SwaggerHub API Documentation
# http://app.swaggerhub.com/apis/microsoft-rs/SSRS/2.0

$SSRSServer='localhost'
$URI = "http://$SSRSServer/reports/api/v2.0"

# Get Json
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

# -------------------------------------------
# Show all Webservice Methods using a browser
# -------------------------------------------
Start "http://localhost/reports/browse"

#  All Methods
Start "$URI"

# Subscriptions:
Start "$URI/subscriptions"

# Reports
Start "$URI/Reports"

# KPIs
Start "$URI/KPIs"

# Folder Tree Structure
Start "$URI/Folders"

# Datasources
Start "$URI/DataSources"

# Datasets
Start "$URI/DataSets"

# Catalog Items
Start "$URI/CatalogItems"

# Schedules
Start "$URI/Schedules"

# System
Start "$URI/System"

# Me
Start "$URI/Me"

# Get SSRS Verison
$SSRSVersion  = Invoke-RestMethod "$URI/system" -Method get -UseDefaultCredentials
$SSRSVersion | select ProductName, ProductVersion


# -----------------------------------
# Get all Objects
# -----------------------------------
$response  = Invoke-RestMethod "$URI/CatalogItems" -Method get -UseDefaultCredentials
$response.value | select id,name, Path, Type, ParentFolderID

# Get ID of Root Folder
$response  = Invoke-RestMethod "$URI/CatalogItems?%24filter=contains(Name,'/') and contains(Path,'/')" -Method get -UseDefaultCredentials
$RootFolderID=$response.value | select -expandproperty ID
$RootFolderID
# or
$response  = Invoke-RestMethod "$URI/CatalogItems?%24filter=Path eq Name" -Method get -UseDefaultCredentials
$response.value | select ID, Name, Path

# Get all Objects in Root Folder only
$response  = Invoke-RestMethod "$URI/CatalogItems" -Method get -UseDefaultCredentials
$response.value | where-object {([regex]::Matches($_.Path, "/" )).count -eq 1} | select ID, Name, Path, Type


# SSRS Infomation Methods
# -------------
# My Info
$myInfo = Invoke-RestMethod "$URI/Me" -Method get  -UseDefaultCredentials
$myInfo

# System Info
$mySystem = Invoke-RestMethod "$URI/System" -Method get -UseDefaultCredentials
$mySystem

# Allowed Actions
$mySystemActions = Invoke-RestMethod "$URI/System/AllowedActions" -Method get  -UseDefaultCredentials
$mySystemActions.value

# PDF/Excel Files
$myResources = Invoke-RestMethod "$URI/ExcelWorkbooks" -Method get -UseDefaultCredentials
$myResources.value |convertto-json -Depth 4

# PowerBI Reports
$myResources = Invoke-RestMethod "$URI/PowerBIReports" -Method get -UseDefaultCredentials
$myResources.value |convertto-json -Depth 4

# Other Files (Word, PDF, other)
$myResources = Invoke-RestMethod "$URI/Resources" -Method get -UseDefaultCredentials
$myResources.value |convertto-json -Depth 4

# Notifications - only while Sub running
$myResources = Invoke-RestMethod "$URI/Notifications" -Method get -UseDefaultCredentials
$myResources.value |convertto-json -Depth 4

# Shared Schedules
$myResources = Invoke-RestMethod "$URI/Schedules" -Method get -UseDefaultCredentials
$myResources.value |convertto-json -Depth 4

# Extensions - SSRS ODBC Drivers
$myExtensions = Invoke-RestMethod "$URI/Extensions" -Method get -UseDefaultCredentials
$myResources.value |convertto-json -Depth 4

# ------------------
# Shared DataSources
# ------------------
# Get All
$dsrcAll = Invoke-RestMethod "$URI/DataSources" -Method get -UseDefaultCredentials
$dsrcAll.value | convertto-json

# Get One
$dsrcOne = Invoke-RestMethod "$URI/DataSources(075aefd0-61ec-4fa9-91d0-780f1c0529cf)" -Method get -UseDefaultCredentials
$dsrcOne | convertto-json

# Check Data Connection
$dsrcChkConn = Invoke-RestMethod "$URI/DataSources(075aefd0-61ec-4fa9-91d0-780f1c0529cf)/Model.CheckConnection" -Method post -UseDefaultCredentials
$dsrcChkConn

# Get DataSource actions
$dSrcActions = Invoke-RestMethod "$URI/DataSources(075aefd0-61ec-4fa9-91d0-780f1c0529cf)/AllowedActions" -Method get -UseDefaultCredentials
$dSrcActions.value

# Various Properties
$dsrcProperties = Invoke-RestMethod "$URI/DataSources(075aefd0-61ec-4fa9-91d0-780f1c0529cf)/Properties?properties=Path" -Method get -UseDefaultCredentials
$dsrcProperties.value

$dsrcProperties = Invoke-RestMethod "$URI/DataSources(075aefd0-61ec-4fa9-91d0-780f1c0529cf)/Properties?properties=Description" -Method get -UseDefaultCredentials
$dsrcProperties.value

$dsrcProperties = Invoke-RestMethod "$URI/DataSources(075aefd0-61ec-4fa9-91d0-780f1c0529cf)/Properties?properties=Type" -Method get -UseDefaultCredentials
$dsrcProperties.value


# ----------------
# Shared DataSets
# ----------------
# Get all
$dsetAll = Invoke-RestMethod "$URI/DataSets" -Method get -UseDefaultCredentials
$dsetAll.value | convertto-json -Depth 4

# Get One
$dsetPath = Invoke-RestMethod "$URI/DataSets(path='/Datasets/DS1')" -Method get -UseDefaultCredentials
$dsetPath | convertto-json -Depth 4

# By ID
$dsetID = Invoke-RestMethod "$URI/DataSets(b9cc8585-4ec1-4881-b777-8041fd3edd8a)" -Method get -UseDefaultCredentials
$dsetID | convertto-json -Depth 4


# Get its DataSource
$dsetDataSource = Invoke-RestMethod "$URI/DataSets(b9cc8585-4ec1-4881-b777-8041fd3edd8a)/DataSources" -Method get -UseDefaultCredentials
$dsetDataSource.value | convertto-json -Depth 4

# Get the Dataset Data
$dsGetData = Invoke-RestMethod "$URI/DataSets(b9cc8585-4ec1-4881-b777-8041fd3edd8a)/Model.GetData" -Method post -UseDefaultCredentials
$dsGetData.Columns
$dsGetData.Rows
$dsGetData.Name

#Create DataSet
$DSetJSON=
'
{
    "Name":  "DataSet1",
    "Description":  null,
    "Path":  "/Datasets/DS1",
    "Type":  "DataSet",
    "Hidden":  false,
    "ParentFolderId":  null,
    "ContentType":  null,
    "Content":  "",
    "IsFavorite":  false,
    "Roles":  [

              ],
    "HasParameters":  false,
    "QueryExecutionTimeOut":  0
}
'
$dsNewDataSet =  Invoke-RestMethod "$URI/DataSets" -method post -ContentType 'application/json' -Body $DSetJSON -UseDefaultCredentials

# Assign DataSource to DataSet (Source Driver, Username/Password)
# Not Implemented by Microsoft Yet per this:
Start "https://social.msdn.microsoft.com/Forums/sqlserver/en-US/a9bada65-9f29-4df5-973c-41b89bbed5da/need-example-property-verbs-for-rest-api-for-many-methods?forum=sqlreportingservices"



# ---------
# Folders
# ---------

# Get Folder Info - does not exist
$fldr = Invoke-RestMethod "$URI/CatalogItems(Path='/Reports')" -Method get -UseDefaultCredentials
$fldr

# Add New Folder /Reports
$NewFolderJSON=
'
{
    "Name":  "Reports",
    "Description":  null,
    "Path":  "/,
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false,
    "Roles":  [

              ],
    "ContentType":  null,
    "Content":  ""
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
$myNewFolder

# Get Folder Info - does exist now
$fldr = Invoke-RestMethod "$URI/CatalogItems(Path='/Reports')" -Method get -UseDefaultCredentials
$fldr

# Add New Folder /Accounting
$NewFolderJSON=
'
{
    "Name":  "Accounting",
    "Description":  null,
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false,
    "Roles":  [

              ],
    "ContentType":  null,
    "Content":  ""
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
$myNewFolder

# Add New Folder /Operations
$NewFolderJSON=
'
{
    "Name":  "Operations",
    "Description":  null,
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false,
    "Roles":  [

              ],
    "ContentType":  null,
    "Content":  ""
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
$myNewFolder

# Add New Folder /Operations/Center 1
$NewFolderJSON=
'
{
    "Name":  "Center 1",
    "Description":  null,
    "Path":  "/Operations",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false,
    "Roles":  [

              ],
    "ContentType":  null,
    "Content":  ""
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
$myNewFolder

# Add New Folder /Operations/Center 2
$NewFolderJSON=
'
{
    "Name":  "Center 2",
    "Description":  null,
    "Path":  "/Operations",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false,
    "Roles":  [

              ],
    "ContentType":  null,
    "Content":  ""
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
$myNewFolder


# Delete Folder (and subs)
$myDeletedFolder = Invoke-RestMethod "$URI/Folders(Path='/Operations')" -Method delete  -ContentType 'application/json' -UseDefaultCredentials
$myDeletedFolder


# Get Policy on folder
$fldrPol = Invoke-RestMethod "$URI/Folders(Path='/Operations')/Policies" -Method get -UseDefaultCredentials
$fldrPol
$fldrPol.Policies | convertto-json -Depth 4

# Set New Policy on Folder - Override Inheritance
$NewFolderPolicyJSON=
'
{
    "InheritParentPolicy": false,
    "Policies":  [
                    {
                    "GroupUserName":  "BUILTIN\\Administrators",
                    "Roles":  [
                        {
                            "Name":  "Browser",
                            "Description":  "May view folders, reports and subscribe to reports."
                        },
                        {
                            "Name":  "Content Manager",
                            "Description":  "May manage content in the Report Server.  This includes folders, reports and resources."
                        },
                        {
                            "Name":  "My Reports",
                            "Description":  "May publish reports and linked reports; manage folders, reports and resources in a users My Reports folder."
                        },
                        {
                            "Name":  "Publisher",
                            "Description":  "May publish reports and linked reports to the Report Server."
                        },
                        {
                            "Name":  "Report Builder",
                            "Description":  "May view report definitions."
                        }
                    ]
                    }
                ]
}
'

$myNewFolderPolicy = Invoke-RestMethod "$URI/Folders(Path='/Operations')/Policies" -Method put  -ContentType 'application/json' -Body $NewFolderPolicyJSON -UseDefaultCredentials

# Set New Policy - Revert to Inheritance
$NewFolderPolicyJSON=
'
{
  "InheritParentPolicy": true
}
'
$myNewFolderPolicy = Invoke-RestMethod "$URI/Folders(Path='/Operations')/Policies" -Method put  -ContentType 'application/json' -Body $NewFolderPolicyJSON -UseDefaultCredentials




# -------------
# Catalog Items
# -------------
# Get all the Folders in root
$TLDR = Invoke-RestMethod "$URI/CatalogItems" -Method get -UseDefaultCredentials
$TLDR.Value | sort %_.path | % {Write-Output("{0}, {1}, {2}, {3} " -f $_.path, $_.Name, $_.Type, $_.id)}

# Move Catalog Item - a Report from one folder to another
$MoveJSON=
'
{
  "CatalogItemPaths": [
                        "/Reports/MySSRSReport1"
                      ],
  "TargetPath": "/Accounting"
}
'
Invoke-RestMethod "$URI/CatalogItems/Model.MoveItems" -Method post -ContentType 'application/json' -Body $MoveJSON  -UseDefaultCredentials 

# Move it Back
$MoveJSON=
'
{
  "CatalogItemPaths": [
                        "/Accounting/MySSRSReport1"
                      ],
  "TargetPath": "/Reports"
}
'
Invoke-RestMethod "$URI/CatalogItems/Model.MoveItems" -Method post -ContentType 'application/json' -Body $MoveJSON  -UseDefaultCredentials 


# Hide/UnHide Report
# Get GUID First
# Get Properties
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Voting Booth/ProcessVote')/Properties?properties=ID" -Method get -UseDefaultCredentials
$rptProps.value

$ChangeVisibility=
'
{
    "Hidden" : true
}
'
Invoke-RestMethod "$URI/Reports(4ef49b82-50ea-4722-82a1-badbc4af02c2)" -Method patch -ContentType 'application/json' -Body $ChangeVisibility  -UseDefaultCredentials 

$ChangeVisibility=
'
{
    "Hidden" : false
}
'
Invoke-RestMethod "$URI/Reports(4ef49b82-50ea-4722-82a1-badbc4af02c2)" -Method patch -ContentType 'application/json' -Body $ChangeVisibility  -UseDefaultCredentials 



# -------
# Reports
# -------

# Get all reports
$rpt = Invoke-RestMethod "$URI/Reports" -Method get  -UseDefaultCredentials
$rpt | convertto-json -Depth 6

# Upload a report
$uploadItemPath = 'd:\SSRS\Rest Demo.rdl'
$catalogItemsUri = $Uri + "/CatalogItems"
$bytes = [System.IO.File]::ReadAllBytes($uploadItemPath)
$payload = @{
    "@odata.type" = "#Model.Report";
    "Content" = [System.Convert]::ToBase64String($bytes);
    "ContentType"="";
    "Name" = 'Rest Demo';
    "Path" = '/Operations';
    } | ConvertTo-Json
Invoke-WebRequest -Uri $catalogItemsUri -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null

# Get Properties
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Voting Booth/ProcessVote')/Properties?properties=ID" -Method get -UseDefaultCredentials
$rptProps.value

$rptProps= Invoke-RestMethod "$URI/Reports(path='/Voting Booth/ProcessVote')/Properties" -Method get -UseDefaultCredentials
$rptProps.value


# Get Policies (Role Permissions)
$rptPol = Invoke-RestMethod "$URI/Reports(Path='/Operations/MySSRSReport1')/Policies" -Method get -UseDefaultCredentials
$rptPol.Policies | ConvertTo-Json -Depth 6


# Set New Policy - Override Inheritance
$rptNewRoleJSON=
'
{
  "InheritParentPolicy": false,
  "Policies": [
    {
      "GroupUserName": "BUILTIN\\Administrators",
      "Roles": [
        {
          "Name": "Browser",
          "Description": "May view folders, reports and subscribe to reports."
        },
        {
          "Name": "Content Manager",
          "Description": "May manage content in the Report Server.  This includes folders, reports and resources."
        },
        {
          "Name": "My Reports",
          "Description": "May publish reports and linked reports; manage folders, reports and resources in a users My Reports folder."
        },
        {
          "Name": "Publisher",
          "Description": "May publish reports and linked reports to the Report Server."
        },
        {
          "Name": "Report Builder",
          "Description": "May view report definitions."
        }
      ]
    },
    {
        "GroupUserName":  "owner",
        "Roles":  [
                      {
                          "Name":  "Browser",
                          "Description":  "May view folders, reports and subscribe to reports."
                      }
                  ]
    }
  ]
}
'

$rptChangePolicy = Invoke-RestMethod "$URI/Reports(Path='/Operations/MySSRSReport1')/Policies" -Method put -ContentType 'application/json' -Body $rptNewRoleJSON -UseDefaultCredentials
$rptChangePolicy

# Set New Policy - Revert to Inherited Rights
$rptNewRoleJSON=
'
{
  "InheritParentPolicy": true
}
'

$rptChangePolicy = Invoke-RestMethod "$URI/Reports(Path='/Operations/MySSRSReport1')/Policies" -Method put -ContentType 'application/json' -Body $rptNewRoleJSON -UseDefaultCredentials
$rptChangePolicy


# Dump Report Parameters
$rptParams = Invoke-RestMethod "$URI/Reports(Path='/Operations/Rest Demo')/ParameterDefinitions" -Method get -UseDefaultCredentials

foreach($rptParam in $rptParams.value)
{
    Write-output("Parameter:{0}" -f $rptParam.Name)

    foreach($validValue in $rptParam.ValidValues)
    {
        Write-Output("Valid Value Label:{0}, Value:{1}" -f $validValue.Label, $validValue.value)
    }
}

# Show all Parameter Items
$rptParams.value | ConvertTo-Json -Depth 4


# Change Report Parameter - Set Default - But Cannot Delete values from RDL
$jsonRptParameter=
'
[
    {
        "Name":  "prmStartDate",
        "ParameterType":  "DateTime",
        "ParameterVisibility":  "Visible",
        "ParameterState":  "HasValidValue",
        "ValidValues":  [

                        ],
        "ValidValuesIsNull":  true,
        "Nullable":  false,
        "AllowBlank":  false,
        "MultiValue":  false,
        "Prompt":  "Start Date",
        "PromptUser":  true,
        "QueryParameter":  false,
        "DefaultValuesQueryBased":  true,
        "ValidValuesQueryBased":  false,
        "Dependencies":  [

                         ],
        "DefaultValues":  [
                              "2028-12-31T00:00:00.0000000"
                          ],
        "DefaultValuesIsNull":  false,
        "ErrorMessage":  null
    },
    {
        "Name":  "prmStopDate",
        "ParameterType":  "DateTime",
        "ParameterVisibility":  "Visible",
        "ParameterState":  "HasValidValue",
        "ValidValues":  [

                        ],
        "ValidValuesIsNull":  true,
        "Nullable":  false,
        "AllowBlank":  false,
        "MultiValue":  false,
        "Prompt":  "Stop Date",
        "PromptUser":  true,
        "QueryParameter":  false,
        "DefaultValuesQueryBased":  true,
        "ValidValuesQueryBased":  false,
        "Dependencies":  [
                             "prmStartDate"
                         ],
        "DefaultValues":  [
                              "2028-12-31T00:00:00.0000000"
                          ],
        "DefaultValuesIsNull":  false,
        "ErrorMessage":  null
    },
    {
        "Name":  "rptSite",
        "ParameterType":  "Integer",
        "ParameterVisibility":  "Visible",
        "ParameterState":  "MissingValidValue",
        "ValidValues":  [
                            {
                                "Label":  "1",
                                "Value":  "1"
                            },
                            {
                                "Label":  "2",
                                "Value":  "2"
                            },
                            {
                                "Label":  "3",
                                "Value":  "3"
                            },
                            {
                                "Label":  "4",
                                "Value":  "4"
                            },
                            {
                                "Label":  "5",
                                "Value":  "5"
                            },
                            {
                                "Label":  "6",
                                "Value":  "6"
                            },
                            {
                                "Label":  "7",
                                "Value":  "7"
                            },
                            {
                                "Label":  "8",
                                "Value":  "8"
                            },
                            {
                                "Label":  "9",
                                "Value":  "9"
                            },
                            {
                                "Label":  "10",
                                "Value":  "10"
                            }
                        ],
        "ValidValuesIsNull":  false,
        "Nullable":  false,
        "AllowBlank":  false,
        "MultiValue":  true,
        "Prompt":  "Site",
        "PromptUser":  true,
        "QueryParameter":  true,
        "DefaultValuesQueryBased":  false,
        "ValidValuesQueryBased":  false,
        "Dependencies":  [

                         ],
        "DefaultValues":  [
                            "7"
                          ],
        "DefaultValuesIsNull":  true,
        "ErrorMessage":  null
    }
]
'

Invoke-RestMethod "$URI/Reports(43ca08bd-d182-46a6-81cb-6738f6895494)/ParameterDefinitions" -Method patch -ContentType 'application/json' -Body $jsonRptParameter -UseDefaultCredentials


# Get Properties
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Operations/Rest Demo')/Properties?properties=ID" -Method get -UseDefaultCredentials
$rptProps.value

# ---------------
# Subscriptions
# ---------------
# Create Subscription on Paginated Report
$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub For Center 2",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2018-01-01T08:00:00-04:00",
                                        "EndDate":  "0001-01-01T00:00:00Z",
                                        "EndDateSpecified":  false,
                                        "Recurrence":  {
                                                           "MinuteRecurrence":  null,
                                                           "DailyRecurrence":  null,
                                                           "WeeklyRecurrence":  null,
                                                           "MonthlyRecurrence":  null,
                                                           "MonthlyDOWRecurrence":  null
                                                       }
                                    }
                 },
    "ScheduleDescription":  null,
    "LastRunTime":  null,
    "LastStatus":  "New Subscription",
    "DataQuery":  null,
    "ExtensionSettings":  {
                              "Extension":  "Report Server FileShare",
                              "ParameterValues":  [
                                                      {
                                                          "Name":  "PATH",
                                                          "Value":  "\\\\owner-pc\\c$\\temp",
                                                          "IsValueFieldReference":  false
                                                      },
                                                      {
                                                          "Name":  "FILENAME",
                                                          "Value":  "PBI101",
                                                          "IsValueFieldReference":  false
                                                      },
                                                      {
                                                          "Name":  "FILEEXTN",
                                                          "Value":  "True",
                                                          "IsValueFieldReference":  false
                                                      },
                                                      {
                                                          "Name":  "USERNAME",
                                                          "Value":  "Owner",
                                                          "IsValueFieldReference":  false
                                                      },
                                                      {
                                                          "Name":  "RENDER_FORMAT",
                                                          "Value":  "MHTML",
                                                          "IsValueFieldReference":  false
                                                      },
                                                      {
                                                          "Name":  "WRITEMODE",
                                                          "Value":  "AutoIncrement",
                                                          "IsValueFieldReference":  false
                                                      },
                                                      {
                                                          "Name":  "DEFAULTCREDENTIALS",
                                                          "Value":  "False",
                                                          "IsValueFieldReference":  false
                                                      }
                                                  ]
                          },
    "DeliveryExtension":  "Report Server FileShare",
    "LocalizedDeliveryExtensionName":  null,
    "ParameterValues":  [

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

# Subscription File Share Creds NOT settable in REST API Call, must set password in GUI Portal

# Get All Subscriptions
$AllSubs = Invoke-RestMethod "$URI/Subscriptions" -Method get -UseDefaultCredentials
$AllSubs | convertto-json -Depth 4

# Get Existing Sub Info
$mySub = Invoke-RestMethod "$URI/Subscriptions(8849f2ef-773b-4a04-9d12-8d856ff42b2b)" -Method get -UseDefaultCredentials
$mysub | ConvertTo-Json -Depth 4

# Fire Sub
Invoke-RestMethod "$URI/Subscriptions(02b2d032-2901-42b5-be13-5c3735f3f19b)/Model.Execute" -Method post -ContentType 'application/json' -UseDefaultCredentials



# Change Subscription Owner
$chgSubOwnerJSON=
'
{
    "Owner":  "Owner-PC\\SSRSAdmin"
}
'
Invoke-RestMethod "$URI/Subscriptions(8849f2ef-773b-4a04-9d12-8d856ff42b2b)" -Method patch  -ContentType 'application/json' -Body $chgSubOwnerJSON -UseDefaultCredentials


# Enable Subscription
$mySubOn = Invoke-RestMethod "$URI/Subscriptions(8849f2ef-773b-4a04-9d12-8d856ff42b2b)/Model.Enable" -Method post -UseDefaultCredentials
$mySubOn

# Disable Subscription
$mySubOff = Invoke-RestMethod "$URI/Subscriptions(8849f2ef-773b-4a04-9d12-8d856ff42b2b)/Model.Disable" -Method post -UseDefaultCredentials
$mySubOff

# Delete Subscription
$myDeletedSub = Invoke-RestMethod "$URI/Subscriptions(8849f2ef-773b-4a04-9d12-8d856ff42b2b)" -Method delete -UseDefaultCredentials
$myDeletedSub

# THE GOLDEN TICKET
# Change Subscription Scheduled Time
$SchedChgJSON=
'
{
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2034-12-31T08:00:00-04:00",
                                        "EndDate":  "0001-01-01T00:00:00Z",
                                        "EndDateSpecified":  false,
                                        "Recurrence":  {
                                                           "MinuteRecurrence":  null,
                                                           "DailyRecurrence":  null,
                                                           "WeeklyRecurrence":  null,
                                                           "MonthlyRecurrence":  null,
                                                           "MonthlyDOWRecurrence":  null
                                                       }
                                    }
                 }
}
'
$myNewSchedule = Invoke-RestMethod "$URI/Subscriptions(37bdb102-7d76-476f-be33-c62dc90481dc)" -Method Patch -ContentType 'application/json' -Body $SchedChgJSON -UseDefaultCredentials


# List Paginated RDL Reports
$rpts = Invoke-RestMethod "$URI/Reports" -Method get -UseDefaultCredentials
$rpts.value | ConvertTo-Json -Depth 4

# List KPIs
$myKPIs = Invoke-RestMethod "$URI/KPIs" -Method get -UseDefaultCredentials
$myKPIs.value | ConvertTo-Json -Depth 4

# List Mobile Reports
$myMobiles = Invoke-RestMethod "$URI/MobileReports?`$Count=true" -Method get -UseDefaultCredentials
Write-Output("There are {0} Mobile Reports" -f $myMobiles.'@odata.count')

