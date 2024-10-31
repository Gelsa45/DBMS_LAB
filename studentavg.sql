Create table STUDENTS(ID NUMBER(5) primary key,NAME VARCHAR2(20),MARKS NUMBER);

INSERT INTO STUDENTS VALUES(1,'Rahul',90);
INSERT INTO STUDENTS VALUES(2,'Tom',73);
INSERT INTO STUDENTS VALUES(3,'Anaya',23);

SET SERVEROUTPUT ON

DECLARE
    avg_marks NUMBER(10);
    cdate DATE;
    cweek varchar2(10); 

BEGIN
    SELECT AVG(MARKS) INTO avg_marks FROM STUDENTS;
    DBMS_OUTPUT.PUT_LINE('Average Marks : '||avg_marks);
    if avg_marks<40 then
        dbms_output.put_line('Need Improvement ');
    else
        dbms_output.put_line('Good Average Marks');
    END if;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(' CURRENT DATE AND DAY:');
  DBMS_OUTPUT.PUT_LINE(SYSDATE || ' ' || TO_CHAR(SYSDATE, 'Day'));
END;
/
