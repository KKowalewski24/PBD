use HR

--PODPUNKT 1 --
select B.department_name, count(*) as employNum from employees A, departments B
where A.department_id=B.department_id
group by B.department_name
having count(*)>10
order by employNum

--PODPUNKT 2 --
select A.last_name,A.first_name,A.salary from employees A,employees B, jobs C
where B.employee_id=A.manager_id and B.job_id=C.job_id 
and C.max_salary*0.9<B.salary 
order by A.salary

--PODPUNKT 3 --
select A.last_name, A.salary, B.last_name,B.salary from employees A, employees B
where A.manager_id=B.employee_id and B.salary*0.25>A.salary

--PODPUNKT 4 --
select C.city, C.state_province from locations C
where substring(C.city,1,2)= substring(C.state_province,1,2)
order by C.city,C.state_province

--PODPUNKT 5 --
select B.job_title, avg(A.salary) as average from employees A, jobs B
where A.job_id=B.job_id
group by B.job_title
order by average desc

--PODPUNKT 6 --
select B.last_name, count(*) as employNum from employees A, employees B
where A.manager_id=B.employee_id 
group by B.last_name
having count(*)<5 or count(*)>10

--------------------------------------------------------------------------
/*
1.Podaj nazwy dzialow zatrudniajacych wiecej niz 10 pracownikow
2.Podaj nazwiska, imiona, wynagraodzenia tych pracownikow, ktorych szefowie zarabiaja
 wiecej niz 90% maksymalnej stawki na swoim stanowisku(dane stanowisk w tabeli jobs)
3.Podaj nazwiska i zarobki tych pracownikow, ktorych wynagrodzenie jest mniejsze 
 niz 25% wynagrodzenia szefa
4.Podaj miasta i prowincje(state_province), ktorych pierwsza litera nazwy miasta
i prowincji sa takie same. Posortuj wyniki rosnaco wedlug miasta i prowincji
5.Podaj nazwy stanowisk i srednie zarobki pracownikow na nich pracujacych w kolejnosci
 malejacych zarobkow
6.Podaj nazwiska oraz liczbe podw³adnych dla tych managerow ktorzy ich maja wiecej niz 
 dziesieciu lub mniej niz 5
*/
--------------------------------------------------------------------------

