# Microsoft SQL Server

Zainstaluj SQL server 2017 developer - sam command line

https://blog.jetbrains.com/datagrip/2016/06/21/connecting-datagrip-to-ms-sql-server/

Musi zostać skonfigurowane w sqlserver configuration w sqlserver services wszystko running i automatic
sqlserver network connection/protocols for mssqlserver -> tcp/ip enabled

#### Intellij Ultimate
Otwierasz repo z kodem lub tworzysz folder i pliki sql w nim lub pusty projekt pozniej wybrac 
rodzaj sql dla danego pliku pozniej prawa strona datebase później (+) wybierz sqlserver. 
Host localhost, port 1433, instance: MSSQLSERVER, na dole test connection, jeśli trzeba 
download driver
Dla pliku z tabelami oraz insert into -> ctrl+shift+f10, później ctrl+enter i wybierz 
console, później w pliku ze skryptem ctrl+enter i console

#### Visual Studio (2019) 
pakiet Magazynowanie i przetwarzanie danych - SQL server
Tworzysz nowy projekt SQL database czy jakoś tak
open->file wybierz wszystkie pliki łącznie z załączonymi skryptami
odpal po kolei i wybierz connection local -> DESKTOP-... I Connect

#### Ustawnianie logowania sa do MSSQL
Najłatwiej jest to zrobić w SSMS

https://www.isunshare.com/sql-server/how-to-change-sql-server-authentication-mode.html#method1


# Oracle Database

#### SQLPlus

logowanie do maszyny [oracle,oracle]

Uruchamianie: sqlplus i pozniej trzeba podać dane tzn [hr,oracle] lub [sys/as sysdba,oracle]
i wtedy jestesmy podlaczeni do bazy jest chcemy się rozłączyć to robimy disconn i gdy 
chcemy ponownie się połączyć to robimy conn i podajemy dane.

wychodzenie z otwartej sesji - disconn a później exit zeby wyjść z SQLPlus

wyświetlanie struktury tabeli: desc nazwa_tabeli
wyświetlanie wszystkich użytkowników: SELECT * FROM all_users;

#### IntelliJ IDEA
W VirtualBox trzeba ustawić 
* Siec->karta2->mostkowanie(bridged)
* Karta1 nie ruszać ma być na NAT ustawiona<br/>
Włączyć maszynę i w terminalu wyświetli się adres IP<br/>
```
inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
inet addr:10.7.218.73  Bcast:10.7.223.255  Mask:255.255.248.0
inet addr:127.0.0.1  Mask:255.0.0.0
```
To wybieramy `10.7.218.73` bo to jest karta numer2, która ustawilismy na mostokowanie

W IntelliJ otwieramy projekt -> Database->datasource->Oracle
* Host - adres IP `10.7.218.73`
* SID - orcl
* User - hr
* Password - oracle

Test connection - jak jest git to apply i pozniej w danym skrypcie select datasource
i ten nasz utworzony datasource i console <br/>
Uruchamienie poprzez ctrl+enter

W celu wyswietlania informacji na konsoli poprze dbms_output trzeba zrobic 
enable dbms_output - services->pasek po lewej stronie lub ctrl+F8

Jakims cudem IntelliJ nie chce uruchamiac procedur i funkcji poprzez `EXECUTE` i trzeba to
robic poprzez `CALL` stad sa te zakomentowane linie

#### Oracle SQLDeveloper
Tworzenie połączenie - prawy górny róg connections - podajemy nazwę, login i hasło 
oraz poniżej wybieramy role (default albo sysdba) oraz ustawiamy SID - orcl

#### Enterprise Manager
Trzeba włączyć proces: emctl start dbconsole
sprawdzanie statusu: emctl status dbconsole
I pozniej trzeba w przeglądarce odpalic tzn: https://localhost:1158/em/console/
