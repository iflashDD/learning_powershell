# Script1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
[CmdletBinding(PositionalBinding=$false)]
param (
    # Путь для файловых операций (сохранения либо открытия файла)
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    $Path='C:\Temp\file.txt',
    # Ключ, указывающий, что будем писать в файл $Path
    [Parameter(Mandatory=$false)]
    [switch]
    $Save,
    # Ключ, указывающий, что будем читать из $Path
    [Parameter(Mandatory=$false)]    
    [switch]
    $View,
    # Ключ, указывающий, что будем читать из файла $Path
    [Parameter(Mandatory=$false)]
    [switch]
    $Open
)

if ($Save -and !($View -or $Open)) {
    if (!(test-path $Path)) {
        New-Item -ItemType File -Path $Path -Force
        }
    Get-Service | Where-Object -FilterScript {$_.Status -eq "Running"} | Out-File -FilePath $Path
    
}
elseif ($View -and !($Save -or $Open)) {
        Get-ChildItem -Path $Path | Write-Host
    }
elseif ($Open -and !($Save -or $View)) {
        Get-Content $Path | Write-Host
}
else {
    Write-Host "Error, please set only one from: -Open or -Save or -View parameter"
}