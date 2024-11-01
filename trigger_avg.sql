CREATE TABLE Student (Sid INT PRIMARY KEY,name VARCHAR(50),Subj1 INT,Subj2 INT,Subj3 INT,Total INT,Avg DECIMAL(5, 2));

INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) VALUES (1, 'John Doe', 80, 90, 85);

INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) VALUES (2, 'Jane Smith', 70, 75, 80);

INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) VALUES (3, 'Alice Johnson', 85, 95, 90);


CREATE OR REPLACE TRIGGER calculate_total_avg
BEFORE INSERT OR UPDATE ON Student
FOR EACH ROW
BEGIN
    :NEW.TOTAL := :NEW.SUBJ1 + :NEW.SUBJ2 + :NEW.SUBJ3;
    :NEW.AVG := :NEW.TOTAL / 3;
END;
/
