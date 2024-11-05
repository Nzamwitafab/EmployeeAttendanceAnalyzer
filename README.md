# Employee Attendance Analysis System
## Group 5 Members:
### 1. Nzamwitakuze Fabrice 24855
### 2. Ngomituje Samuel 26771
### 3. Isaro Muhirwa Ola 26878
### 4. Manishimwe Kwizera Jean Luc 26972 
### 5. Mutoni Samillah 26851
### 6. KIBONDO Impano Keza Cardine 26954
### 7. Rukundo Fabrice 26472
### 8. Abdourahamane adoum Gadam 24973

## Table of Contents
1. [Introduction](#introduction)
2. [Tables Creation](#tables-creation)
3. [Inserting Data into Tables](#inserting-data-into-tables)
4. [Procedure Creation](#procedure-creation)
5. [Testing the Procedure](#testing-the-procedure)

## Introduction

The Employee Attendance Analysis System is a database application designed to analyze employee attendance records over a specific period. This system leverages PL/SQL to calculate the total number of "Present" and "Absent" days for each employee within a specified month and year. The system is implemented in Oracle Database, utilizing two tables: `Employees` to store employee information and `Attendance` to store daily attendance records. A PL/SQL procedure, `Calculate_Attendance_Statistics`, is used to generate and display attendance statistics.

## Tables Creation

```sql
--creating the table of employees 
create table employees (
   employee_id number primary key,
   first_name  varchar2(50),
   last_name   varchar2(50)
);
--creating the table of attendance
create table attendance (
   attendance_id   number primary key,
   employee_id     number
      references employees ( employee_id ),
   attendance_date date,
   status          varchar2(10) check ( status in ( 'Present',
                                           'Absent' ) )
);
```
### Output

![tables creation](https://github.com/user-attachments/assets/e6da835a-fe8f-4830-a38e-b271358b6ba5)

## Data Insertion
```sql

-- Insert sample employees
insert into employees (
   employee_id,
   first_name,
   last_name
) values ( 1,
           'Fabrice',
           'Nzamwitakuze' );
insert into employees (
   employee_id,
   first_name,
   last_name
) values ( 2,
           'Isaro',
           'Muhirwa' );

-- Insert sample attendance records
insert into attendance (
   attendance_id,
   employee_id,
   attendance_date,
   status
) values ( 1,
           1,
           date '2024-10-01',
           'Present' );
insert into attendance (
   attendance_id,
   employee_id,
   attendance_date,
   status
) values ( 2,
           1,
           date '2024-10-02',
           'Absent' );
insert into attendance (
   attendance_id,
   employee_id,
   attendance_date,
   status
) values ( 3,
           2,
           date '2024-10-01',
           'Present' );
insert into attendance (
   attendance_id,
   employee_id,
   attendance_date,
   status
) values ( 4,
           2,
           date '2024-10-02',
           'Present' );


commit;
```
### Output

![data_insertion](https://github.com/user-attachments/assets/6207264b-ed7a-46ec-98a9-7f16e24cb091)

## Procedure Creation
```sql
create or replace procedure calculate_attendance_statistics (
   p_month number,
   p_year  number
) as -- the two variables are considered as our parameters for our procedure
   cursor emp_cursor is
   select e.employee_id,
          e.first_name
          || ' '
          || e.last_name as full_name
     from employees e;

   total_present number;
   total_absent  number;
begin
   dbms_output.put_line('Starting attendance analysis...');
   for emp_rec in emp_cursor loop
      total_present := 0;
      total_absent := 0;
      dbms_output.put_line('Processing employee: ' || emp_rec.full_name);

        -- Loop through attendance records for the employee
      for att_rec in (
         select status
           from attendance
          where employee_id = emp_rec.employee_id
            and extract(month from attendance_date) = p_month
            and extract(year from attendance_date) = p_year
      ) loop
            -- Count Present and Absent days
         if att_rec.status = 'Present' then
            total_present := total_present + 1;
         elsif att_rec.status = 'Absent' then
            total_absent := total_absent + 1;
         end if;
      end loop;

        -- Check if any records were found for the employee
      if
         total_present = 0
         and total_absent = 0
      then
         dbms_output.put_line('No attendance records found for '
                              || emp_rec.full_name
                              || ' in the specified month and year.');
      else
            -- Display results for each employee
         dbms_output.put_line('Employee: ' || emp_rec.full_name);
         dbms_output.put_line('Total Presents: ' || total_present);
         dbms_output.put_line('Total Absents: ' || total_absent);
         dbms_output.put_line('---------------------------------');
      end if;
   end loop;

   dbms_output.put_line('Attendance analysis completed.');
end;
/

commit;
```
### Output

![procedure creation](https://github.com/user-attachments/assets/b310fc3b-6358-4412-8513-4a94c9f306f9)


## Testing
```sql
-- Enable server output to display results
SET SERVEROUTPUT ON;

begin
   calculate_attendance_statistics(
      p_month => 10,
      p_year  => 2024
   );
end;
/
```

### Output


![testingoutput](https://github.com/user-attachments/assets/af438b84-6485-44f4-aa3b-9eb137fe3e96)

