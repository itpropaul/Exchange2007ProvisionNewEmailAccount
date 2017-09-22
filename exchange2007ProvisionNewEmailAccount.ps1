Write-output “ENTER THE FOLLOWING DETAILS - When Creating Multiple New Accounts Go to           EMC hit F5(refresh) and make sure previous new account is listed before proceeding to the       next one”
$DName = Read-Host “User Diplay Name(New User)"
$RUser = Read-Host "Replicate User(Database Grab)"
$RData = ((Get-Mailbox -Identity $RUser).Database).DistinguishedName
$REmailInput = Read-Host “Requester's Name(Notification Email goes to this Person)"
$REmail = ((Get-Mailbox -Identity "$REmailInput").PrimarySmtpAddress).ToString()

Enable-Mailbox -Identity "$DName" -Database "$RData"
Start-Sleep -s 5
Set-CASMailbox -Identity "$DName" -ActiveSyncEnabled $false -ImapEnabled $false -    PopEnabled $false


Send-MailMessage -From "John Doe <John.Doe@xyz.com>" -To $REmail -Subject       "$DName's email account" -Body "$DName's email account has been setup.`n`n`nJohn Doe`nXYZ`nSystems Administrator`nOffice: 123.456.7890`nJohn.Doe@xyz.com" -SmtpServer exchange@xyz.com
