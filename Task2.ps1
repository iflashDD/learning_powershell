# Task 2 - 1. Просмотреть содержимое ветви реeстра HKCU
    Set-Location HCCU:\ 
    Get-ChildItem # любой alias на Get-ChildItem

# Task 2 - 2. Создать, переименовать, удалить каталог на локальном диске
    New-Item -Path "C:\" -Name "Temp" -ItemType "directory" # создаем папку Temp в корне диска С
    Rename-Item -Path "C:\Temp" -NewName "TempForDelete" # переименовываем в TempForDelete
    Remove-Item -Path "C:\TempForDelete" # удаляем

# Task 2 - 3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
    New-Item -Path "C:\" -Name "M2T2_Sikirzhytski" -ItemType "directory"
    New-PSDrive -Name "Z" -PSProvider FileSystem -Root "C:\M2T2_Sikirzhytski"

# Task 2 -4. Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
    Get-Process > "Z:\process-list.txt"
    Get-ChildItem -Path Z:
    Get-Content Z:\process-list.txt

# Task 2 - 5. Просуммировать все числовые значения переменных текущего сеанса.
#Предположим я понятия не имею что за "числа" могут быть в значениях переменных
    Get-Variable | ForEach-Object {if ($_.Value -is [byte] -or $_.Value -is [int16] `
                                    -or $_.Value -is [int32] -or $_.Value -is [int64] `
                                    -or $_.Value -is [sbyte] -or $_.Value -is [uint16] `
                                    -or $_.Value -is [uint32] -or $_.Value -is [uint64] `
                                    -or $_.Value -is [float] -or $_.Value -is [double]) {[double]$Summ=$Summ+$_.Value}}
    $Summ

# Task 2 - 6. Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort-Object -Property TotalProcessorTime -descending | Select -First 6 | Format-Table -Property TotalProcessorTime, Name