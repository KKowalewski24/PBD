-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------

-- SQL TUNING

-- PODPUNKT 1,2 --
SELECT e.first_name, e.last_name, e.department_id, e.job_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
  AND d.location_id IN (
                           SELECT location_id
                           FROM locations
                           WHERE city = 'Seattle'
                       );

-- FIRST_NAME           LAST_NAME                 DEPARTMENT_ID JOB_ID
------------------ ------------------------- ------------- ----------
-- Steven               King                                 90 AD_PRES
-- Neena                Kochhar                              90 AD_VP
-- Lex                  De Haan                              90 AD_VP
-- Nancy                Greenberg                           100 FI_MGR
-- Daniel               Faviet                              100 FI_ACCOUNT
-- John                 Chen                                100 FI_ACCOUNT
-- Ismael               Sciarra                             100 FI_ACCOUNT
-- Jose Manuel          Urman                               100 FI_ACCOUNT
-- Luis                 Popp                                100 FI_ACCOUNT
-- Den                  Raphaely                             30 PU_MAN
-- Alexander            Khoo                                 30 PU_CLERK
--
-- FIRST_NAME           LAST_NAME                 DEPARTMENT_ID JOB_ID
------------------ ------------------------- ------------- ----------
-- Shelli               Baida                                30 PU_CLERK
-- Sigal                Tobias                               30 PU_CLERK
-- Guy                  Himuro                               30 PU_CLERK
-- Karen                Colmenares                           30 PU_CLERK
-- Jennifer             Whalen                               10 AD_ASST
-- Shelley              Higgins                             110 AC_MGR
-- William              Gietz                               110 AC_ACCOUNT
--
-- 18 rows selected.

SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
HAVING avg(salary) = (
                         SELECT max(avg(salary)) FROM employees GROUP BY department_id
                     ); 2

-- DEPARTMENT_ID MIN(SALARY)
----------- -----------
--            90       17000

SELECT first_name, last_name, hire_date
FROM employees
WHERE to_char(hire_date, 'DAY')
          = (
                SELECT to_char(hire_date, 'DAY')
                FROM employees
                GROUP BY to_char(hire_date, 'DAY')
                HAVING count(employee_id) = (
                                                SELECT max(count(employee_id))
                                                FROM employees
                                                GROUP BY to_char(hire_date, 'DAY')
                                            )
            );

-- FIRST_NAME           LAST_NAME                 HIRE_DATE
------------------ ------------------------- ---------
-- Steven               King                      17-JUN-87
-- Lex                  De Haan                   13-JAN-93
-- Alexander            Hunold                    03-JAN-90
-- David                Austin                    25-JUN-97
-- Nancy                Greenberg                 17-AUG-94
-- Den                  Raphaely                  07-DEC-94
-- Shelli               Baida                     24-DEC-97
-- Julia                Nayer                     16-JUL-97
-- Steven               Markle                    08-MAR-00
-- Laura                Bissot                    20-AUG-97
-- Michael              Rogers                    26-AUG-98
--
-- FIRST_NAME           LAST_NAME                 HIRE_DATE
------------------ ------------------------- ---------
-- Curtis               Davies                    29-JAN-97
-- Peter                Hall                      20-AUG-97
-- Nanette              Cambrault                 09-DEC-98
-- David                Lee                       23-FEB-00
-- Elizabeth            Bates                     24-MAR-99
-- Alyssa               Hutton                    19-MAR-97
-- Julia                Dellinger                 24-JUN-98
-- Jennifer             Dilly                     13-AUG-97
-- Samuel               McCain                    01-JUL-98
-- Vance                Jones                     17-MAR-99
--
-- 21 rows selected.


-- PODPUNKT 3,4,5,6,7,8,9,10,11,12 --
-- Zostały wykonane poszczególne kroki przedstawione w intrukcji

-- PODPUNKT 13,14,15,16,17 --
-- Zostały wykonane kroki 13-17 z użyciem SQL Tuning Advisor

-- PODPUNKT 18,19,20,21,22,23,24,25,26,27,28,29,30 --
-- Zostały wykonane kroki 18-25 z użyciem SQL Access Advisor.


----------------------------------------------------------------------------------------------------------------

-- DATABASE PERFORMANCE

-- PODPUNKT 3,4,5,6,7 --
-- Zostały wykonane poszczególne przedstawione kroki w intrukcji

-- PODPUNKT 8,9,10,11,12,13,14,15,16 --
-- Została obejrzana lista alertów, wyświetlone jej szczegóły oraz została
-- wykonana operacja Recompile

-- PODPUNKT 17,18,19,20,21,22,23,24 --
-- Została utworzona migawka w ręczny sposób i zostały wyświetlone szczegóły
-- dotyczące statystyk bazy

-- PODPUNKT 25,26,27,28,29,30 --
-- Została wyświetlone dane statystyczne dotyczące działania instancji - po
-- kolei wszystkie podpunkty takie jakie były wskazane w instrukcji
