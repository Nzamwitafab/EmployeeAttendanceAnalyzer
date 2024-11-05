# Employee Attendance Analysis System

## Table of Contents
1. [Introduction](#introduction)
2. [Tables Creation](#tables-creation)
3. [Inserting Data into Tables](#inserting-data-into-tables)
4. [Procedure Creation](#procedure-creation)
5. [Testing the Procedure](#testing-the-procedure)

## Introduction

The Employee Attendance Analysis System is a database application designed to analyze employee attendance records over a specific period. This system leverages PL/SQL to calculate the total number of "Present" and "Absent" days for each employee within a specified month and year. The system is implemented in Oracle Database, utilizing two tables: `Employees` to store employee information and `Attendance` to store daily attendance records. A PL/SQL procedure, `Calculate_Attendance_Statistics`, is used to generate and display attendance statistics.

## Tables Creation

### Create `Employees` Table

```sql
create table employees (
   employee_id number primary key,
   first_name  varchar2(50),
   last_name   varchar2(50)
);
create table attendance (
   attendance_id   number primary key,
   employee_id     number
      references employees ( employee_id ),
   attendance_date date,
   status          varchar2(10) check ( status in ( 'Present',
                                           'Absent' ) )
);
```
