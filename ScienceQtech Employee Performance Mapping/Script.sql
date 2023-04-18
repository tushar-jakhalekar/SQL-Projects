Create Database Employee;
Use Employee;

Select EMP_ID, FIRST_NAME, LAST_NAME,GENDER,DEPT from emp_record_table;

Select EMP_ID, FIRST_NAME, LAST_NAME,GENDER,DEPT,EMP_RATING from emp_record_table
Where EMP_RATING<2;

Select EMP_ID, FIRST_NAME, LAST_NAME,GENDER,DEPT,EMP_RATING from emp_record_table
Where EMP_RATING>4;

Select EMP_ID, FIRST_NAME, LAST_NAME,GENDER,DEPT,EMP_RATING from emp_record_table
Where EMP_RATING Between 2 and 4;

Select concat(FIRST_NAME," ",LAST_NAME) as NAME from emp_record_table
where DEPT = 'FINANCE';

Select MANAGER_ID,COUNT(EMP_ID) as Count_of_Employees from emp_record_table
group by MANAGER_ID order by Count_of_Employees;

Select* from emp_record_table
Where DEPT = 'Healthcare'
Union
Select* from emp_record_table
Where Dept = 'Finance';

Select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT,EMP_RATING,max(EMP_RATING)
Over (partition by DEPT) as MAX_DEPT_RATING
from emp_record_table
order by DEPT;

Select ROLE,max(SALARY), min(SALARY)from emp_record_table
group by ROLE;

Select EMP_ID, FIRST_NAME, LAST_NAME,EXP,
RANK()OVER(Order by EXP)EXPERIENCE_RANK
from emp_record_table;

Create View SALARY_MORE_THAN_6K as
Select * from emp_record_table
where SALARY>6000;
Select* from SALARY_MORE_THAN_6K;

Select* from emp_record_table
Where (Select EXP>10);

Delimiter :
Create Procedure Exp_3_Years()
Begin 
Select * from emp_record_table
Where EXP > 3;
End:
Call Exp_3_Years;

Delimiter //
CREATE FUNCTION Emp__Role(EXP INT) 
Returns varchar(40)
DETERMINISTIC
Begin
Declare Emp_Role Varchar(40);
If EXP between 12 and 16 Then
Set Emp_Role = 'MANAGER';
Elseif EXP between 10 and 12 Then
Set Emp_Role = 'LEAD DATA SCIENTIST';
Elseif EXP between 5 and 10 Then
Set Emp_Role = 'SENIOR DATA SCIENTIST';
Elseif EXP between 2 and 5 Then
Set Emp_Role = 'ASSOCIATE DATA SCIEMTIST';
Elseif EXP <= 2 Then
Set Emp_Role = 'JUNIOR DATA SCIENTIST';
End if;
Return (Emp_Role);
End //
Select EXP,Emp__Role(EXP)
from data_science_team;

Create Index idx_first_name
On emp_record_table(FIRST_NAME(20));
Select * From emp_record_table
where FIRST_NAME = 'Eric';

Select *,(Salary + Salary*.05*EMP_RATING) as New_Salary from emp_record_table;

Select EMP_ID, FIRST_NAME, LAST_NAME, SALARY, COUNTRY, CONTINENT,
Avg(SALARY)Over(Partition by COUNTRY)AVG_SALARY_IN_COUNTRY,
Avg(SALARY)Over(Partition by CONTINENT)AVG_SALARY_IN_CONTINENT,
Count(*)Over(Partition by COUNTRY)COUNT_IN_COUNTRY,
Count(*)Over(Partition by CONTINENT)COUNT_IN_CONTINENT
from emp_record_table