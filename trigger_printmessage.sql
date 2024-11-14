CREATE TABLE Student1(roll_number INT,name VARCHAR(50),s1_grade INT,s2_grade INT);

INSERT INTO Student1 values(101,'John doe',9,9);
INSERT INTO Student1 values(102,'Jone Smith',1,7);
INSERT INTO Student1 values(103,'Alice Johnson',2,6);
INSERT INTO Student1 values(104,'Bob Smith',7,8);
INSERT INTO Student1 values(105,'Emma Watson',8,6);

set SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER StudentTrigger
AFTER INSERT OR DELETE OR UPDATE ON Student1
FOR EACH ROW
DECLARE
    v_action_msg VARCHAR(100);
BEGIN
    IF INSERTING THEN
        v_action_msg := 'Inserting ' || :NEW.name;
    ELSIF DELETING THEN
        v_action_msg := 'Deleting ' || :OLD.name;
    ELSIF UPDATING THEN
        IF :OLD.name != :NEW.name THEN
            v_action_msg := 'Updated to ' || :NEW.name;
        ELSE
            v_action_msg := 'Updated name remains ' || :NEW.name;
        END IF;
    END IF;

   IF INSERTING THEN 
    DBMS_OUTPUT.PUT_LINE(v_action_msg);
   elsif updating then
    dbms_output.PUT_LINE(v_action_msg);
   else
    dbms_output.PUT_LINE(v_action_msg);
   END IF;
END;

/

