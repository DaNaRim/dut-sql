-- 1

-- За кожною групою, якою читають таку саму дисципліну, як і групам кафедри ІПО,
--     вивести номер групи та назву її кафедри. Примітка: не виводити групи кафедр ІПО

SELECT DISTINCT
    sgroup.num,
    department.name
FROM sgroup
    JOIN lecture ON sgroup.grp_pk = lecture.grp_fk
    JOIN subject ON lecture.sbj_fk = subject.sbj_pk
    JOIN department ON sgroup.dep_fk = department.dep_pk
WHERE
    subject.name IN (
        SELECT
            subject.name
        FROM sgroup
            JOIN lecture ON sgroup.grp_pk = lecture.grp_fk
            JOIN subject ON lecture.sbj_fk = subject.sbj_pk
            JOIN department ON sgroup.dep_fk = department.dep_pk
        WHERE
            department.name = 'ІПО'
    )
    AND department.name <> 'ІПО';

-- 2

-- Вивести кафедри та їх корпуси факультету комп'ютерних наук,' ||
--     ' які (кафедри) розташовуються в корпусі, що відрізняється від корпусу факультету комп'ютерних наук

SELECT DISTINCT
    department.name,
    department.building
FROM department
    JOIN faculty ON department.fac_fk = faculty.fac_pk
WHERE
    faculty.name = 'Комп''ютерних наук'
    AND department.building <> (
        SELECT
            department.building
        FROM department
            JOIN faculty ON department.fac_fk = faculty.fac_pk
        WHERE
            faculty.name = 'Комп''ютерних наук'
    );

-- 3

-- Вивести номери та місткість аудиторій з корпусу 5 або 6, в яких немає занять на 2-3-й парі у середу першого тижня.

SELECT DISTINCT
    room.num,
    room.seats
FROM room
    JOIN lecture ON room.rom_pk = lecture.rom_fk
WHERE
    room.building IN ('5', '6')
    AND lecture.day = 'wed'
    AND lecture.week = 1
    AND lecture.lesson NOT IN (2, 3);

-- 4

-- Вивести номери аудиторій, у яких проводяться заняття з дисципліни СУБД, та які розташовані в одному з корпусів,
--     у яких є заняття у групах 3-го курсу кафедри ІПО

SELECT DISTINCT
    room.num
FROM room
    JOIN lecture ON room.rom_pk = lecture.rom_fk
    JOIN subject ON lecture.sbj_fk = subject.sbj_pk
    JOIN sgroup ON lecture.grp_fk = sgroup.grp_pk
    JOIN department ON sgroup.dep_fk = department.dep_pk
WHERE
    subject.name = 'СУБД'
    AND room.building IN (
        SELECT
            room.building
        FROM room
            JOIN lecture ON room.rom_pk = lecture.rom_fk
            JOIN sgroup ON lecture.grp_fk = sgroup.grp_pk
            JOIN department ON sgroup.dep_fk = department.dep_pk
        WHERE
            department.name = 'ІПО'
            AND sgroup.course = 3
    );

-- 5

-- Вивести назви факультетів, на яких сумарна кількість студентів у групах із рейтингом у діапазоні 10-50 більше,
--     ніж у всіх групах 5-го курсу факультету, на якому завідувачем є Іванов

SELECT DISTINCT
    faculty.name
FROM faculty
    JOIN department ON faculty.fac_pk = department.fac_fk
    JOIN sgroup ON department.dep_pk = sgroup.dep_fk
WHERE
    sgroup.rating BETWEEN 10 AND 50
    AND sgroup.quantity > (
        SELECT
            SUM(sgroup.quantity)
        FROM faculty
            JOIN department ON faculty.fac_pk = department.fac_fk
            JOIN sgroup ON department.dep_pk = sgroup.dep_fk
        WHERE
            faculty.dean_fk = (
                SELECT
                    teacher.tch_pk
                FROM teacher
                WHERE
                    teacher.name = 'Іванов'
            )
            AND sgroup.course = 5
    );

-- 6

-- Вивести номер групи з мінімальним рейтингом, разом із цим рейтингом, та номер групи з максимальним рейтингом,
--     разом із цим рейтингом)

SELECT
    sgroup.num,
    sgroup.rating
FROM sgroup
WHERE
    sgroup.rating = (
        SELECT
            MIN(sgroup.rating)
        FROM sgroup
    )
UNION
SELECT
    sgroup.num,
    sgroup.rating
FROM sgroup
WHERE
    sgroup.rating = (
        SELECT
            MAX(sgroup.rating)
        FROM sgroup
    );

-- 7

-- За кожною групою, куратором якої є викладач кафедри ІПО, вивести:
-- - Номер групи
-- - кількість викладачів-професорів, які викладають у цій групі
-- - кількість аудиторій 6-го корпусу, у яких проводяться заняття у цій групі
-- за умови, що в цій групі викладається менше 5 дисциплін

SELECT DISTINCT
    sgroup.num,
    COUNT(teacher.post = 'professor') AS professors,
    COUNT(room.building = '6') AS rooms
FROM sgroup
    JOIN lecture ON sgroup.grp_pk = lecture.grp_fk
    JOIN teacher ON lecture.tch_fk = teacher.tch_pk
    JOIN room ON lecture.rom_fk = room.rom_pk
WHERE
    sgroup.curator = (
        SELECT
            teacher.tch_pk
        FROM teacher
            JOIN department ON teacher.dep_fk = department.dep_pk
        WHERE
            department.name = 'ІПО'
    )
GROUP BY sgroup.num
HAVING
    COUNT(lecture.sbj_fk) < 5;
