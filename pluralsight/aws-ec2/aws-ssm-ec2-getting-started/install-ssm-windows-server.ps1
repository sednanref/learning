New-IAMRole -RoleName SSMServiceRole -AssumeRolePolicyDocument (Get-Content -raw iam-role.json)
Register-IAMRolePolicy -RoleName SSMServiceRole -PolicyArn arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM

$code = "INSERT CODE IN HERE"
$id = "INSERT ID IN HERE"
$region = "INSERT AWS REGION IN HERE"
$dir = $env:TEMP + "\ssm"
New-Item -ItemType directory -Path $dir -Force
cd $dir
(New-Object System.Net.WebClient).DownloadFile("https://amazon-ssm-$region.s3.amazonaws.com/latest/windows_amd64/AmazonSSMAgentSetup.exe", $dir + "\AmazonSSMAgentSetup.exe")
Start-Process .\AmazonSSMAgentSetup.exe -ArgumentList @("/q", "/log", "install.log", "CODE=$code", "ID=$id", "REGION=$region") -Wait
Get-Content ($env:ProgramData + "\Amazon\SSM\InstanceData\registration")
Get-Service -Name "AmazonSSMAgent"