-- 1

-- Вивести середнє арифметичне, суму зарплати ( salary + commission), кількість викладачів, суму зарплати,
--     поділену на кількість викладачів, щодо всіх рядків таблиці TEACHER.
--     Стовпці результуючої таблиці повинні мати імена:
-- -  Середня зарплата
-- -  сума зарплати
-- -  Кількість рядків
-- -  Вираз

SELECT
    AVG(salary + commission) AS "Середня зарплата",
    SUM(salary + commission) AS "Сума зарплати",
    COUNT(*)                 AS "Кількість рядків",
    SUM(salary + commission) / COUNT(*) AS "Вираз"
FROM teacher;

-- 2

-- За аудиторією 313 корпусу 6 вивести наступну інформацію під відповідними іменами стовпців:
-- -  рядкова константа 'Інфо про аудиторію 313 к. 6:' 	- Інфо про ауд. 313 к.6
-- -  кількість кафедр, викладачі яких мають у ній заняття 	- Кількість кафедр-викладачі
-- -  кількість кафедр, групам яких проводять у ній заняття 	- Кількість кафедр-групи
-- -  кількість викладачів, які проводять у ній заняття 	- Кількість викладачів
-- -  кількість груп, яким проводяться в ній заняття 	- Кількість груп
-- -  кількість дисциплін, які читаються в ній 	- Кількість дисциплін

SELECT
    'Інфо про аудиторію 313 к.6:' AS "Інфо про ауд. 313 к.6",
    COUNT(DISTINCT teacher.dep_fk) AS "Кількість кафедр-викладачі",
    COUNT(DISTINCT sgroup.dep_fk) AS "Кількість кафедр-групи",
    COUNT(DISTINCT lecture.tch_fk) AS "Кількість викладачів",
    COUNT(DISTINCT lecture.grp_fk) AS "Кількість груп",
    COUNT(DISTINCT lecture.sbj_fk) AS "Кількість дисциплін"
  FROM room
           JOIN lecture ON room.rom_pk = lecture.rom_fk
           JOIN sgroup ON lecture.grp_fk = sgroup.grp_pk
           JOIN teacher ON lecture.tch_fk = teacher.tch_pk
 WHERE room.num = 313 AND room.building = 6;

-- 3

-- Вивести сумарну зарплату всіх викладачів факультету, деканом якого є Іванов.
--     При цьому обчислений результат округлити з відкиданням дрібної частини.

SELECT ROUND(SUM(salary + commission))
  FROM teacher
       JOIN faculty ON teacher.dep_fk = faculty.fac_pk
 WHERE faculty.dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Іванов');

-- 4

-- Для кожної пари можливих значень викладач-група вивести:
-- -  ім'я викладача
-- -  Номер групи
-- -  кількість лекцій, які читає цей викладач у цій групі
-- -  кількість SUBJECTів, які читає цей викладач цій групі

SELECT
    teacher.name AS "Ім'я викладача",
    sgroup.num AS "Номер групи",
    COUNT(lecture.tch_fk) AS "Кількість лекцій",
    COUNT(DISTINCT lecture.sbj_fk) AS "Кількість дисциплін"
  FROM teacher
       JOIN lecture ON teacher.tch_pk = lecture.tch_fk
       JOIN sgroup ON lecture.grp_fk = sgroup.grp_pk
 GROUP BY teacher.name, sgroup.num;

-- 5

-- За кожною парою значень група-курс з таблиці SGROUP вивести наступну інформацію у відповідних стовпцях:
-- -  Номер групи. Якщо група дорівнює NULL , вивести константу “Відсутня” - Група
-- -  Номер курсу. Якщо курс дорівнює NULL , вивести константу "Ні" 	- Курс
-- -  К-ть викладачів, що викладають у цій групі 	- К-ть викладачів
-- -  К-ть дисциплін, що викладають у цій групі 	- К-ть дисциплін
-- -  К-ть занять, що є в цій групі на цьому курсі 	- К-ть занять

SELECT
    COALESCE(sgroup.num, 'Відсутня') AS "Група",
    COALESCE(sgroup.course, 'Ні') AS "Курс",
    COUNT(DISTINCT lecture.tch_fk) AS "К-ть викладачів",
    COUNT(DISTINCT lecture.sbj_fk) AS "К-ть дисциплін",
    COUNT(*) AS "К-ть занять"
  FROM sgroup
       LEFT JOIN lecture ON sgroup.grp_pk = lecture.grp_fk
 GROUP BY sgroup.num, sgroup.course;

-- 6

-- За кожним викладачем факультету, деканом якого є Іванов, вивести
-- -  ім'я викладача,
-- -  Його посада,
-- -  кількість підлеглих йому викладачів,
-- -  кількість посад, що мають підлеглі викладачі,
-- за умови:
-- -  сумарне значення зарплат ( salary + commission) всіх підлеглих перебуває у діапазоні 700-10000, і
-- -  різниця між максимальною та мінімальною зарплатою серед підлеглих викладачів менша за 2500.

SELECT
    teacher.name AS "Ім'я викладача",
    teacher.post AS "Посада",
    COUNT(DISTINCT teacher.tch_pk) AS "К-ть підлеглих викладачів",
    COUNT(DISTINCT teacher.post) AS "К-ть посад",
    SUM(salary + commission) AS "Сумарна зарплата"
  FROM teacher
       JOIN faculty ON teacher.dep_fk = faculty.fac_pk
 WHERE faculty.dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Іванов')
 GROUP BY teacher.name, teacher.post
HAVING SUM(salary + commission) BETWEEN 700 AND 10000
   AND MAX(salary + commission) - MIN(salary + commission) < 2500;

-- 7

-- Для кожного кафедри факультету, деканом якого є Іванов, вивести назву кафедри, кількість викладачів на кафедрі та
--     кількість груп на кафедрі. Результат упорядкувати по третьому стовпцю за зростанням, по першому стовпцю за спаданням
--     і по другому стовпцю - за спаданням. Використовувати для цього порядкові номери колонок результуючої таблиці.

SELECT
    faculty.name AS "Назва факультету",
    COUNT(DISTINCT teacher.tch_pk) AS "К-ть викладачів",
    COUNT(DISTINCT sgroup.grp_pk) AS "К-ть груп"
  FROM faculty
       JOIN teacher ON faculty.fac_pk = teacher.dep_fk
       JOIN sgroup ON teacher.tch_pk = sgroup.curator
 WHERE faculty.dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Іванов')
 GROUP BY faculty.name
 ORDER BY 3, 1 DESC, 2 DESC;










