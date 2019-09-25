# Task 1 - 1.	Получите справку о командлете справки
    Get-help Get-Help

# Task 1 - 2.	Пункт 1, но детальную справку, затем только примеры
    Get-Help Get-Help -Detailed
    Get-Help Get-Help -Examples

# Task 1 - 3.	Получите справку о новых возможностях в PowerShell 4.0 (или выше)

# Task 1 - 4.	Получите все командлеты установки значений
    Get-Help Set-* | Where-Object -FilterScript {$_.Category -eq 'Cmdlet'}
    # либо так
    Get-Command Set-* | Where-Object -FilterScript {$_.CommandType -eq 'Cmdlet'}
    # или ещё проще (понял чуть позже)
    Get-Command Set-* -Type Cmdlet

# Task 1 - 5.	Получить список команд работы с файлами
    Get-Command *Item*

# Task 1 - 6.	Получить список команд работы с объектами
    Get-Command *Object*

# Task 1 -7.	Получите список всех псевдонимов
    Get-Command * -Type Alias
    # или
   Get-Command * | Where-Object -FilterScript {$_.CommandType -eq 'Alias'}

# Task 1 - 8.	Создайте свой псевдоним для любого командлета
    Set-Alias -Name list -Value Get-ChildItem

# Task 1 - 9.	Просмотреть список методов и свойств объекта типа процесс
    Get-Process | Get-Member -MemberType Properties,Method

# Task 1 - 10.	Просмотреть список методов и свойств объекта типа строка
    $string = ""
    $string | Get-Member

# Task 1 - 11.	Получить список запущенных процессов, данные об определённом процессе
    Get-Process # можно с ключом -IncludeUserName для получения процессов всех пользоателей (работает только с повышением прав)
    Get-Process -Id <PUT_PROCESS_ID_HERE> # заменить <PUT_PROCESS_ID_HERE> на искомый номер Id процесса
    Get-Process -Name <PUT_PROCESS_NAME_HERE> # заменить <PUT_PROCESS_NAME_HERE> на искомое имя процесса

# Task 1 - 12.	Получить список всех сервисов, данные об определённом сервисе
    Get-Service | Sort-Object Status, Name
    Get-Service -Name <SERVICE_NAME> # заменить <SERVICE_NAME> на искомое имя сервиса

# Task 1 - 13.	Получить список обновлений системы
    Get-HotFix | Sort-Object HotFixId

# Task 1 - 14.	Узнайте, какой язык установлен для UI Windows
    Get-Culture
    # или подробный вывод 
    Get-Culture | Format-List

# Task 1 - 15.	Получите текущее время и дату
    Get-Date

# Task 1 - 16.	Сгенерируйте случайное число (любым способом)
    Get-Random

# Task 1 - 17.	Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели
    $explorerDetails = Get-Process -Name explorer
    $explorerDetails.StartTime
    $explorerDetails.StartTime.DayOfWeek

# Task 1 - 18.	Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
    Stop-Process (Get-Process -Name *word*).Id 

# Task 1 - 19.	Подсчитать значение выражения N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)
    $N = 10 
    $S = 0 
    for ($i = 1; $i -lt $N; $i++) {
        $S = $S+(3*$i) 
        Write-Output "На шаге $i сумма равна $S"   
    }

# Task 1 - 20.	Напишите функцию для предыдущего задания. Запустите её на выполнение.
    function Summ ([int]$N) {
        $S = 0
        for ($i = 1; $i -lt $N; $i++) {
            $S = $S+(3*$i)
        }
        Return("Сумма равна $S") # либо Return($S) если хотим возвращать Int
    }