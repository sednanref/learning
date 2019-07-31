Set-AWSCredential -StoreAs globomantics -AccessKey "AKIAIOHZDQUWZXOYIFXQ" `
-SecretKey "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"
Initialize-AWSDefaultConfiguration -Region "ap-southeast-2" -ProfileName globomantics

New-SSMDocument -Content (Get-Content -Path .\ssm-document-chocolatey.yaml -Raw) `
  -DocumentFormat YAML `
  -DocumentType Command `
  -Name 'cloudops-install-chocolatey' `
  -TargetType '/AWS::EC2::Instance' 

$platform = @{Key="platform";Value=@("windows")}
Add-SSMResourceTag -ResourceId 'cloudops-install-chocolatey' -ResourceType "Document" -Tag $platform