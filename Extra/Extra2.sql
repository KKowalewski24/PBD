use HR

--PODPUNKT 1 --
select  A.last_name, A.first_name,A.salary, B.job_title from employees A, jobs B
where A.job_id=B.job_id and A.salary=B.min_salary

--PODPUNKT 2 --
select D.country_name from countries D, regions C
where C.region_id=D.region_id and C.region_name='Europe' 
and D.country_name not in (
select countries.country_name from departments
join locations on departments.location_id=locations.location_id
join countries on locations.country_id=countries.country_id)

--PODPUNKT 3 --
select C.country_name,C.country_id from countries C
where C.country_id=substring(C.country_name,1,2)

--PODPUNKT 4 --
select B.job_title, count(*) as employNum from employees A, jobs B
where A.job_id=B.job_id and B.job_title not like '%Sales%' 
and B.job_title not like '%Clerk%'
group by B.job_title
order by employNum desc

--PODPUNKT 5 --
select A.first_name+' '+ A.last_name as pracownicy from employees A
where A.last_name like '%a%' and A.last_name like '%e%'

--PODPUNKT 6 --
select B.job_title,A.hire_date from employees A, jobs B
where A.job_id=B.job_id 
and hire_date=(select min(hire_date) from employees)

--------------------------------------------------------------------------
/*
1.Wyswietl nazwiska(last_name), imiona(first_name) i wynagrodzenie tych 
 pracownikow, ktorzy zarabiaja najnizsza stawke na danym stanowisku(dane 
 stanowisk w tabeli jobs).
2.Podaj nazwy panstw europejskich, w ktorych nie ma siedziby(locations) zaden oddzial.
3.Podaj nazwy tych krajow, ktorych identyfikator stanowia dwie piersze litery z nazwy kraju.
4.Ilu pracownikow zatrudnionych na stanowiskach nie zawierajacych slow 'Sales' i 'Clerk'.
 Wynik posortowac malejaco wedlug liczby pracownikow.
5.Podaj imiona i nazwiska pracownikow, ktorzy maja litery a i e w nazwisku . Wynik nazwij 
 pracownicy i przedstaw w postaci jednego ciagu Np. Jan Kowalski
6.Jakie stanowisko zajmowal pierwszy zatrudniony pracownik(na podstawie tabeli employees)
*/
--------------------------------------------------------------------------
