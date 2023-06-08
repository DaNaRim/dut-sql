INSERT INTO Faculty (Fac_PK, Name, Building, Fund)
VALUES (1, 'Informatics', 5, 157398.00),
       (2, 'Economy', 3, NULL),
       (3, 'Linguistics', 4, NULL);

INSERT INTO DEPARTMENT (Dep_PK, Fac_FK, Name, Building, Fund)
VALUES (1, 1, 'SE', 5, 24378.00),
       (2, 1, 'CAD', 5, 25000.00),
       (3, 1, 'DBMS', 5, 22000.00),
       (4, 2, 'Accounts', 3, 20000);

INSERT INTO Teacher (Tch_PK, Dep_FK, Name, Post, Tel, Hire_date, Salary, Commission)
VALUES (1, 1, 'Andrew', 'assistant', 123456, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1250.00, 80.00),
       (2, 1, 'John', 'professor', 234567, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1400.00, 150.00),
       (3, 2, 'Bill', 'assistant professor', 345678, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1240.00, 80.00),
       (4, 2, 'Aldert', 'assistant professor', 456789, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1260.00, 100.00),
       (5, 2, 'Sidorov', 'professor', 567890, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1500.00, 200.00),
       (6, 1, 'Petrov', 'assistant', 678901, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1250.00, 80.00),
       (7, 2, 'Ivanov', 'professor', 789012, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1500.00, 200.00),
       (8, 2, 'Popov', 'assistant', 789512, TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1600.00, 100.00);
UPDATE Faculty
   SET dean_fk = 5
 WHERE Fac_PK = 1;

UPDATE Faculty
   SET dean_fk = 6
 WHERE Fac_PK = 2;

UPDATE Faculty
   SET dean_fk = 8
 WHERE Fac_PK = 3;

UPDATE department
   SET head_fk = 5
 WHERE dep_pk = 1;

UPDATE department
   SET head_fk = 6
 WHERE dep_pk = 2;

UPDATE department
   SET head_fk = 7
 WHERE dep_pk = 3;

UPDATE department
   SET head_fk = 2
 WHERE dep_pk = 4;

INSERT INTO Sgroup (grp_pk, dep_fk, Course, Num, Quantity, Curator, Rating)
VALUES (1, 1, 1, 101, 33, 4, 20),
       (2, 1, 1, 102, 35, 5, 22),
       (3, 3, 2, 205, 20, 1, 15),
       (4, 3, 3, 305, 25, NULL, 40),
       (5, 3, 4, 405, 25, 2, 37);

INSERT INTO subject (sbj_pk, Name)
VALUES (1, 'Pascal'),
       (2, 'C'),
       (3, 'OS'),
       (4, 'internet'),
       (5, 'dbms');

INSERT INTO room (rom_pk, num, seats, floor, building)
VALUES (1, 101, 20, 1, 5),
       (2, 316, 150, 3, 5),
       (3, 201, 150, 2, 2),
       (4, 202, 30, 2, 4);

INSERT INTO lecture (tch_fk, grp_fk, sbj_fk, rom_fk, type, day, week, lesson)
VALUES (1, 1, 1, 1, 'lecture', 'mon', '2', 1),
       (1, 2, 2, 1, 'lab', 'mon', '1', 1),
       (2, 3, 3, 1, 'lecture', 'tue', '1', 3),
       (2, 4, 4, 2, 'practice', 'wed', '1', 3),
       (4, 4, 5, 2, 'practice', 'thu', '2', 4),
       (4, 4, 5, 3, 'lab', 'fri', '2', 1);

INSERT INTO faculty (Fac_PK, name, building, fund, dean_fk)
VALUES (9, '126', 1, 102102, NULL);

INSERT INTO department (dep_pk, fac_fk, name, building, fund, head_fk)
VALUES (99, 99, 'ipzas', 1, 20102, NULL);


INSERT INTO teacher (tch_pk, dep_fk, name, post, tel, hire_date, salary, chief_fk)
VALUES (99, 99, 'Ivanov', 'assistant', '2281319', TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1800, 100),
       (100, 99, 'Petrov', 'professor', '2281550', TO_DATE('01.07.1948', 'dd.MM.yyyy'), 1800, NULL),
       (101, 99, 'Sidorov', 'assistant', NULL, TO_DATE('17.11.1948', 'dd.MM.yyyy'), 1800, 100),
       (102, 99, 'Perov', 'assistant', NULL, TO_DATE('11.11.1948', 'dd.MM.yyyy'), 1800, 100);

UPDATE faculty
   SET dean_fk = 100
 WHERE Fac_PK = 99;

UPDATE department
   SET head_fk = 100
 WHERE dep_pk = 99;

INSERT INTO sgroup (grp_pk, dep_fk, course, num, quantity, curator)
VALUES (99, 99, 2, 23, 27, NULL);

INSERT INTO subject (sbj_pk, name)
VALUES (99, 'kmi');

INSERT INTO lecture (tch_fk, grp_fk, grp_fk, rom_fk, type, day, week, lesson)
VALUES (99, 99, 99, 1, 'lecture', 'mon', 1, 1);


-- 1

-- Виведіть інформацію про викладачів у наступному форматі:
-- Прийнятий на роботу <дата прийому на роботу> <посада викладача> <ім'я
-- викладача>, має ставку <ставка> та надбавку <премія> Його телефон <номер
-- телефону>
-- Використовуйте для цього два варіанти:
-- Інформація вивести в одному стовпці під назвою «Інформація про
-- викладачів»
-- Інформація вивести у наступних шести стовпцях:
-- - перший стовпець з іменем «Константа1» містить константу 'Прийнятий
-- на роботу'
-- - другий стовпець з ім'ям "Дата" містить дату прийому на роботу
-- - третій стовпець з ім'ям «Посада» містить посаду викладача,
-- - четвертий стовпець з ім'ям «Викладач» містить ім'я викладача,
-- - п'ятий стовпець з ім'ям «Констатна2» містить константу 'має ставку'
-- - шостий стовпець з ім'ям «Ставка» містить ставку викладача
-- - сьомий стовпець з ім'ям «Констатна3» містить константу 'і надбавку'
-- - восьмий стовпець з ім'ям «Премія» містить надбавку викладача
-- - дев'ятий стовпець з ім'ям «Констатна4» містить константу 'Його телефон'
-- - десятий стовпець з ім'ям «Телефон» містить номер телефону викладача

SELECT CONCAT(
               'Прийнятий на роботу ',
               hire_date,
               ' ',
               post,
               ' ',
               name,
               ', має ставку ',
               salary,
               ' та надбавку ',
               commission,
               ' Його телефон ',
               tel
           ) AS "Інформація про викладачів"
  FROM teacher;

SELECT
    'Прийнятий на роботу' AS "Константа1",
    hire_date AS "Дата",
    post AS "Посада",
    name AS "Викладач",
    'має ставку' AS "Константа2",
    salary AS "Ставка",
    'і надбавку' AS "Константа3",
    commission AS "Премія",
    'Його телефон' AS "Константа4",
    tel AS "Телефон"
  FROM teacher;

-- 2

-- Вивести імена викладачів-доцентів та назви дисциплін, які вони
-- викладають студентам 3-го курсу факультету 'комп'ютерні науки'

SELECT DISTINCT
    t.name AS "Викладач",
    s.name AS "Дисципліна"
  FROM teacher t
    JOIN lecture l ON t.tch_pk = l.tch_fk
    JOIN sgroup g ON l.grp_fk = g.grp_pk
    JOIN department d ON g.dep_fk = d.dep_pk
    JOIN faculty f ON d.fac_fk = f.fac_pk
    JOIN subject s ON l.sbj_fk = s.sbj_pk
  WHERE t.post = 'assistant professor'
        AND g.course = 3
        AND f.name = 'комп''ютерні науки';

-- 3

-- Вивести імена викладачів, які викладають групі, у якої куратором є
-- викладач Іванов.

SELECT DISTINCT
    t.name AS "Викладач"
  FROM teacher t
    JOIN sgroup g ON t.tch_pk = g.curator
    JOIN lecture l ON g.grp_pk = l.grp_fk
    JOIN teacher t2 ON l.tch_fk = t2.tch_pk
  WHERE t2.name = 'Іванов';

-- 4

-- Вивести імена викладачів DEPARTMENTs ІПЗ, які є кураторами груп із
-- рейтингом у діапазоні 20-30

SELECT DISTINCT
    t.name AS "Викладач"
  FROM teacher t
    JOIN sgroup g ON t.tch_pk = g.curator
    JOIN department d ON g.dep_fk = d.dep_pk
  WHERE d.name = 'ІПЗ'
        AND g.rating BETWEEN 20 AND 30;

-- 5

-- Вивести імена деканів факультетів, імена завідувачів кафедр яких не
-- містять підрядки 'петр'.

SELECT DISTINCT
    t.name AS "Декан"
  FROM teacher t
    JOIN faculty f ON t.tch_pk = f.dean_fk
  WHERE t.name NOT LIKE '%петр%';

-- 6

-- Вивести пари назв кафедр, що задовольняють наступній умові: перша
-- DEPARTMENT знаходиться на факультеті з фондом фінансування більшим, ніж
-- на 10000, фонду фінансування факультету другої DEPARTMENTs

SELECT DISTINCT
    d1.name AS "Перша кафедра",
    d2.name AS "Друга кафедра"
  FROM department d1
    JOIN faculty f1 ON d1.fac_fk = f1.fac_pk
    JOIN department d2 ON f1.fac_pk = d2.fac_fk
    JOIN faculty f2 ON d2.fac_fk = f2.fac_pk
  WHERE f1.fund > 10000
        AND f1.fund > f2.fund;

-- 7

-- Вивести номери аудиторій та їх корпуси, які задовольняють наступній
-- умові:
-- вони мають місткість в діапазоні 20-30 або в діапазоні 50-70 І
-- у них проводяться заняття у групах факультету 'комп'ютерні науки' або
-- 'комп'ютерні системи' І
-- у них проводять заняття викладачі доценти чи помічники

SELECT DISTINCT
    r.num,
    r.building
  FROM room r
    JOIN lecture l ON r.rom_pk = l.rom_fk
    JOIN sgroup g ON l.grp_fk = g.grp_pk
    JOIN department d ON g.dep_fk = d.dep_pk
    JOIN faculty f ON d.fac_fk = f.fac_pk
    JOIN teacher t ON l.tch_fk = t.tch_pk
  WHERE (r.seats BETWEEN 20 AND 30 OR r.seats BETWEEN 50 AND 70)
        AND (f.name = 'комп''ютерні науки' OR f.name = 'комп''ютерні системи')
        AND t.post IN ('assistant professor', 'assistant');
