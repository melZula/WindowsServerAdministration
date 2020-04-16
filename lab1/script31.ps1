echo "Input name"
$input = Read-Host
$name = "$input".Substring(0,4)
 
$user = "UPart3$name"
$group = "GPart3$name"
 
new-localuser $user -NoPassword
new-localgroup $group
add-localGroupMember -group $group -member $user
Enable-localuser -Name $user
