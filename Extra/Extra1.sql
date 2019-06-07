use HR

--PODPUNKT 1 --
select A.last_name,B.job_title, A.salary from employees A, jobs B 
where B.job_title not like 's%' and  B.job_title not like '%d%' 
and A.job_id=B.job_id and (A.salary<2600 or A.salary>11000) order by A.salary

--PODPUNKT 2 --
select count(*) as przedzial_100_107 from employees A
where A.manager_id>=100 and A.manager_id<=107 order by przedzial_100_107

select count(*) as bezManagera from employees A
where A.manager_id is null order by bezManagera

--PODPUNKT 3 --
select B.job_title, count(*) as liczbaPrac from employees A,jobs B
where A.job_id=B.job_id and B.job_title not like'%Clerk%' 
and datename(yyyy,A.hire_date)>=1997 and datename(yyyy,A.hire_date)<=1999
group by B.job_title order by liczbaPrac desc

--PODPUNKT 4 --
select E.city from regions C, countries D, locations E 
where C.region_id=D.region_id and D.country_id=E.country_id 
and C.region_name='Asia' and E.state_province is null

--PODPUNKT 5 --
select top 5 F.department_name, sum(A.salary) as departSalary 
from employees A, departments F 
where A.department_id=F.department_id 
group by F.department_name 
order by departSalary desc

--PODPUNKT 6 --
select D.country_name,E.city, count(E.city) as departNum
from countries D, locations E, departments F 
where D.country_id=E.country_id and E.location_id=F.location_id
group by D.country_name,E.city
order by D.country_name

--PODPUNKT 7 --
select D.country_name from countries D, regions C
where C.region_id=D.region_id and C.region_name='Europe' 
and D.country_name not in (
select countries.country_name from departments
join locations on departments.location_id=locations.location_id
join countries on locations.country_id=countries.country_id)

--PODPUNKT 8 --
select F.department_name from employees A, departments F 
where A.department_id=F.department_id 
and A.salary<(select avg(salary) as average from employees)
group by F.department_name

--------------------------------------------------------------------------
/*
1. Wyswietl nazwisko,stanowisko oraz wysokosc pensji pracownika, ktorzy nie pracuja
 na stanowisku zaczynajacym sie na litere s ani na zadnym ze stanowisk posiadajacych 
 w swojej nazwie litere d oraz ktorych zarobki nie naleza do przedzialu od 2600 do 11000.
 Wyswietlane dane uporzadkuj rosnaco wedlug kolejnosci wysokosci pensji
2. Ilu pracownikow podlega managerom posiadajacych identyfikatory z przedzialu:[100,107]
 a ilu nie przypisano manegara. Wyniki posortuj malejaco w zaleznosci od liczby pracownikow
3.Ilu pracownikow zatrudniono w latach 1997-1999 na poszczegolnych stanowiskach nie 
 zawierajacych w nazwie slowa 'Clerk'. Dane posortuj malejaco wedlug liczby zatrudnionych pracownikow
4. Wypisz miasta z Azji, dla ktorych nie okreslono 'state_province'
5.Podaj nazwy oddzialow oraz kwoty jakie kazdy z oddzialow wydaje na pensje swoich 
 pracownikow (wypisac 5 oddzialow, ktore wydaja najwiecej)
6.Wyswietl nazwy krajow, miasta oraz liczbe departamentow w danym kraju i miescie. Zapytanie
 powinno uwzglednic tylko te panstwa i miasta, ktore posiadaja depertament
7.Podaj nazwy panstw europejskich, w ktorych nie ma siedziby(locations) zaden oddzial
8.Wyswietl tylko te oddzialy (department), ktore zatrudniaja pracownikow, ktorych zarobki nie
 przekraczaja 50% srednich zarobkow (wszystkich pracownikow)
*/
--------------------------------------------------------------------------

