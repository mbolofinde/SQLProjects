/* DROP the existing procedure if any with the same before creating */ 
DROP PROCEDURE IF EXISTS create_emp;

/* Change the delimiter to $$ */ 
DELIMITER $$ 

/* IN specifies the variables taken as arguments, INOUT specifies the output variable*/

CREATE PROCEDURE create_emp (OUT new_emp_no INT, IN first_name varchar(20), IN last_name varchar(20), 
IN gender enum('M', 'F'), IN birth_date date, IN emp_dept_name varchar(40), IN title varchar(50)) 

BEGIN
/* Declare variables for emp_dept_no and salary */
	DECLARE emp_dept_no char(4);
    DECLARE salary int DEFAULT 60000;

/* Select the maximum employee number into the variable new_emp_no */
	SELECT max(emp_no) INTO new_emp_no FROM employees;

/* Increment the new_emp_no */
SET new_emp_no = new_emp_no +  1; 

 /* INSERT the data into employees table */
 
 /* The function CURDATE() gives the current date) */
 
	INSERT INTO employees VALUES(new_emp_no, birth_date, first_name, last_name, gender, CURDATE());
    
/* Find out the dept_no for dept_name */
    SELECT emp_dept_name;
    SELECT dept_no INTO emp_dept_no FROM departments WHERE dept_name=emp_dept_name;
    SELECT emp_dept_no;
    
/* Insert into dept_emp */
    INSERT INTO dept_emp VALUES(new_emp_no, emp_dept_no, CURDATE(), '9999-01-01');

/* Insert into titles */
    INSERT INTO titles VALUES(new_emp_no, title, CURDATE(), '9999-01-01');

/* Find salary based on title */
    IF title = 'Staff' 
        THEN SET salary = 100000;
    ELSEIF title = 'Senior Staff' 
        THEN SET salary = 120000;
    END IF;

/* Insert into salaries */
    INSERT INTO salaries VALUES(new_emp_no, salary, CURDATE(), '9999-01-01');
END
$$
/* Change the delimiter back to ; */
DELIMITER ;