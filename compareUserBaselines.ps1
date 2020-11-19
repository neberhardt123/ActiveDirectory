
import-module activedirectory
 
$Logs = ".\logs.txt"
$quit = $false

while($quit -eq $false) {
Write-Host "1. Create Baseline users to a txt in current dir" -ForegroundColor Green;
Write-Host "2. Compare current users to baseline users" -ForegroundColor Green;
Write-Host "3. Exit" -ForegroundColor Green;


$choice = read-host "Choose wisely"   
    if ($choice -eq 1)
        {

        $global:Path = ".\baseline.txt"
        Get-ADUser -Filter * | select sAMAccountName | Out-File -FilePath $Path
        Add-Content -Path $Logs -Value "Created Baseline: " -NoNewline
        Get-Date | Add-Content -Path $Logs
        }  
    if ($choice -eq 2)
        {
        Write-Output "Calculating..."
            While($true)
                {
                $global:PathCompare = ".\compareUsers.txt"
				Get-ADUser -Filter * | select sAMAccountName | Out-File -FilePath $PathCompare
        


 
                #Compare-Object $(Get-Content $Path) $(Get-Content $PathCompare) | Add-Content -Path $Logs
                    

                    if (Compare-Object $(Get-Content $Path) $(Get-Content $PathCompare))
                        {
                        $date = Get-Date
                        Write-Host $date -NoNewline 
                        Write-Host " New User Detected"
                        Add-Content -Path $Logs -Value "Possible new user: " -NoNewLine
                        Compare-Object $(Get-Content $Path) $(Get-Content $PathCompare) | Add-Content -Path $Logs
                        
                        }
                  Start-Sleep -seconds 25

                }  
        }
        if($choice -eq 3) {
            $quit = $true
        }
}
