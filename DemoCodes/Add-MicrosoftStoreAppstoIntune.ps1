#Connect to MgGraph

Connect-MgGraph -Scopes DeviceManagementApps.ReadWrite.All

#Graph URL 
$CreateAPP_URL = "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps"  
   
#Request body 
                        
$body = @"
{
`"@odata.type`": `"#microsoft.graph.winGetApp`",
`"displayName`": `"7 Zip- Sujin test`",
`"description`": `"HTMD graph API Testing`",
`"publisher`"  : `"Microsoft`",
`"packageIdentifier`": `"XPFM275LQF9R3S`",
`"owner`"      : `"Sujin Nelladath`",
`"installExperience`": {
    `"runAsAccount`": `"user`"
}
}
"@

Invoke-MgGraphRequest -Uri $CreateAPP_URL -Method POST -Body $Body