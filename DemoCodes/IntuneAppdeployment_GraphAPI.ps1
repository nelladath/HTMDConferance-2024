cls

##########################################################################

#IntuneAppdeployment_GraphAPI.ps1
#Scope : This script will create a new Store App deployment in Intune
#Author : Sujin Nelladath
#LinkedIn : https://www.linkedin.com/in/sujin-nelladath-8911968a/

############################################################################


#Connect to MgGraph

Connect-MgGraph -Scopes DeviceManagementApps.ReadWrite.All

#Graph URL to get APP id and Group ID. Replace the group and app name
$AppIDURL = 'https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?$filter=displayName eq ''My Git - HTMD Conferance'' and (isof(''microsoft.graph.winGetApp''))&$select=id'
$GroupIDURL = 'https://graph.microsoft.com/v1.0/groups?$filter=displayName eq ''HTMD - Test Computers''&$select=id' 

#Get App ID

$invokeAppID = Invoke-MgGraphRequest -Uri $AppIDURL  -Method GET 

$JSONAppID = $invokeAppID  | ConvertTo-Json
$JS = $JSONAppID | ConvertFrom-Json
$AppID = $JS.value.id

#Get Group ID

$invokeGroupID = Invoke-MgGraphRequest -Uri $GroupIDURL  -Method GET 

$JSONGrpID = $invokeGroupID  | ConvertTo-Json
$JSgrp = $JSONGrpID | ConvertFrom-Json
$GrpID = $JSgrp.value.id



   
#Request body 

$body = @"
{
    `"target`": {
        `"@odata.type`": `"#microsoft.graph.groupAssignmentTarget`",
        `"groupId`": `"$GrpID`"
    },
    `"intent`": `"required`",
    `"settings`": {
        `"@odata.type`": `"#microsoft.graph.winGetAppAssignmentSettings`",
        `"installTimeSettings`": {
            `"deadlineDateTime`": `"2024-12-12T23:59:59Z`"
        }
    }
}
"@
 
#Create ApplicaionAssignment

$CreateAPP = "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$AppID/assignments"

$invokeAppCreate =  Invoke-MgGraphRequest -Uri $CreateAPP -Method POST -Body $body 

Write-Host "The application has been deployed" -ForegroundColor Green

