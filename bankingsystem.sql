CREATE TABLE accounts (
    acc_num NUMBER(15) NOT NULL PRIMARY KEY,
    bal NUMBER(10)
);

INSERT INTO accounts VALUES (1234, 10000);
INSERT INTO accounts VALUES (4567, 5000);
INSERT INTO accounts VALUES (6789, 60000);
INSERT INTO accounts VALUES (1245, 10000);
INSERT INTO accounts VALUES (6980, 50000);
INSERT INTO accounts VALUES (7245, 2000);

SET SERVEROUTPUT ON;

-- Uncomment the ACCEPT statements in SQL*Plus or Oracle SQL Developer environment:
-- ACCEPT acc NUMBER PROMPT 'Enter Account Number: ';
-- ACCEPT operation CHAR PROMPT 'Enter operation (debit/credit): ';
-- ACCEPT amount NUMBER PROMPT 'Enter amount: ';

DECLARE
    acc NUMBER := &acc;
    operation VARCHAR2(20) := '&operation';
    balance NUMBER;
    min_bal NUMBER := 500;  -- Minimum balance
    amount NUMBER := &amount;
BEGIN
    IF operation = 'debit' THEN
        UPDATE accounts SET bal = bal - amount WHERE acc_num = acc;
    ELSIF operation = 'credit' THEN
        UPDATE accounts SET bal = bal + amount WHERE acc_num = acc;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid operation. Please enter either "debit" or "credit".');
        RETURN;
    END IF;

    SELECT bal INTO balance FROM accounts WHERE acc_num = acc;
    DBMS_OUTPUT.PUT_LINE('Balance : ' || balance);

    IF balance < min_bal THEN
        DBMS_OUTPUT.PUT_LINE('Warning! Maintain Minimum Balance!');
    END IF;
END;
/
