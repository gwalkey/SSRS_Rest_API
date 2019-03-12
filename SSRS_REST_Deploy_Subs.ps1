# ---
# Create/Modify/Move/Delete SSRS objects using the REST API
# Requires SQL Server Reporting Services 2017+ or the Power BI Reporting Server
# ---

# SwaggerHub API Documentation
# http://app.swaggerhub.com/apis/microsoft-rs/SSRS/2.0

$SSRSServer='localhost'
$URI = "http://$SSRSServer/reports/api/v2.0"

# Set TLS on SSL
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;


# ---------------
# Subscriptions
# ---------------
# Create Subscription on Paginated Report
$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 1",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2025-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI1",
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
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 2",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI2",
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
                                "Value":  "2",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 3",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI3",
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
                                "Value":  "3",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 4",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI4",
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
                                "Value":  "4",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 5",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI5",
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
                                "Value":  "5",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 6",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI6",
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
                                "Value":  "6",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 7",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI7",
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
                                "Value":  "7",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 8",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI8",
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
                                "Value":  "8",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 9",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI9",
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
                                "Value":  "9",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials

$json =
'
{
    "IsDataDriven":  false,
    "Description":  "Test Sub 10",
    "Report":  "/Rest Demo 1",
    "IsActive":  true,
    "EventType":  "TimedSubscription",
    "Schedule":  {
                     "ScheduleID":  null,
                     "Definition":  {
                                        "StartDateTime":  "2099-01-01T08:00:00-04:00",
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
                                                          "Value":  "PBI10",
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
                                "Value":  "10",
                                "IsValueFieldReference":  false
                            }

                        ]
}
'
Invoke-RestMethod "$URI/Subscriptions" -Method Post -Body $json -ContentType 'application/json' -UseDefaultCredentials


# Get All Subscriptions
$AllSubs = Invoke-RestMethod "$URI/Subscriptions" -Method get -UseDefaultCredentials
$AllSubs | convertto-json -Depth 4

$mySub = Invoke-RestMethod "$URI/Subscriptions(8eea0ce7-71ac-456b-a581-e646e1975196)" -Method get -UseDefaultCredentials
$mysub | ConvertTo-Json -Depth 4
