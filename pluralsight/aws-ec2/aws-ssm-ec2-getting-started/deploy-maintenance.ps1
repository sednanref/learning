Set-AWSCredential -StoreAs globomantics -AccessKey "AKIAIOHZDQUWZXOYIFXQ" `
-SecretKey "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"
Initialize-AWSDefaultConfiguration -Region "ap-southeast-2" -ProfileName globomantics

$VerbosePreference = 'Continue'
Function Wait-Stack
{
  param(
    [string]$StackName
  )
  $Status = (Get-CFNStack -StackName $StackName).StackStatus

  while ($Status -ne 'CREATE_COMPLETE'){
    Write-Verbose "Waiting for stack creation to complete $StackName"
    Start-Sleep -Seconds 5
    $Status = (Get-CFNStack -StackName $StackName).StackStatus
  }
}

$tagOwner = New-Object Amazon.CloudFormation.Model.Tag
$tagOwner.Key = "Owner"
$tagOwner.Value = "dave"

New-CFNStack -Capability CAPABILITY_IAM -StackName ssm-mw-iam-prereq -TemplateBody $(Get-Content .\ssm-mw-iam-role.yml -Raw) -Tag $tagOwner
Wait-Stack -StackName ssm-mw-iam-prereq

New-CFNStack -Capability CAPABILITY_IAM -StackName ssm-patchbaseline-2016 -TemplateBody $(Get-Content .\ssm-patchbaseline.yml -Raw) -Tag $tagOwner
Wait-Stack -StackName ssm-patchbaseline-2016

New-CFNStack -Capability CAPABILITY_IAM -StackName ssm-maintenancewindow -TemplateBody $(Get-Content .\ssm-maintenancewindow.yml -Raw) -Tag $tagOwner
Wait-Stack -StackName ssm-maintenancewindow

New-CFNStack -Capability CAPABILITY_IAM -StackName ssm-maintenancetask -TemplateBody $(Get-Content .\ssm-maintenancetask.yml -Raw) -Tag $tagOwner
Wait-Stack -StackName ssm-maintenancetask