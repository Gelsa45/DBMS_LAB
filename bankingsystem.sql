CREATE TABLE accounts (acc_num NUMBER(15) NOT NULL PRIMARY KEY,bal NUMBER(10));

INSERT INTO accounts values(1234,10000);
INSERT INTO accounts values(4567,5000);
INSERT INTO accounts values(6789,60000);
INSERT INTO accounts values(1245,10000);
INSERT INTO accounts values(6980,50000);
INSERT INTO accounts values(7245,2000);

SET SERVEROUTPUT ON;

ACCEPT acc NUMBER PROMPT 'Enter Account Number : ';
ACCEPT operation CHAR PROMPT 'Enter operation (debit/credit) : ';
ACCEPT amount NUMBER PROMPT 'Enter amount : ';

DECLARE
    balance Number(10);
    min_bal Number(10) := 500;  -- Initialize min_bal with 500
    amount NUMBER := &amount;

BEGIN
    IF '&operation' = 'debit' THEN
        UPDATE accounts SET bal = bal - amount WHERE acc_num = &acc;
    ELSIF '&operation' = 'credit' THEN
        UPDATE accounts SET bal = bal + amount WHERE acc_num = &acc;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid operation. Please enter either "debit" or "credit".');
        RETURN;
    END IF;

    SELECT bal INTO balance FROM accounts WHERE acc_num = &acc;
    DBMS_OUTPUT.PUT_LINE('Balance : ' || balance);

    IF balance < min_bal THEN
        DBMS_OUTPUT.PUT_LINE('Warning! Maintain Minimum Balance!');
    END IF;
END;
/
