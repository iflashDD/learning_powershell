<#> Script  1.5.	Создать один скрипт, объединив 3 задачи:
            1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
            1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
            1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
#>
[CmdletBinding(PositionalBinding = $false)]
param (
    # Путь для файловых операций (сохранения либо открытия файлов)
    [Parameter(Mandatory = $false, Position = 0)]
    [string]
    $Path = 'C:\',
    # Параметр, указывающий, операцию какого типа мы выполняем (записываем или читаем)
    [Parameter(Mandatory = $false)]    
    [switch]
    $O,
    [Parameter(Mandatory = $false)]
    [switch]
    $S,
    [Parameter(Mandatory = $false)]
    [string]
    $CSVName = "csv.csv",
    [Parameter(Mandatory = $false)]
    [string]
    $XMLName = "xml.xml",
    # Help switch
    [Parameter(Mandatory = $false)]
    [switch]
    $help
)

function Save-CSV {
    # Получаем список всех обновлений | вычленяем из них только Security Update | Из полученных данных отбираем только значения целевой машины, 
    # название обновки, дату накатывания | экспортируем в CSV
    Get-WmiObject -Class win32_quickfixengineering | Where-Object { $_.description -eq "Security Update" } `
    | Select-Object -Property CSName, description, HotFixID, InstalledOn | Export-Csv -Path $Path\$CSVName
    #Write-Host ("File = " + ("$Path\$CSVName") + " created!")
}

function Save-XML {
    Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft | Export-Clixml -Path $Path\$XMLName -Force
    #Write-Host ("File = " + ("$Path\$XMLName") + " created!")
}

function Print-XML {
    Import-Clixml -Path $Path\$XMLName | ForEach-Object { Write-Host -ForegroundColor Green $_ }
}

function Print-CSV {
    Import-Csv -Path $Path\$CSVName | ForEach-Object { Write-Host -ForegroundColor Red $_ }
}

# Controller code
if ($O -and !$S) {
    #Проверяем существование файла
    if (Test-Path $Path\$CSVName) { 
        Print-CSV
    }
    else {
        Write-Host "There is no CSV file!!!"
    }
    #Проверяем существование файла
    if (Test-Path $Path\$XMLName) { 
        Print-XML
    }
    else {
        Write-Host "There is no XML file!!!"
    }
}
elseif (!$O -and $S) {
    #Проверяем существование файла, если его нет - создаем
    if (!(Test-Path $Path\$CSVName)) {
        New-Item -ItemType File -Path $Path\$CSVName -Force
    }
    #То же самое для второго
    if (!(Test-Path $Path\$XMLName)) {
        New-Item -ItemType File -Path $Path\$XMLName -Force
    }
    if ($(Save-XML)) {
        Write-Host ("File = " + ("$Path\$XMLName") + " created!")
    } 
    if ($(Save-CSV)) {
        Write-Host ("File = " + ("$Path\$CSVName") + " created!")
    }
}
else {
    Write-Host "Please, choose only one of the following options: '-o' for viewing existing files or '-o' for saving information or '-help' to get help"
}

if ($help) {
    Write-Host " Use script [-Path <Path>] [-o] [-s] [-CSVName <FileName>] [-XMLName <FileName>]"
}