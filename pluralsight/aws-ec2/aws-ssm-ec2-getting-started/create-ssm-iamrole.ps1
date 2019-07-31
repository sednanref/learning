New-IAMRole -RoleName SSMServiceRole -AssumeRolePolicyDocument `
(Get-Content -raw C:\dev\aws\iam-role.json)

Register-IAMRolePolicy -RoleName SSMServiceRole `
-PolicyArn arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM