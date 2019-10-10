[CmdletBinding(PositionalBinding=$false)]
param (
    # Путь для сохранения файла)
    [Parameter(Mandatory=$true)]
    [string]
    $Path='C:\Temp\top10.txt',
    # Ключ для вывода справки
    [Parameter(Mandatory=$false)]
    [switch]
    $help,
    [Parameter(Mandatory=$false)]    
    [switch]
    $h
)
if ($help -or $h) {
    Write-Host "Use ScriptName -Path <Value> to specify Path for OUTPUT"
}
if (!(Test-Path $Path)) {
    New-Item -ItemType File -Path $Path -Force
}

if (!($help -or $h)) {
    Write-Host "Output saved to default Path=C:\Temp\top10.txt"
}

Get-Process | Sort-Object -Property TotalProcessorTime -descending | Select-Object -First 10 | Format-Table -Property TotalProcessorTime, Name | Out-File -FilePath $Path