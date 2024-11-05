   SET SERVEROUTPUT ON;


begin
   calculate_attendance_statistics(
      p_month => 10,
      p_year  => 2024
   );
end;
/