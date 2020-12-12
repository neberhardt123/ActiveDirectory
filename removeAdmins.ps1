Import-Module ActiveDirectory

$adminz = @(Get-ADGroupMember "Domain Admins" | Select-Object -ExpandProperty name)
Foreach($a in $adminz) {
    if($a -ne "Administrator") {
        Remove-ADGroupMember -Identity "Domain Admins" -Members $a
    } 
}
