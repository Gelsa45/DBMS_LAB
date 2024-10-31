CREATE TABLE studentss(rollno INT,name VARCHAR(50),s1 INT,s2 INT);

INSERT INTO studentss VALUES(101,'John Doe',9,9);
INSERT INTO studentss VALUES(102,'Jane Smith',1,7);
INSERT INTO studentss VALUES(103,'Alice Johnson',2,6);
INSERT INTO studentss VALUES(104,'Bob Smith',7,8);
INSERT INTO studentss VALUES(105,'Emma Watson',8,6);

SET SERVEROUTPUT ON;

DECLARE
    CURSOR honor_students_cursor IS
        SELECT rollno, name, s1, s2
        FROM studentss
        WHERE(s1+s2)>12
        ORDER BY rollno;

    roll studentss.rollno%TYPE;
    sname studentss.name%TYPE;
    s1m studentss.s1%TYPE;
    s2m studentss.s2%TYPE;
    tot NUMBER;
    highest_mark NUMBER;
    highest_semester VARCHAR2(20);

BEGIN
    OPEN honor_students_cursor;
    DBMS_OUTPUT.PUT_LINE('Students Eligible for honors: ');
    
    LOOP
        FETCH honor_students_cursor INTO roll, sname, s1m, s2m;
        EXIT WHEN honor_students_cursor%NOTFOUND;
        
        tot := s1m + s2m;
        highest_mark := GREATEST(s1m, s2m); -- Find the highest mark between s1 and s2

        -- Determine the semester where the highest mark occurred
        IF s1m > s2m THEN
            highest_semester := 'Semester 1';
        ELSIF s2m > s1m THEN
            highest_semester := 'Semester 2';
        ELSE
            highest_semester := 'Both Semesters';
        END IF;

        DBMS_OUTPUT.PUT_LINE('Roll No: ' || roll || ', Name: ' || sname || ', S1: ' || s1m || ', S2: ' || s2m);
        DBMS_OUTPUT.PUT_LINE('Total Marks : ' || tot);
        DBMS_OUTPUT.PUT_LINE('Highest Mark for ' || sname || ': ' || highest_mark || ' in ' || highest_semester);
    END LOOP;

    CLOSE honor_students_cursor;
END;
/






