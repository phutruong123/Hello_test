$SearchBase = "OU=ELCA-VN,OU=Accounts,OU=VN,DC=elcaNet,DC=local"
$AllUsers =  Get-ADUser -SearchBase $SearchBase -Filter * -Properties lastlogon
Write-Host "Getting Users..."
Write-Host "----------------"
foreach($user in $AllUsers)
    {
        $fullname = $user.SamAccountName
        echo $fullname
        #$visa = $user.SamAccountName
        #$desc = $user.Description
        #$lastlogon = $user.lastlogondate
        #echo $AllUsers
        Get-ADUser -Identity $fullname -Properties LastLogon | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}}
        Get-Content -Path D:\Dell\OUTPUT.txt      
                
    }