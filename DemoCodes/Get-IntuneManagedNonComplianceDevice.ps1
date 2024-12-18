###########################################################################

#Get-IntuneManagedNonComplianceDevices.ps1

#Scope : This script will retrive Microsoft Intune Non-Compliance Devices 

#Author : Sujin Nelladath

#LinkedIn : https://www.linkedin.com/in/sujin-nelladath-8911968a/

############################################################################

# Connect to Microsoft Graph API with required permission

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install-Module Microsoft.Graph -Scope CurrentUser -force


Connect-MGGraph -Scopes DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All

# Define the API endpoint for Intune devices

$endpoint = 'https://graph.microsoft.com/v1.0/deviceManagement/managedDevices'

# Get all managed devices

$devices = Invoke-MgGraphRequest -Uri $endpoint -Method GET

# Filter non-compliant devices

$nonCompliantDevices = $devices.value | Where-Object { $_.complianceState -eq "noncompliant" }

# Create a PS Object


$pSObject = [PSCustomObject]@{
    DeviceName = $nonCompliantDevices.deviceName
    ComplianceState = $nonCompliantDevices.complianceState
}

# List of Non-Compliant Devices
$nonCompliantDeviceDetails = @()
for ($i = 0; $i -lt $pSObject.DeviceName.Count; $i++) {
    $nonCompliantDeviceDetails += [PSCustomObject]@{
        DeviceName = $pSObject.DeviceName[$i]
        ComplianceState = $pSObject.ComplianceState[$i]
    }
}

#Display the Non-Compliant Devices

$nonCompliantDeviceDetails