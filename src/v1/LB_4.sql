-- 3.1


INSERT INTO faculty (fac_pk, name, building, fund)
VALUES (1, 'informatics', 5, 573980.00),
       (2, 'economy', 3, 100000),
       (3, 'linguistics', 4, 500000);

INSERT INTO department (dep_pk, fac_fk, name, building, fund)
VALUES (1, 1, 'SE', 5, 99800.00),
       (2, 1, 'CAD', 5, 99000.00),
       (3, 1, 'DBMS', 4, 22000.00),
       (4, 2, 'Accounts', 3, 99000);

INSERT INTO teacher (tch_pk, dep_fk, name, post, tel, hire_date, salary, commission)
VALUES (0, 2, 'Sidorov', 'assistant', '2281319', TO_DATE('01.02.1948', 'dd.MM.yyyy'), 2500, 80),
       (2, 1, 'Perov', 'professor', '2281550', TO_DATE('01.07.1948', 'dd.MM.yyyy'), 1500, 150),
       (3, 2, 'Ivanov', 'assistant', NULL, TO_DATE('17.11.1948', 'dd.MM.yyyy'), 2400, 80),
       (4, 2, 'John', 'assistant', NULL, TO_DATE('11.11.1948', 'dd.MM.yyyy'), 2600, 100),
       (5, 2, 'Popov', 'assistant', NULL, TO_DATE('11.11.1948', 'dd.MM.yyyy'), 2600, 100);

UPDATE faculty
   SET dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Sidorov')
 WHERE fac_pk = 1;

UPDATE faculty
   SET dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Perov')
 WHERE fac_pk = 2;

UPDATE faculty
   SET dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Ivanov')
 WHERE fac_pk = 3;

UPDATE department
   SET head_fk = (SELECT tch_pk FROM teacher WHERE name = 'Sidorov')
 WHERE dep_pk = 1;

UPDATE department
   SET head_fk = (SELECT tch_pk FROM teacher WHERE name = 'Perov')
 WHERE dep_pk = 2;

UPDATE department
   SET head_fk = (SELECT tch_pk FROM teacher WHERE name = 'Popov')
 WHERE dep_pk = 3;


INSERT INTO sgroup (grp_pk, dep_fk, course, num, quantity, curator, rating)
VALUES (1, 1, 1, 101, 33, 4, 20),
       (2, 1, 1, 102, 35, 5, 22),
       (3, 3, 2, 205, 20, 1, 15),
       (4, 3, 3, 305, 25, NULL, 40),
       (5, 3, 4, 405, 25, 2, 37);

INSERT INTO subject (sbj_pk, name)
VALUES (1, 'pascal'),
       (2, 'C'),
       (3, 'OS'),
       (4, 'inernet'),
       (5, 'dbms');

INSERT INTO room (rom_pk, num, seats, floor, building)
VALUES (1, 101, 20, 1, 5),
       (2, 316, 150, 3, 5),
       (3, 201, 150, 2, 2),
       (4, 202, 30, 2, 5);

INSERT INTO lecture (tch_fk, grp_fk, sbj_fk, rom_fk, type, day, week, lesson)
VALUES (1, 1, 1, 1, 'lecture', 'mon', 1, 1),
       (1, 2, 2, 1, 'lab', 'mon', 1, 2),
       (2, 3, 3, 1, 'lecture', 'tue', 1, 3),
       (2, 4, 4, 2, 'practice', 'wed', 1, 5),
       (4, 4, 5, 2, 'practice', 'thu', 2, 4),
       (4, 4, 5, 3, 'lab', 'fri', 2, 1);


INSERT INTO faculty (fac_pk, name, building, fund, dean_fk)
VALUES (99, '126', 1, 102102, NULL);

INSERT INTO department (dep_pk, fac_fk, name, building, fund, head_fk)
VALUES (99, 99, 'ipzas', 1, 20102, NULL);


INSERT INTO teacher (tch_pk, dep_fk, name, post, tel, hire_date, salary, chief_fk)
VALUES (99, 99, 'Ivanov', 'assistant', '2281319', TO_DATE('01.02.1948', 'dd.MM.yyyy'), 1800, 100),
       (100, 99, 'Petrov', 'professor', '2281550', TO_DATE('01.07.1948', 'dd.MM.yyyy'), 1800, NULL),
       (101, 99, 'Sidorov', 'assistant', NULL, TO_DATE('17.11.1948', 'dd.MM.yyyy'), 1800, 100),
       (102, 99, 'Perov', 'assistant', NULL, TO_DATE('11.11.1948', 'dd.MM.yyyy'), 1800, 100);
--     ...

UPDATE faculty
   SET dean_fk = 100
 WHERE fac_pk = 99;

UPDATE department
   SET head_fk = 100
 WHERE dep_pk = 99;

INSERT INTO sgroup (grp_pk, dep_fk, course, num, quantity, curator)
VALUES (99, 99, 2, 23, 27, NULL);

INSERT INTO subject (sbj_pk, name)
VALUES (99, 'kmi');

INSERT INTO lecture (tch_fk, grp_fk, sbj_fk, rom_fk, type, day, week, lesson)
VALUES (99, 99, 99, 1, 'lecture', 'mon', 1, 1);


-- 3.2

UPDATE faculty
   SET dean_fk = (SELECT tch_pk FROM teacher WHERE name = 'Bob'),
       fund = 3467.00
 WHERE name = 'economy';

UPDATE department
   SET head_fk = (SELECT tch_pk FROM teacher WHERE name = 'Frank'),
       building = 3
 WHERE dep_pk = 3;

UPDATE teacher
   SET commission = 25
 WHERE post = 'assistant';

UPDATE sgroup
   SET rating = 0
 WHERE course = 1;

UPDATE subject
   SET name = 'html'
 WHERE name = 'internet';


-- 3.3

-- Для кожного вчителя з таблиці ВЧИТЕЛЬ виведіть його ім’я, посаду,
-- зарплату, комісію, відсоток комісійної винагороди по відношенню
-- до заробітної плати (результатна назва стовпця «Відсоток 1»),
-- відсоток зарплати по відношенню до комісії (отримана назва стовпця
-- це «Відсоток 2»).

SELECT name,
       post,
       salary,
       commission,
       commission / NULLIF(salary, 0) * 100 AS "Відсоток 1",
       salary / NULLIF(commission, 0) * 100 AS "Відсоток 2"
  FROM teacher;


-- Для кожного факультету вивести його назву та назви предметів, які
-- викладають викладачі факультету

SELECT f.name,
       s.name
  FROM faculty AS f,
       department AS d,
       teacher AS t,
       lecture AS l,
       subject AS s
 WHERE f.fac_pk = d.fac_fk
   AND d.dep_pk = t.dep_fk
   AND t.tch_pk = l.tch_fk
   AND l.sbj_fk = s.sbj_pk;

-- SELECT f.name,
--        s.name
--   FROM faculty AS f
--            JOIN department AS d ON f.fac_pk = d.fac_fk
--            JOIN teacher AS t ON d.dep_pk = t.dep_fk
--            JOIN lecture AS l ON t.tch_pk = l.tch_fk
--            JOIN subject AS s ON l.sbj_fk = s.sbj_pk;


-- Вивести  підлеглих викладача Сидорова

SELECT t1.name
  FROM teacher AS t1,
       teacher AS t2
 WHERE t1.chief_fk = t2.tch_pk
   AND t2.name = 'Sidorov';

-- SELECT t1.name
--   FROM teacher AS t1
--            JOIN teacher AS t2 ON t1.chief_fk = t2.tch_pk
--  WHERE t2.name = 'Sidorov';


-- Вивести назви кафедр факультету «інформатики» з фондом в
-- діапазоні 250000-350000

SELECT d.name
  FROM faculty AS f,
       department AS d
 WHERE f.fac_pk = d.fac_fk
   AND f.name = 'інформатика'
   AND d.fund BETWEEN 250000 AND 350000;


-- SELECT d.name
--   FROM faculty AS f
--            JOIN department AS d ON f.fac_pk = d.fac_fk
--  WHERE f.name = 'інформатика'
--    AND d.fund BETWEEN 250000 AND 350000;

-- Вивести прізвища викладачів-професорів, які працюють на
-- факультетах, розташованих у корпусах 2,3,6,7,8,10

SELECT t.name
  FROM faculty AS f,
       department AS d,
       teacher AS t
 WHERE f.fac_pk = d.fac_fk
   AND d.dep_pk = t.dep_fk
   AND f.building IN ('2', '3', '6', '7', '8', '10')
   AND t.post = 'professor';

-- SELECT t.name
--   FROM faculty AS f
--            JOIN department AS d ON f.fac_pk = d.fac_fk
--            JOIN teacher AS t ON d.dep_pk = t.dep_fk
--  WHERE f.building IN ('2', '3', '6', '7', '8', '10')
--    AND t.post = 'professor';


-- Вивести назви кафедр та прізвища викладачів, які працюють на цих
-- DEPARTMENTх. Якщо на якійсь кафедрі немає викладачів, то ця
-- DEPARTMENT все одно відображається, але замість імені викладача
-- в ній буде рядок «IS ABSENT»

SELECT d.name,
       COALESCE((SELECT STRING_AGG(name, ', ') AS t_name
                   FROM teacher AS t
                  WHERE t.dep_fk = d.dep_pk),
                'IS ABSENT'
           ) AS teachers
  FROM department AS d;

-- SELECT d.name,
--        COALESCE(t.name, 'IS ABSENT') AS teachers
--   FROM department AS d
--            LEFT JOIN teacher AS t ON d.dep_pk = t.dep_fk;


-- Виведіть імена викладачів факультету «інформатика» із зарплатою
-- понад 1200 АБО імена викладачів факультету «комп’ютерні
-- системи» із зарплатою понад 1500

SELECT t.name
  FROM faculty AS f,
       department AS d,
       teacher AS t
 WHERE f.fac_pk = d.fac_fk
     AND d.dep_pk = t.dep_fk
     AND ((f.name = 'informatics' AND t.salary > 1200)
         OR (f.name = 'economy' AND t.salary > 1500));

-- SELECT t.name
--   FROM faculty AS f
--            JOIN department AS d ON f.fac_pk = d.fac_fk
--            JOIN teacher AS t ON d.dep_pk = t.dep_fk
--  WHERE (f.name = 'informatics' AND t.salary > 1200)
--     OR (f.name = 'economy' AND t.salary > 1500);
