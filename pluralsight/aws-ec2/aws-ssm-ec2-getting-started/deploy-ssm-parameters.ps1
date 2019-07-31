Set-AWSCredential -StoreAs globomantics -AccessKey "AKIAIOHZDQUWZXOYIFXQ" `
-SecretKey "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"
Initialize-AWSDefaultConfiguration -Region "ap-southeast-2" -ProfileName globomantics


Write-SSMParameter -Name /api/airport_app_id -Description 'Airport API application ID' -Value 79809f6c -Type String

Write-SSMParameter -Name /api/airport_app_key -Description 'Airport API application key' -Type SecureString -Value e02a1605eb2993bb7abcf864b771a1c3

$tagOwner = New-Object Amazon.SimpleSystemsManagement.Model.Tag
$tagOwner.Key = "Owner"
$tagOwner.Value = "dave"
Add-SSMResourceTag -ResourceType "Parameter" -ResourceId "/api/airport_app_id" -Tag $tagOwner
Add-SSMResourceTag -ResourceType "Parameter" -ResourceId "/api/airport_app_key" -Tag $tagOwner

New-SSMDocument -DocumentFormat YAML -DocumentType Command -Name ssm-api-airport -Content $(Get-Content .\ssm-document-with-parameter.yaml -Raw)
