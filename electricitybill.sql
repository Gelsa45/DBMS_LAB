CREATE TABLE consumer_table (
    consumer_no NUMBER PRIMARY KEY,
    consumer_name VARCHAR2(50),
    past_reading NUMBER,
    present_reading NUMBER
);
INSERT INTO consumer_table VALUES (1001, 'Jeslin', 100, 200);
INSERT INTO consumer_table VALUES (1002, 'Gelsa', 100, 250);
INSERT INTO consumer_table VALUES (1003, 'Anu', 500, 600);
INSERT INTO consumer_table VALUES (1004, 'Ardra', 750, 1200);
SELECT * FROM consumer_table;

SET SERVEROUTPUT ON;

DECLARE
    v_consumer_no NUMBER;
    v_past_reading NUMBER;
    v_present_reading NUMBER;
    v_units_consumed NUMBER;
    v_charge NUMBER;
    v_new_present_reading NUMBER;

    -- Cursor to fetch past and present readings for a consumer
    CURSOR c_consumer(p_consumer_no NUMBER) IS 
        SELECT past_reading, present_reading 
        FROM consumer_table 
        WHERE consumer_no = p_consumer_no;

BEGIN
    -- Prompt for the consumer number
    DBMS_OUTPUT.PUT_LINE('Enter Consumer Number:');
    v_consumer_no := &consumer_no;
 
    -- Open cursor and fetch readings
    OPEN c_consumer(v_consumer_no);
    FETCH c_consumer INTO v_past_reading, v_present_reading;

    IF c_consumer%FOUND THEN
        -- Prompt for the new present reading
        DBMS_OUTPUT.PUT_LINE('Current Present Reading (previously was ' || v_present_reading || '):');
        v_new_present_reading := &new_present_reading;

        -- Calculate units consumed
        v_units_consumed := v_new_present_reading - v_present_reading;

        -- Update the present reading in the table
        UPDATE consumer_table 
        SET past_reading = v_present_reading, 
            present_reading = v_new_present_reading 
        WHERE consumer_no = v_consumer_no;

        -- Calculate charge based on units consumed
        IF v_units_consumed <= 100 THEN
            v_charge := v_units_consumed * 5;
        ELSIF v_units_consumed BETWEEN 101 AND 200 THEN
            v_charge := (100 * 5) + ((v_units_consumed - 100) * 10);
        ELSE
            v_charge := (100 * 5) + (100 * 10) + ((v_units_consumed - 200) * 15);
        END IF;

        -- Display the output
        DBMS_OUTPUT.PUT_LINE('Consumer No: ' || v_consumer_no);
        DBMS_OUTPUT.PUT_LINE('Units Consumed: ' || v_units_consumed);
        DBMS_OUTPUT.PUT_LINE('Total Charge: ' || v_charge);

    ELSE
        DBMS_OUTPUT.PUT_LINE('No data found for Consumer No: ' || v_consumer_no);
    END IF;

    -- Close the cursor
    CLOSE c_consumer;
END;
/
