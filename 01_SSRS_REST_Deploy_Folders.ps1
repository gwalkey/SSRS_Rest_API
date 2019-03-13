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



# Get SSRS Verison
$SSRSVersion  = Invoke-RestMethod "$URI/system" -Method get -UseDefaultCredentials
$SSRSVersion | select ProductName, ProductVersion


# ---------
# Create Folders
# ---------

$NewFolderJSON=
'
{
    "Name":  "Power BI Reports",
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



$NewFolderJSON=
'
{
    "Name":  "Reports",
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


$NewFolderJSON=
'
{
    "Name":  "Jacketed Protons",
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


$NewFolderJSON=
'
{
    "Name":  "Hyperdrive Spares",
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

$NewFolderJSON=
'
{
    "Name":  "Klingon Treaties",
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

$NewFolderJSON=
'
{
    "Name":  "Khittomer",
    "Description":  null,
    "Path":  "/Klingon Treaties",
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
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials -TimeoutSec 90


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

$NewFolderJSON=
'
{
    "Name":  "Fusion Reactors",
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


$NewFolderJSON=
'
{
    "Name":  "Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Iron Man",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Captain America",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Doctor Strange",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Black Widow",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Gamora",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Star Lord",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Rocket",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Cute Newt Groot",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Loki",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Vision",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Black Panther",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "SpiderMan",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Thor",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "The Hulk Insert",
    "Description":  null,
    "Path":  "/Avengers",
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

$NewFolderJSON=
'
{
    "Name":  "Thanos",
    "Description":  null,
    "Path":  "/Avengers",
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

# Create 100 SubFolders
$NewFolderJSON=
'
{
    "Name":  "100 Regions",
    "Description":  null,
    "Path":  "/",
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

$FolderJSON= '
{
    "Name":  "VVV",
    "Description":  null,
    "Path":  "/100 Regions",
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
1..100 | foreach {
    $_
    $NewFolderJSON= $FolderJSON.replace("VVV",$_)
    $myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
}


$AllSubs = Invoke-RestMethod "$URI/Folders" -Method get -UseDefaultCredentials
$AllSubs.value | select path| sort path