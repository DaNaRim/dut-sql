-- 1)	Скільки предметів міститься в таблиці ПРЕДМЕТ. Колонка підсумкової таблиці повинна мати назву «Кількість предметів »

SELECT COUNT(*) AS "Кількість предметів"
  FROM subject;

-- 2)	Скільки предметів викладають студенти факультету « Інформатика».

SELECT COUNT(s.*) AS "Кількість предметів"
  FROM subject AS s
           JOIN lecture AS l ON l.sbj_fk = s.sbj_pk
           JOIN teacher AS t ON t.tch_pk = l.tch_fk
           JOIN department AS d ON d.dep_pk = t.dep_fk
           JOIN faculty AS f ON f.fac_pk = d.fac_fk
 WHERE f.name = 'informatics';

-- 3)	Виведіть подвоєну середню кількість студентів у групах факультету « інформатика».

SELECT 2 * AVG(g.quantity) AS "Подвоєна середня кількість студентів"
  FROM sgroup AS g
           JOIN department AS d ON d.dep_pk = g.dep_fk
           JOIN faculty AS f ON d.fac_fk = f.fac_pk
 WHERE f.name = 'informatics';

-- 4)	Для кожного факультету вихід його назва та різниця між його фондом і загальними фондами всіх його відділів.

SELECT f.name,
       f.fund - SUM(d.fund) AS "Різниця між фондом факультету і фондами відділів"
  FROM faculty AS f
           JOIN department AS d ON d.fac_fk = f.fac_pk
 GROUP BY f.name, f.fund;

-- 5)	Для кожного значення (зарплата + премія), що виплачується викладачам факультету, деканом якого є Іванов,
-- виведіть це ( зарплата + премія) , кількість викладачів із цією зарплатою + премія та кількість кафедр,
-- на яких працюють ці викладачі . Відповідні графи мають назви: «Заробітна плата», «Кількість викладачів»
-- і «Кількість кафедр »

SELECT t.salary + t.commission AS "Заробітна плата",
       COUNT(t.*) AS "Кількість викладачів",
       COUNT(DISTINCT d.dep_pk) AS "Кількість кафедр",
       STRING_AGG(t.name, ', ') AS "Викладачі"
  FROM teacher AS t
           JOIN department AS d ON d.dep_pk = t.dep_fk
           JOIN faculty AS f ON f.fac_pk = d.fac_fk
           JOIN teacher AS t2 ON t2.tch_pk = f.dean_fk
 WHERE t2.name = 'Ivanov'
 GROUP BY t.salary + t.commission;

-- 6)	Для кожного викладача факультету комп’ютерних наук вивести :
-- - ім'я ,
-- - пост
-- - кількість предметів, які він викладає ,
-- за умови , що :
-- - читає лекції не більше ніж у 3 групах, а
-- - проводить лекції не більше ніж у 2 аудиторіях

SELECT t.name,
       t.post,
       COUNT(l.*) AS "Кількість предметів"
  FROM teacher AS t
           JOIN lecture AS l ON l.tch_fk = t.tch_pk
           JOIN sgroup AS g ON g.grp_pk = l.grp_fk
           JOIN room AS r ON r.rom_pk = l.rom_fk
           JOIN department AS d ON d.dep_pk = t.dep_fk
           JOIN faculty AS f ON f.fac_pk = d.fac_fk
 WHERE f.name = 'informatics'
 GROUP BY t.name, t.post
HAVING COUNT(DISTINCT g.grp_pk) <= 2;

-- 7)	Для аудиторій 6 корпусу, в яких проводяться лекції для студентів 3 курсу, вивести її номер та назву кафедри .
-- Результат сортувати за номером кімнати в висхідному порядку, за назвою кафедри в порядку спадання.

SELECT r.num,
       d.name
  FROM room AS r
           JOIN lecture AS l ON l.rom_fk = r.rom_pk
           JOIN sgroup AS g ON g.grp_pk = l.grp_fk
           JOIN department AS d ON d.dep_pk = g.dep_fk
 WHERE r.building = '6'
   AND g.course = 3
 GROUP BY r.num, d.name
 ORDER BY r.num, d.name DESC;
