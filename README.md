# Microsoft SQL Server

Zainstaluj SQL server 2017 developer - sam command line

https://blog.jetbrains.com/datagrip/2016/06/21/connecting-datagrip-to-ms-sql-server/

Musi zostać skonfigurowane w sqlserver configuration w sqlserver services wszystko running i automatic
sqlserver network connection/protocols for mssqlserver -> tcp/ip enabled

#### Intellij Ultimate
Otwierasz repo z kodem lub tworzysz folder i pliki sql w nim lub pusty projekt pozniej wybrac rodzaj sql dla danego pliku pozniej prawa strona datebase później (+) wybierz sqlserver. Host localhost, port 1433, instance: MSSQLSERVER, na dole test connection, jeśli trzeba download driver
Dla pliku z tabelami oraz insert into -> ctrl+shift+f10, później ctrl+enter i wybierz console, później w pliku ze skryptem ctrl+enter i console

#### Visual Studio (2019) 
pakiet Magazynowanie i przetwarzanie danych - SQL server
Tworzysz nowy projekt SQL database czy jakoś tak
open->file wybierz wszystkie pliki łącznie z załączonymi skryptami
odpal po kolei i wybierz connection local -> DESKTOP-... I Connect

#### Ustawnianie logowania sa do MSSQL
Najłatwiej jest to zrobić w SSMS

https://www.isunshare.com/sql-server/how-to-change-sql-server-authentication-mode.html#method1
