Import-Module ActiveDirectory

$adminz = @(Get-ADGroupMember "Domain Admins" | Select-Object -ExpandProperty name)
Foreach($amid in $adminz) {
    if($amid -ne "Administrator") {
        Remove-ADGroupMember -Identity "Domain Admins" -Members $amid
    } 
}
