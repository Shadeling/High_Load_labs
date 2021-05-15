# Лабораторная работа №2 #
Студент: Миронов Святослав
Группа: М8О-103М-20


## Сборка проекта ##
```bash
    mkdir -p CMakeFiles 
    cd CMakeFiles
    cmake --configure ..
    cmake --build ./
```

## Настройка базы данных ##

1. Для создания тестового пользователя с именем lab и базы данных itlabs с необходимой таблицей Person необходимо выполнить команды из файла db_scripts/db_creation.sql.
2. Скрипт заполнения базы данных сгенерированными записями (100 тысяч строк) записан в файле db_scripts/data_generation.sql.

Выполнение скрипта из файла:

```bash
sudo mysql
mysql> source db_scripts/db_creation.sql
mysql> source db_scripts/data_generation.sql
```

## Запуск сервера##

```bash
$ docker-compose up -d
$ sudo sh ./start.sh
```


## Тестирование с помощью gtest ##

Запуск модульных тестов осуществляется командой:

```bash
./CMakeFiles/gtests
```

## Тестирование с помощью wrk ##

Нагрузочное тестирование производилось следующей командой:

```bash
wrk -t[NUMTREADS] -c50 -d30s http://localhost:8080/person?login=Stacy_Durrant1977368307@nimogy.biz
```

Кластер Apache Ignite из двух узлов и непосредственно приложение с БД были запущены на одной физической машине.  

В зависимости от числа потоков количество ответов в секуду и задержка менялись следующим образом:

**С использованием Apache Ignite**
Threads | Requests/sec  | Latency(ms)
---     | ---           | ---
1       | 4533.16       | 4.31
2       | 4933.33       | 3.10
6       | 4765.81       | 2.54
10      | 4723.15       | 3.53

**Без использования Apache Ignite (ЛР №1)**
Threads | Requests/sec | Latency(ms)
---     | ---          | ---
1       | 633.47       | 25.41
2       | 631.96       | 25.44
6       | 629.59       | 25.41
10      | 625.15       | 25.59
