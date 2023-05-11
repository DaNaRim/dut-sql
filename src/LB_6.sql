-- 1) Для кожної кафедри, розташованої в одній будівлі з факультетом, деканом якої є Іванов, вивести наступну інформацію у стовпці з відповідними назвами:
-- - Назва кафедри 	- Назва кафедри
-- - П.І.Б. завідувача кафедри 	- начальник відділу

SELECT d.name AS "Назва кафедри",
       t.name AS "Завідувач кафедри",
       f.name AS "Факультет",
       t2.name AS "Начальник відділу"
  FROM department AS d
           JOIN faculty AS f ON f.fac_pk = d.fac_fk
           JOIN teacher t ON t.tch_pk = f.dean_fk
           JOIN teacher t2 ON t2.tch_pk = d.head_fk
 WHERE t.name = 'Ivanov'
   AND f.building = d.building;

-- 2) Вивести назву факультетів, які мають кафедри в корпусі 6

SELECT DISTINCT f.name
  FROM faculty AS f
           JOIN department d ON f.fac_pk = d.fac_fk
 WHERE d.building = '5';

-- 3) Виведіть назви факультетів та назви їх деканатів, які розташовані в корпусі 6 і мають принаймні одну кафедру в корпусі 5

SELECT DISTINCT f.name,
                d.name
  FROM faculty AS f
           JOIN department d ON f.fac_pk = d.fac_fk
 WHERE d.building = '5'
   AND f.building = '6';

-- 4) Виведіть назви факультетів, бюджет яких на 200 000 більше, ніж кошти всіх їхніх відділів.
--USE ALL

-- SELECT DISTINCT f.name
--   FROM faculty AS f
--            JOIN department d ON f.fac_pk = d.fac_fk
--  WHERE (f.fund - (SELECT SUM(d.fund) AS "fund"
--                     FROM department d
--                    WHERE d.fac_fk = f.fac_pk)) > 200000;

SELECT f.name
  FROM faculty AS f
           JOIN department d ON f.fac_pk = d.fac_fk
 GROUP BY f.name, f.fund
HAVING f.fund - SUM(d.fund) > 200000;


-- 5) Вивести такі пари значень : «назва предмета – прізвище викладача», де:
-- - цей учитель викладає цей предмет;
-- - Він викладає цей предмет більше, ніж у 2 груп
-- - Він має більше лекцій з цього предмету, ніж викладач Іванов з предмету СУБД

SELECT s.name,
       t.name,
       COUNT(g.*)
  FROM subject AS s
           JOIN lecture l ON s.sbj_pk = l.sbj_fk
           JOIN teacher t ON t.tch_pk = l.tch_fk
           JOIN sgroup g ON l.grp_fk = g.grp_pk
 GROUP BY s.name, t.name
HAVING COUNT(g.grp_pk) > 2
   AND (SELECT COUNT(l2.*)
          FROM lecture l2
                   JOIN subject s3 ON s3.sbj_pk = l2.sbj_fk
                   JOIN teacher t2 ON t2.tch_pk = l2.tch_fk
         WHERE t2.name = 'Ivanov'
           AND s3.name = 'СУБД') < COUNT(l.*)
 ORDER BY s.name, t.name;

-- 6) Вивести середню кількість предметів на один факультет.

SELECT AVG(cnt)
  FROM (SELECT COUNT(sbj_fk) AS cnt
          FROM lecture
                   JOIN sgroup g ON lecture.grp_fk = g.grp_pk
                   JOIN department d ON g.dep_fk = d.dep_pk
                   JOIN faculty f ON d.fac_fk = f.fac_pk
         GROUP BY f.fac_pk) AS t;

-- 7) Для кожного факультету в корпусі 6 вивести:
-- - назва факультету
-- - кількість кафедр на факультеті
-- - загальний фонд усіх кафедр на факультеті
-- - кількість студентів на факультеті

SELECT f.name,
       COUNT(d.*) AS "Кількість кафедр",
       SUM(d.fund) AS "Загальний фонд",
       SUM(g.quantity) AS "Кількість студентів"
  FROM faculty AS f
           JOIN department d ON f.fac_pk = d.fac_fk
           LEFT JOIN sgroup g ON d.dep_pk = g.dep_fk
 WHERE f.building = '5'
 GROUP BY f.fac_pk;
