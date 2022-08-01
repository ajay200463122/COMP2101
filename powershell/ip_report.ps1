# Powershell Lab 3 - Powershell Data

function ip-report {
    $Description= @{ e='Description'; width =15}
    $Index= @{ e='Index'; width =5}
    $IPAddress= @{ e='IPAddress'; width=20}
    $IPSubnet = @{ e='IPSubnet'; width=20}
    $DNSDomain= @{ e='DNSDomain'; width=12}
    $DNSServer= @{ e='DNSServerSearchOrder'; width=20}
    
    Write-Host "IP Information : "

    get-ciminstance win32_networkadapterconfiguration | 
        Where-Object {$_.IPEnabled -eq $true} |
        Format-Table -Property $Description,$Index,$IPAddress,$IPSubnet,$DNSDomain,$DNSServer -Wrap
}
ip-report
