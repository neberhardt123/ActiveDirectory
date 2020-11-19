
import-module activedirectory
 
$Logs = ".\logs.txt"
$quit = $false
$temp = @()
while($quit -eq $false) {
Write-Host "1. Create Baseline users to a txt in current dir" -ForegroundColor Green;
Write-Host "2. Compare current users to baseline users" -ForegroundColor Green;
Write-Host "3. Exit" -ForegroundColor Green;


$choice = read-host "Choose something"   
    if ($choice -eq 1)
        {

        $global:Path = ".\baseline.txt"
        Get-ADUser -Filter * | select sAMAccountName | Out-File -FilePath $Path
        Add-Content -Path $Logs -Value ("Created Baseline: ")-NoNewline
        Get-Date | Add-Content -Path $Logs
        }  
    if ($choice -eq 2)
        {
        Write-Output "Calculating..."
            While($true)
                {
                $global:PathCompare = ".\compareUsers.txt"
				Get-ADUser -Filter * | select sAMAccountName | Out-File -FilePath $PathCompare
        
                

 
                $spam = @(Compare-Object $(Get-Content $Path) $(Get-Content $PathCompare) | Select-Object -ExpandProperty InputObject)
                    if ($spam)
                        {
                        if(Compare-Object $spam $temp) {
                            
                            $date = Get-Date
                            Write-Host $date -NoNewline 
                            Write-Host " New User(s) Detected: " -NoNewline
                            Get-Date | Add-Content -Path $Logs -NoNewline
                            Add-Content -Path $Logs -Value (": Possible new user(s): " + "`n") -NoNewLine
                            
                            #Compare-Object $(Get-Content $Path) $(Get-Content $PathCompare) | Select-Object -ExpandProperty InputObject | Add-Content -Path $Logs
                            $temp = @(Compare-Object $(Get-Content $Path) $(Get-Content $PathCompare) | Select-Object -ExpandProperty InputObject)
                            for($i = 0; $i -le ($temp.length -1); $i += 1) {
                                $n = $i + 1
                                Add-Content -Value ("$n. " + $temp[$i]) -Path $Logs
                            }
                            Add-Content -Value "`n" -Path $Logs
                            Write-Host $temp
                            
                        }
                    }
                  Start-Sleep -seconds 25
                    

                }  
        }
        if($choice -eq 3) {
            $quit = $true
        }
}