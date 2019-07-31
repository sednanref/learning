Set-AWSCredential -StoreAs globomantics -AccessKey "AKIAIOHZDQUWZXOYIFXQ" `
-SecretKey "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" -Verbose
Initialize-AWSDefaultConfiguration -Region "ap-southeast-2" -ProfileName globomantics -Verbose


$ec2key = New-EC2KeyPair -KeyName "globomantics-ec2-keypair" -Verbose
# Good practice - write the Keymaterial to SSM
Write-SSMParameter -Name "globomantics-ec2-keypair" -Type SecureString `
-Value $ec2key.KeyMaterial -Description "EC2 Keypair" -Verbose

# Write the Key Pair to a local file
$ec2key.KeyMaterial | Set-Content -Path c:\dev\aws\globomantics-ec2-keypair.pem -Force

$securityGroupId = (Get-CFNExport `
| Where-Object {$_.Name -eq "core-management-securitygroup"}).Value
$subnetPublic = (Get-CFNExport `
| Where-Object {$_.Name -eq "core-subnet-public"}).Value

# Deploy the CentOs VM
$tag1 = @{ Key="Name"; Value="Globomantics001" }
$tag2 = @{ Key="role"; Value="webserver" }
$tagspec = New-Object Amazon.EC2.Model.TagSpecification
$tagspec.ResourceType = "instance"
$tagspec.Tags.Add($tag1)
$tagspec.Tags.Add($tag2)

# Find the latest CentOs AMI
$amiId = $(Get-EC2Image -Owner 679593333241 `
-Filter @{ Name="name"; Values = "CentOS Linux 7 x86_64 HVM EBS*"}).ImageId
New-EC2Instance -ImageId $amiId -InstanceType t2.micro -TagSpecification $tagspec `
-AssociatePublicIp $true -KeyName $ec2key.KeyName -SecurityGroupId $securityGroupId `
-SubnetId $subnetPublic