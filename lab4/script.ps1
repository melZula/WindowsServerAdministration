Import-Module activedirectory
$ADUsers = Import-csv c:\Users.csv
 
$obj=[ADSI]"LDAP://RootDSE"
$Domain = $obj.defaultNamingContext | Out-String
 
 
$NewUsers = @()
$NewGroups = @()
$NewContainers = @()
$finalArray = @()
 
foreach ($User in $ADUsers) {
   
    $Username = $User.ProfileLogin
    $Password = $User.Password
    $Firstname = $User.FirstName
    $Lastname = $User.LastName
    $Title = $User.Title
    $Department = $User.Department
    $Mail = $User.Mail
    $Phone = $User.Phone
    $Container = $User.Container
    $groups = $User.Group -split ";"
    $HomePath = $User.HomePath
    $ProfilePath = $User.ProfilePath
 
    if (Get-ADUser -F {SamAccountName -eq $Username}) {
         echo "User exists"
    } else {
 
        if (!(Get-ADObject -Filter 'DistinguishedName -eq $Container')) {
            if ($Container.contains(',')) {
                $Name = $Container.subString(3,$Container.indexof(',')-3)
            } else {
                $Name = $Container.subString(3,$Container.length-3)
            }
 
            New-ADObject -Name $Name -Type "container" -Path $Domain
            $NewContainers += $Name
        }
       
        New-ADUser -Name "$Firstname $Lastname" `
            -UserPrincipalName "$Username@example.com" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -SamAccountName $Username `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) `
            -DisplayName "$Firstname $Lastname" `
            -EmailAddress $Mail `
            -PasswordNeverExpires $true `
            -Title $Title `
            -HomeDirectory $HomeDirectory `
            -ProfilePath $ProfilePath `
            -Department $Department `
            -MobilePhone $Phone `
            -Path $Container `
            -Enabled $true
 
 
        $NewUsers += "$Firstname $LastName"
 
        foreach($group in $groups) {
            if (Get-ADGroup -Filter 'Name -eq $group') {
                Add-ADGroupMember $group -Members $Username
            } else {
                New-ADGroup -Name $group -GroupScope Global -Path "CN=Users,$Domain"
                Add-ADGroupMember $group -Members $Username
                $NewGroups += $group
            }
        }
 
 
        Write-Output "$Username was new and has been created"
    }
}
$finalArray += ("New containers count - " + $NewContainers.length)
$finalArray += $NewContainers
$finalArray += ("New users count - " + $NewUsers.length)
$finalArray += $NewUsers
$finalArray += ("New groups count - " + $NewGroups.length)
$finalArray += $NewGroups
$finalArray | ConvertTo-Html -Property @{ l='Table'; e={ $_ } } | out-file review.html