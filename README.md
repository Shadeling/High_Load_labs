# Лабораторная работа №1 #

Выполнил: Миронов Святослав, М8О-103М-20

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

## Запуск сервера ##

Для запуска сервера следует выполнить команду:

```bash
sudo sh ./start.sh
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

Полученные результаты:

Threads | Requests/sec | Latency(ms)
---     | ---          | ---
1       | 633.47       | 25.41
2       | 631.96       | 25.44
6       | 629.59       | 25.41
10      | 625.15       | 25.59
