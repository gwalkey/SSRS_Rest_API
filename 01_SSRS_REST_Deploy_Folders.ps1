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
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Power BI Reports"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Power BI Reports')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "SQL Alerts",
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "SQL Alerts Dashboards"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/SQL Alerts')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "RDL Reports",
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials


# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Regular Paginated Reports"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/RDL Reports')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Weapons Systems",
    "Description":  "",
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

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "SciFi Users Manual"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Neuralizer",
    "Path":  "/Weapons Systems",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "MIB Standard Issue"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/Neuralizer')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "Phaser",
    "Description":  null,
    "Path":  "/Weapons Systems",
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

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Handheld"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/Phaser')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "Photon Torpedos",
    "Description":  null,
    "Path":  "/Weapons Systems",
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


# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Variable Yield"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/Photon Torpedos')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "Quantum Torpedos",
    "Path":  "/Weapons Systems",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "For Borg Spheres and Cubes"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/Quantum Torpedos')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "Spatial Mines",
    "Description":  null,
    "Path":  "/Weapons Systems",
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


# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Blows Holes in Ships"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/Spatial Mines')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "Jacketed Protons",
    "Path":  "/Weapons Systems",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Dowd Ghost Ship Weapon"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/Jacketed Protons')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "3D RailGun",
    "Path":  "/Weapons Systems",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Ferengi Product Development Branch"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Weapons Systems/3D Railgun')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "Hyperdrive Spares",
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Tatooine Resellers Association"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Hyperdrive Spares')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



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
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Burn Notice"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Operations')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "Michael Westin",
    "Path":  "/Operations",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "I used to be a Spy"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Operations/Michael Westin')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "Victor",
    "Path":  "/Operations",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Daniel Jackson from Stargate SG-1"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Operations/Victor')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "Blake",
    "Path":  "/Operations",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Cigar chompin Baddie"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Operations/Blake')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "Carla",
    "Path":  "/Operations",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "Retired Operative"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Operations/Carla')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials



$NewFolderJSON=
'
{
    "Name":  "Fusion Reactors",
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Update Folder Description
$JsonProperty=
'
[
    {
       "Name": "Description",
       "Value": "1.21 Gigawatts"
    }
]
'
$rptProps= Invoke-RestMethod "$URI/Folders(path='/Fusion Reactors')/Properties" -Method put  -ContentType 'application/json' -Body $JsonProperty -UseDefaultCredentials


$NewFolderJSON=
'
{
    "Name":  "Avengers",
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "Size":  0,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Iron Man",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Captain America",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false

}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Doctor Strange",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Black Widow",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Gamora",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Star Lord",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Rocket",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Cute Newt Groot",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Loki",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Vision",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Black Panther",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "SpiderMan",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Thor",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "The Hulk Insert",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$NewFolderJSON=
'
{
    "Name":  "Thanos",
    "Path":  "/Avengers",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

# Create 100 SubFolders
$NewFolderJSON=
'
{
    "Name":  "100 Folders",
    "Path":  "/",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
$myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials

$FolderJSON= '
{
    "Name":  "VVV",
    "Path":  "/100 Folders",
    "Type":  "Folder",
    "Hidden":  false,
    "ParentFolderId":  null,
    "IsFavorite":  false
}
'
1..100 | foreach {
    "Center $_"
    $NewFolderJSON= $FolderJSON.replace("VVV","Center $_")
    $myNewFolder = Invoke-RestMethod "$URI/Folders" -Method post -ContentType 'application/json' -Body $NewFolderJSON -UseDefaultCredentials
}

