CREATE TABLE consumer_table (consumer_no NUMBER PRIMARY KEY,consumer_name VARCHAR2(50),past_reading NUMBER,present_reading NUMBER);

insert into consumer_table values(101, 'Alan',350, 450);
insert into consumer_table values(102, 'Henry', 100, 250);
insert into consumer_table values(103, 'John', 500, 600);
insert into consumer_table values(104, 'Evan', 750, 1200);
insert into consumer_table values (105, 'Marco', 57,132);
insert into consumer_table values (106, 'Greek', 132,210);
insert into consumer_table values (107, 'Bro', 801,1000);
insert into consumer_table values (108, 'Ivan', 199,340);
insert into consumer_table values (303, 'Jill', 222,342);
insert into consumer_table values (305, 'Kelvin', 399,456);
insert into consumer_table values (310, 'Calvin', 499,654);

SET SERVEROUTPUT ON;

DECLARE
   v_consumer_no   NUMBER;
   v_past_reading  NUMBER;
   v_present_reading NUMBER;
   v_units_consumed NUMBER;
   v_charge NUMBER;

   CURSOR c_consumer (p_consumer_no NUMBER) IS
     SELECT past_reading, present_reading
     FROM consumer_table
     WHERE consumer_no = p_consumer_no;  

BEGIN
   
   DBMS_OUTPUT.PUT_LINE('Enter Consumer Number:');
   v_consumer_no := &consumer_no;
   OPEN c_consumer(v_consumer_no);
   FETCH c_consumer INTO v_past_reading, v_present_reading;

   IF c_consumer%FOUND THEN
     
      v_units_consumed := v_present_reading - v_past_reading;

      
      IF v_units_consumed <= 100 THEN
         v_charge := v_units_consumed * 5;
      ELSIF v_units_consumed BETWEEN 101 AND 300 THEN
         v_charge := (100 * 5) + (v_units_consumed - 100) * 7.5;
      ELSIF v_units_consumed BETWEEN 301 AND 500 THEN
         v_charge := (100 * 5) + (200 * 7.5) + (v_units_consumed - 300) * 15;
      ELSE
         v_charge := (100 * 5) + (200 * 7.5) + (200 * 15) + (v_units_consumed - 500) * 22.5;
      END IF;

      
      DBMS_OUTPUT.PUT_LINE('Consumer No: ' || v_consumer_no);
      DBMS_OUTPUT.PUT_LINE('Units Consumed: ' || v_units_consumed);
      DBMS_OUTPUT.PUT_LINE('Total Charge: ' || v_charge);
   ELSE
      DBMS_OUTPUT.PUT_LINE('No data found for Consumer No: ' || v_consumer_no);
   END IF;

   CLOSE c_consumer;
END;
/

