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
-- Insert sample employees
insert into employees (
   employee_id,
   first_name,
   last_name
) values ( 1,
           'John',
           'Doe' );
insert into employees (
   employee_id,
   first_name,
   last_name
) values ( 2,
           'Jane',
           'Smith' );

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