# Script1.4.	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)
[CmdletBinding(PositionalBinding = $false)]
param (
    # Путь для просмотра
    [Parameter(Mandatory = $true, Position = 0)]
    [string]
    $Path = 'C:\',
    # Параметр, указывающий, файлы каких типов будут игнорироваться при подсчёте 
    [Parameter(Mandatory = $false)]    
    [string]
    $ExclExt
)

$FolderSizeInGb=$null
$FolderSizeInGb = (Get-ChildItem $Path -Force -Recurse -Exclude $ExclExt | Measure-Object -Property Length -Sum).Sum / 1024Mb 
Write-Host ([System.Math]::Round($FolderSizeInGb,2))" GB"

