USE hr
GO

-- PODPUNKT 1 --
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.hire_date, jo_hi.start_date,
       jo_hi.end_date
FROM employees emp, job_history jo_hi
WHERE emp.employee_id = jo_hi.employee_id

-- PODPUNKT 1.1 --
SELECT emp.employee_id, emp.first_name, emp.last_name, jh.end_date
FROM employees emp
         LEFT JOIN job_history jh ON emp.employee_id = jh.employee_id
WHERE jh.employee_id IS NULL

-- PODPUNKT 2 --
SELECT emp.last_name, emp.job_id, jb.job_title
FROM employees emp, jobs jb
WHERE emp.job_id = jb.job_id
  AND emp.hire_date = (SELECT min(hire_date) FROM employees)

-- PODPUNKT 3 --


-- PODPUNKT 4 --


-- PODPUNKT 5 --


--------------------------------------------------------------------------
/*
 TRESCI BRAK - PONIZEJ TYLKO DOMYSLY
 1. Wyswietl pracownikow ktorzy juz nie pracuja
 1.1. Wyswietl pracownikow aktualnie zatrudnionych - wszystkich pracownikow
        bez tych w tabeli job_history
 2. Wyswielt najwczesniej zatrudnionego pracownika

*/
--------------------------------------------------------------------------
