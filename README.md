# Лабораторная работа №4 #
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

## Запуск основного приложения ##
```bash
$ sudo sh ./start.sh
```

## Запуск приложения с очередью ##
```bash
$ sudo sh ./start_writer.sh
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

## Нагрузочное тестирование ##
Нагрузочное тестирование осуществлялось с помощью утилиты wrk.

```bash
# Тест на запись
$ wrk -s tests/post_wrk_req.lua -t $NUMTREADS -c50 -d30s http://localhost:8080
```

### Тестирование на запись ###

Результаты с использованием очередей Apache Kafka (ЛР 4):

Threads | Requests/sec | Latency(ms)
---     | ---          | ---
1       | 75.78        | 210.38
2       | 77.27        | 206.36
6       | 77.20        | 206.06
10      | 76.61        | 207.80


## Точки входа ##
Добавление пользователя
```bash
$ curl -d "login=mir@slav&last_name=Mironov&first_name=Slav&age=22" -X POST http://localhost:8080/person
```
Получение всех пользователей
```bash
$ curl -X GET http://localhost:8080/person
```
Получение пользователей по маске
```bash
$ curl -X GET http://localhost:8080/person\?first_name\=Sla
```
Получение конкретного пользователя
```bash
$ curl -X GET http://localhost:8080/person\?login\=mir@123
```
