create or replace procedure calculate_attendance_statistics (
   p_month number,
   p_year  number
) as
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