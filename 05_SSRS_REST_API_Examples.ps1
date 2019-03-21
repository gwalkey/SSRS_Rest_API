
# ---
# Create/Modify/Move/Delete SSRS objects using the REST API
# Requires SQL Server Reporting Services 2017+ or the Power BI Reporting Server
# ---

# SwaggerHub API Documentation
# http://app.swaggerhub.com/apis/microsoft-rs/SSRS/2.0

$SSRSServer='localhost'
$URI = "http://$SSRSServer/reports/api/v2.0"

# Set TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;


# Get SSRS Verison
$SSRSVersion  = Invoke-RestMethod "$URI/system" -Method get -UseDefaultCredentials
$SSRSVersion | select ProductName, ProductVersion


# ---------
# Folders
# ---------

# Get Folder Info - does not exist
$fldr = Invoke-RestMethod "$URI/CatalogItems(Path='/Reports2')" -Method get -UseDefaultCredentials
$fldr

# Add New Folder /Reports
$NewFolderJSON=
'
{
    "Name":  "Reports2",
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

# Get Folder Info - does exist now
$fldr = Invoke-RestMethod "$URI/CatalogItems(Path='/Reports2')" -Method get -UseDefaultCredentials
$fldr


# Get Policy on folder
$fldrPol = Invoke-RestMethod "$URI/Folders(Path='/Operations')/Policies" -Method get -UseDefaultCredentials
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

# Move Catalog Item - a Report from one folder to another
$MoveJSON=
'
{
  "CatalogItemPaths": [
                        "/Rest Demo 4"
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
                        "/Accounting/Rest Demo 4"
                      ],
  "TargetPath": "/"
}
'
Invoke-RestMethod "$URI/CatalogItems/Model.MoveItems" -Method post -ContentType 'application/json' -Body $MoveJSON  -UseDefaultCredentials 


# Hide/UnHide Report
# Get GUID First
# Get Properties
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Rest Demo 1')/Properties?properties=ID" -Method get -UseDefaultCredentials
$ReportGUID = $rptProps.value.value

$ChangeVisibility=
'
{
    "Hidden" : true
}
'
Invoke-RestMethod "$URI/Reports($ReportGUID)" -Method patch -ContentType 'application/json' -Body $ChangeVisibility  -UseDefaultCredentials 

$ChangeVisibility=
'
{
    "Hidden" : false
}
'
Invoke-RestMethod "$URI/Reports($ReportGUID)" -Method patch -ContentType 'application/json' -Body $ChangeVisibility  -UseDefaultCredentials 



# -------
# Reports
# -------

# Get all reports
$rpt = Invoke-RestMethod "$URI/Reports" -Method get  -UseDefaultCredentials
$rpt | convertto-json -Depth 4

# Get Properties
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Rest Demo 1')/Properties?properties=ID" -Method get -UseDefaultCredentials
$rptProps.value

# Get Multiple Properties
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Rest Demo 1')/Properties?properties=ID,Name,Path,Type,Hidden,Size,ModifiedBy,ModifiedDate" -Method get -UseDefaultCredentials
$rptProps.value

# Get Policies (Role Permissions) (AKA Security ACLs)
$rptPol = Invoke-RestMethod "$URI/Reports(Path='/Rest Demo 1')/Policies" -Method get -UseDefaultCredentials
$rptPol| ConvertTo-Json -Depth 4


# Set New Policy - Override Inheritance - Add Jimmy Dean so he can be made Subscription Owner below
$rptNewRoleJSON=
'
{
    "InheritParentPolicy":  false,
    "Policies":  [
                     {
                         "GroupUserName":  "BUILTIN\\Administrators",
                         "Roles":  [
                                       {
                                           "Name":  "Content Manager",
                                           "Description":  null
                                       }
                                   ]
                     },
                     {
                         "GroupUserName":  "Owner-PC\\Jimmy.Dean",
                         "Roles":  [
                                       {
                                           "Name":  "Content Manager",
                                           "Description":  "May manage content in the Report Server.  This includes folders, reports and resources."
                                       }
                                   ]
                     }
                 ]
}
'
$rptChangePolicy = Invoke-RestMethod "$URI/Reports(Path='/Rest Demo 1')/Policies" -Method put -ContentType 'application/json' -Body $rptNewRoleJSON -UseDefaultCredentials


# Set New Policy - Revert to Inherited Rights
$rptNewRoleJSON=
'
{
  "InheritParentPolicy": true
}
'

$rptChangePolicy = Invoke-RestMethod "$URI/Reports(Path='/Rest Demo 1')/Policies" -Method put -ContentType 'application/json' -Body $rptNewRoleJSON -UseDefaultCredentials



# Change Report Parameter - You can Set the Default - But cannot Delete Values from the published RDL
# Get ID First
$rptProps= Invoke-RestMethod "$URI/Reports(path='/Rest Demo 1')/Properties?properties=ID" -Method get -UseDefaultCredentials
$ReportGuid = $rptProps.value.value

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
                              "2000-12-31T00:00:00.0000000"
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

Invoke-RestMethod "$URI/Reports($ReportGuid)/ParameterDefinitions" -Method patch -ContentType 'application/json' -Body $jsonRptParameter -UseDefaultCredentials


# ---------------
# Subscriptions
# ---------------
# Create Subscription on Paginated Report - Without SAVED Credentials 
# "As User running the Report" = (No User is logged-in when run from a Subscription - AKA Agent Job)
$jsonSub =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub For Center 7",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2031-01-01T08:00:00-04:00",
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
                                                          "Value":  "Rest Demo 1",
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
                            {
                                "Name":  "rptSite",
                                "Value":  "1",
                                "IsValueFieldReference":  false
                            },
                            {
                                "Name":  "rptSite",
                                "Value":  "2",
                                "IsValueFieldReference":  false
                            },
                            {
                                "Name":  "rptSite",
                                "Value":  "3",
                                "IsValueFieldReference":  false
                            },
                            {
                                "Name":  "rptSite",
                                "Value":  "7",
                                "IsValueFieldReference":  false
                            }
                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $jsonSub -ContentType 'application/json' -UseDefaultCredentials


# Subscription File Share Credentials are NOT settable using the REST API, must set passwords in the GUI/Portal
# DEMO = Get the Subscription GUID from the Portal URL

# Get Subscription using OData filter
$MySub = Invoke-RestMethod "$URI/Subscriptions?`$filter=Description eq 'Test Sub For Center 7'" -Method get -UseDefaultCredentials
$MySubGuid = $mySub.value.ID
$MySubGuid

# Get One Sub Info
$mySub = Invoke-RestMethod "$URI/Subscriptions($MySubGuid)" -Method get -UseDefaultCredentials
$mysub | ConvertTo-Json -Depth 4

# Change Subscription Owner - The User must have rights to be Sub Owner (Content Manager) and the DataSource must have Saved Creds
$chgSubOwnerJSON=
'
{
    "Owner":  "Owner-PC\\Jimmy.Dean"
}
'
Invoke-RestMethod "$URI/Subscriptions($MySubGuid)" -Method patch  -ContentType 'application/json' -Body $chgSubOwnerJSON -UseDefaultCredentials


# Enable Subscription
$mySubOn = Invoke-RestMethod "$URI/Subscriptions($MySubGuid)/Model.Enable" -Method post -UseDefaultCredentials
$mySubOn

# Disable Subscription
$mySubOff = Invoke-RestMethod "$URI/Subscriptions($MySubGuid)/Model.Disable" -Method post -UseDefaultCredentials
$mySubOff

# Delete Subscription
$myDeletedSub = Invoke-RestMethod "$URI/Subscriptions($MySubGuid)" -Method delete -UseDefaultCredentials
$myDeletedSub

# Fire Sub - MUST Set the Subscription FileShare Creds First
Invoke-RestMethod "$URI/Subscriptions($MySubGuid)/Model.Execute" -Method post -ContentType 'application/json' -UseDefaultCredentials


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
                 },
    "ParameterValues":  [
                            {
                                "Name":  "rptSite",
                                "Value":  "7",
                                "IsValueFieldReference":  false
                            },
                            {
                                "Name":  "rptSite",
                                "Value":  "8",
                                "IsValueFieldReference":  false
                            }
                        ]
}
'
$myNewSchedule = Invoke-RestMethod "$URI/Subscriptions($MySubGuid)" -Method Patch -ContentType 'application/json' -Body $SchedChgJSON -UseDefaultCredentials



# -------------------------
# Informational API Methods
# -------------------------

# List Paginated RDL Reports
$rpts = Invoke-RestMethod "$URI/Reports" -Method get -UseDefaultCredentials
$rpts.value | ConvertTo-Json -Depth 4

# List KPIs
$myKPIs = Invoke-RestMethod "$URI/KPIs" -Method get -UseDefaultCredentials
$myKPIs.value | ConvertTo-Json -Depth 4

$myKPI = Invoke-RestMethod "$URI/KPIs(path='/Battery Charge')" -Method get -UseDefaultCredentials
$myKPI| ConvertTo-Json -Depth 4

# List Mobile Reports
$myMobiles = Invoke-RestMethod "$URI/MobileReports?`$Count=true" -Method get -UseDefaultCredentials
Write-Output("There are {0} Mobile Reports" -f $myMobiles.'@odata.count')

# Get all Objects
$response  = Invoke-RestMethod "$URI/CatalogItems" -Method get -UseDefaultCredentials
$response.value | select id,name, Path, Type, ParentFolderID

# ODATA Verbs
# Get ID of Root Folder using ODATA Verbs FILTER CONTAINS
$response  = Invoke-RestMethod "$URI/CatalogItems?`$filter=contains(Name,'/') and contains(Path,'/')" -Method get -UseDefaultCredentials
$RootFolderID=$response.value | select -expandproperty ID
$RootFolderID
# or
$response  = Invoke-RestMethod "$URI/CatalogItems?`$filter=Path eq Name" -Method get -UseDefaultCredentials
$response.value | select ID, Name, Path

# Get all Objects in Root Folder only
$response  = Invoke-RestMethod "$URI/CatalogItems" -Method get -UseDefaultCredentials
$response.value | where-object {([regex]::Matches($_.Path, "/" )).count -eq 1} | select ID, Name, Path, Type


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

'
$dsNewDataSet =  Invoke-RestMethod "$URI/DataSets" -method post -ContentType 'application/json' -Body $DSetJSON -UseDefaultCredentials

# Assign DataSource to DataSet (Source Driver, Username/Password)
# Not Implemented by Microsoft Yet per this:
Start "https://social.msdn.microsoft.com/Forums/sqlserver/en-US/a9bada65-9f29-4df5-973c-41b89bbed5da/need-example-property-verbs-for-rest-api-for-many-methods?forum=sqlreportingservices"


# ---------------------------------------------------------
# Show all Webservice Methods using a browser (Get Methods)
# ---------------------------------------------------------

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