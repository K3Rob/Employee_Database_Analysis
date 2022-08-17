--create retirement_titles table
Select e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date 
into retirement_titles
FROM employees as e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows, create unique_titles table
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

--retrieve retiring empl count by most recent title create retiring_titles table
select count (ut.title),
	ut.title
into retiring_titles
from unique_titles as ut
group by ut.title
order by count (ut.title) desc

--create mentorship eligibility table
select distinct on(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
into mentorship_eligibility
from employees as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
inner join titles as ti
on (e.emp_no = ti.emp_no)
where (de.to_date = '9999-01-01')
	and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no



