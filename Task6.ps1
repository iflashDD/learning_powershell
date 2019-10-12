# 1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
# 1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
    Get-NetIPAddress | Format-Table
# 1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
    Get-NetAdapter | Format-Table Name, MacAddress
    Invoke-Command -ComputerName SRV-1C -Credential bomaks\sei {Get-NetAdapter | Format-Table Name, MacAddress}
# 1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
    Invoke-Command -ComputerName @{VM1, VM2, VM3} -Credential .\Admin {Get-NetAdapter | ForEach-Object {Set-NetIPInterface -Dhcp Enabled}}
# 1.4.	Расшарить папку на компьютере
    New-SmbShare -Name TempFiles -Path C:\Temp -FullAccess "SEIBOOK\Lenovo"
# 1.5.	Удалить шару из п.1.4
    Remove-SmbShare -Name TempFiles -Force
# 1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.

# 2.	Работа с Hyper-V
# 2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
    Get-Command -Module hyper-v
# 2.2.	Получить список виртуальных машин 
    Get-VM | Format-List Name
# 2.3.	Получить состояние имеющихся виртуальных машин
    Get-VM | Format-Table Name, Status
# 2.4.	Выключить виртуальную машину
    Stop-VM -Name test -Force
# 2.5.	Создать новую виртуальную машину
    New-VM -Name "New_test" -MemoryStartupBytes 2GB
# 2.6.	Создать динамический жесткий диск
    New-VHD -Dynamic -Path C:\Temp\test.vhd -SizeBytes 30GB
# 2.7.	Удалить созданную виртуальную машину
    Remove-VM -Name "New_test"