select first_name,hire_date,salary,salary*3 from employees;

select last_name,salary,salary*12 - salary*12*0.15 from employees;

select first_name,hire_date,salary,salary*3 "Quarterly Salary" from employees;

select last_name,salary,salary*12 - salary*12*0.15 "Net Take Home Salary" from employees;

select first_name||' was  hired on '||hire_date||' in '||department_id||' on '||salary||' monthly salary ' from employees;

select unique(salary) from employees;

select customer_name from customer_detail where customer_address = 'Khar';

select customer_name, branch_city, deposit_amount from customer_detail c,account_detail a, bank_detail b
where (a.customer_id = c.customer_id) and (b.branch_id = a.branch_id) and a.deposit_amount>=5000;

select customer_name from customer_detail where customer_name like 'S%';

select branch_id,branch_location,branch_city from bank_detail where branch_city in ('Delhi','Pune','Indore');

select branch_location from bank_detail where branch_city = 'Delhi' or branch_city='Pune';



select transaction_id,transaction_type,amount from transaction_detail where (amount between 4000 and 8000) and transaction_type='D';

select customer_name from customer_detail
order by customer_name;

select c.customer_id,c.customer_name,c.customer_address, a.account_id,a.branch_id,a.account_type,a.deposit_amount,a.acc_open_date from customer_detail c, account_detail a 
where a.customer_id = c.customer_id
order by a.deposit_amount des c;

select * from account_detail 
order by deposit_amount,acc_open_date desc;

select customer_name from customer_detail where customer_name like 'A%u%' or customer_name like 'S%u%';

select initcap(customer_name), upper(customer_address) from customer_detail;

select * from transaction_detail where (transaction_date) >= sysdate - 22;

select first_name,hire_date,round(sysdate - trunc(hire_date,'dd')) as "No. of Days", round((sysdate- trunc(hire_date,'dd'))/7) as "Weeks", round(months_between(sysdate,hire_date)) as "Months", round((sysdate-trunc(hire_date,'dd'))/365) as "Years" from employees;

select employee_id, to_char(hire_date,'fmYear,month,dd') from employees;

select location_id, lpad(upper(street_address),20) from locations; 

select rpad(lpad(salary,10,'*'),15,'*') from employees;

select first_name,salary, nvl(to_char(commission_pct),'Employee earned no commission') from employees;

--ex :- If nvl(e1,e2)=> if e2 is char then convert e1 to char, if e2 is number then convert e1 to number, default e1 is number
select first_name,salary,salary,nvl(commission_pct,0) from employees;

select first_name,salary,commission_pct,nullif(commission_pct,0.1) from employees;

select first_name,department_id,
case department_id 
when 50 then 'HR Team'
when 80 then 'Training Team'
else 'Development Team' end 
from employees;

select first_name,department_id, decode(department_id,50,'HR Team',80,'Training Team','Development Team') from employees;

select c.customer_name,b.branch_location,a.account_type,a.deposit_amount from bank_detail b
join account_detail a on b.branch_id = a.branch_id
join customer_detail c on a.customer_id = c.customer_id
where a.deposit_amount>5000;

select c.customer_id,c.customer_name,a.account_id from customer_detail c
left join  account_detail a on c.customer_id = a.customer_id;

select e.employee_id,e.first_name,e.manager_id,e.salary as "Employee Salary",m.salary as "Manager Salary",m.salary- e.salary as "Salary Difference" from employees e
join employees m on  e.manager_id = m.employee_id;

select * from employees;

select e.employee_id,e.first_name||' '||e.last_name as "Name", e.salary, e.department_id,l.city,l.postal_code from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where e.salary>5000;

--select count(*) from account_detail where to_char(acc_open_date,'yyyy') = 2004;
select count(*) from account_detail where to_char(acc_open_date,'yyyy') = 2013;

select c.customer_name, count(a.account_id) from customer_detail c
join account_detail a on a.customer_id = c.customer_id
group by c.customer_name
having count(c.customer_name)>=2;
--select * from account_detail,customer_detail where account_detail.customer_id = customer_detail.customer_id

select c.customer_id,count(c.customer_id) from account_detail a, customer_detail c where a.customer_id = c.customer_id
group by c.customer_id;

select c.customer_name, c.customer_address, count(a.account_id) from account_detail a, customer_detail c
where a.customer_id = c.customer_id
group by c.customer_name,c.customer_address;

select c.customer_name,t.transaction_type, count(t.transaction_type) from customer_detail c, transaction_detail t, account_detail a
where c.customer_id = a.customer_id and a.account_id = t.account_id
group by c.customer_name, t.transaction_type;

select c.customer_name, count(c.customer_name) from customer_detail c,account_detail a,transaction_detail t where t.account_id = a.account_id and c.customer_id = a.customer_id
group by c.customer_name;
--select c.customer_name, count(c.customer_name) from customer_detail c,account_detail a,transaction_detail t where t.account_id = a.account_id and c.customer_id = a.customer_id
--group by c.customer_name
--having count(c.customer_name)>2;

select customer_id,count(customer_id),account_id,count(account_id) from account_detail
group by customer_id,account_id;

select c.customer_id,c.customer_name,count(c.customer_id) from customer_detail c,account_detail a where c.customer_id = a.customer_id
group by c.customer_id,customer_name
having count(c.customer_id)>1;

select * from account_detail where deposit_amount > (select min(deposit_amount) from account_detail);

--select * from transaction_detail, account_detail where transaction_detail.account_id = account_detail.account_id and transaction_detail.amount =(select max(amount) from transaction_detail group by account_id) group by transaction_detail.account_id;
select * from transaction_detail;
select account_id,max(amount) from transaction_detail
group by account_id;

select c.customer_id, c.customer_name,b.branch_location,b.branch_city from bank_detail b, customer_detail c,account_detail a 
where a.customer_id = c.customer_id and b.branch_id = a.branch_id and b.branch_location in (select branch_location from bank_detail,account_detail where bank_detail.branch_id = account_detail.branch_id and account_detail.customer_id = 'C001')
and a.deposit_amount> (select deposit_amount from account_detail where customer_id='C003');
--select * from account_Detail a,bank_detail b where a.branch_id = b.branch_id

select a.acc_open_date, c.customer_id, c.customer_name from account_detail a, customer_detail c
where c.customer_id = a.customer_id and to_char(a.acc_open_date,'fmMonth') = (select distinct(to_char(acc_open_date,'fmMonth')) from account_detail where customer_id ='C002');

select transaction_id,transaction_type from transaction_detail where transaction_type = (select transaction_type from transaction_detail where account_id ='A004');

--select branch_city,branch_location from bank_detail where branch_id = (select branch_id from account_detail where account_id ='A004');
select b.branch_location, b.branch_city from bank_detail b,account_detail a where b.branch_id = a.branch_id and a.customer_id = 'C001';

select a.account_id, a.deposit_amount from account_detail a, transaction_detail t where a.account_id = t.account_id and t.amount>(select amount from transaction_detail where account_id='A005');

select * from account_detail where deposit_amount > (select avg(deposit_amount) from account_detail);

select * from transaction_detail  where amount > all(select amount from transaction_detail where transaction_type='D');