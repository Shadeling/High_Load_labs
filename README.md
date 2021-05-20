# Лабораторная работа №3 #
Студент: Миронов Святослав

Группа: М8О-103М-20

## Установка необходимых компонентов ##
[Описана здесь](https://github.com/DVDemon/hl_mai_lab_01/blob/master/README.md)

## Сборка проекта ##
```bash
    mkdir -p CMakeFiles && cd CMakeFiles && cmake --configure .. && cmake --build ./ && cd -
```


## Запуск необходимых контейнеров ##
```bash
    docker-compose up -d
```

## Создание и заполнение базы данных во всех шардах ##

```bash
$ sudo mysql -utest -ppzjqUkMnc7vfNHET -h 127.0.0.1 -P6033 --comments
mysql> source infrastructure/db_scripts/db_creation.sql;
mysql> source infrastructure/db_scripts/sharded_data_generation.sql;
mysql> exit; 
```

## Запуск приложения ##
```bash
    sudo sh ./start.sh
```

## Тестирование с помощью gtest ##

Перед тестами необходимо очистить базы данных в шардах командами:

```bash
$ sudo mysql -utest -ppzjqUkMnc7vfNHET -h 127.0.0.1 -P6033 --comments
mysql> source infrastructure/db_scripts/clear_tables.sql;
mysql> exit; 
```

Запуск модульных тестов осуществляется командой:

```bash
    ./CMakeFiles/gtests
```

## Тестирование с помощью wrk ##

Нагрузочное тестирование производилось следующей командой:

```bash
    wrk -t[NUMTREADS] -c50 -d30s http://localhost:8080/person?login=Stacy_Durrant1977368307@nimogy.biz
```

## Отключение контейнеров ##
```bash
$ docker-compose stop
```

Threads | Requests/sec | Latency(ms)
---     | ---          | ---
1       | 874.02       | 21.04
2       | 969.71       | 16.49
6       | 967.10       | 16.53
10      | 955.60       | 16.72