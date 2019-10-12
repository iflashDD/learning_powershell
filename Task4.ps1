# 1.	Вывести список всех классов WMI на локальном компьютере. 
    Get-WmiObject -List
# 2.	Получить список всех пространств имён классов WMI. 
    Get-WmiObject -Namespace root -List
# 3.	Получить список классов работы с принтером.
    Get-WmiObject -List | Where-Object {$_ -match "Printer"}
# 4.	Вывести информацию об операционной системе, не менее 10 полей.
    $os = Get-WmiObject Win32_OperatingSystem
    $os | Format-List Caption, Version, BuildType, BuildNumber, InstallDate, CodeSet, CountryCode, CurrentTimeZone, Locale, EncryptionLevel
# 5.	Получить информацию о BIOS.
    Get-WmiObject win32_bios
# 6.	Вывести свободное место на локальных дисках. На каждом и сумму.
    $totalfreespace = 0
    Get-WmiObject win32_LogicalDisk | ForEach-Object {$totalfreespace += ($_.FreeSpace/1024MB)}
    $totalfreespace
# 7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
    [cmdletbinding()]
    Param (
    [Parameter (Mandatory=$true)]
    [string]
    $HostforPing,
    [Parameter (Mandatory=$true)]
    [int]
    $count
    )

    $rt=0
    for($i=0;$i -lt $count;$i++)
    {
    $info=Get-WmiObject -Class win32_pingstatus -f "Address='$HostForPing'"  
    write-host "Adress:" $HostforPing "Time:" $info.responsetime "ms" "Status" $info.StatusCode "TTL" $info.TimeToLive
    $rt+=$info.ResponseTime
    }
    Write-Host "Время пингования:" $rt "ms" 
# 8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
    Get-WmiObject win32_product | Format-Table Name, Version, Vendor
# 9.	Выводить сообщение при каждом запуске приложения MS Word.
    register-wmiEvent -query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='winword.exe'" -sourceIdentifier "ProcessStarted" -Action { Write-Host "Lets write!" }