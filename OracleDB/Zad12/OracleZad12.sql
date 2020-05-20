-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
-- Zadanie polega na zdefiniowaniu pakietu o nazwie VIDEO_PKG, który zawiera procedury i funkcje
-- związane z magazynem filmów wideo. Aplikacja umożliwia klientom rejestrację członkowską.
-- Zarejestrowany członek może wypożyczać filmy, zwracać filmy wypożyczone oraz rezerwować filmy.
-- Dodatkowo należy zdefiniować wyzwalacz, który pozwoli na wprowadzanie zmian tylko w czasie
-- godzin pracy.
-- Baza danych składa się z pięciu tabel: TITLE, TITLE_COPY, RENTAL, RESERVATION i MEMBER:
--
-- Uruchom skrypt buildvid1.sql zawierający definicje tabel i sekwencji.
-- Uruchom skrypt buildvid2.sql zawierający dane.
-- Zdefiniuj pakiet VIDEO_PKG z następującymi procedurami i funkcjami:
-- NEW_MEMBER: procedura publiczna, która pozwala na dodanie nowego członka do tabeli MEMBER.
-- Dla wstawiania numeru członka ID, użyj sekwencji MEMBER_ID_SEQ.  Data rejestracji
-- członkowskiej (join date), to SYSDATE. Pozostałe wartości nowego wiersza mają być
-- przekazywane jako parametry.
-- NEW_RENTAL: przeciążana funkcja publiczna do rejestracji nowych wypożyczeń. Należy przekazać do
-- funkcji numer tytułu (ID) kasety wideo, którą klient chce wypożyczyć oraz albo nazwisko klienta,
-- albo jego numer. Funkcja powinna zwracać sugerowaną datę zwrotu kasety (due date). Data zwrotu
-- to 3 dni od daty wypożyczenia. Jeśli status filmu, który klient chce wypożyczyć jest ustawiony
-- na AVAILABLE w tabeli TITLE_COPY dla jednej kopii filmu, należy ustawić go na RENTED. Jeśli nie
-- ma żadnej dostępnej kopii, funkcja ma zwrócić NULL. Procedura wstawia nowy rekord do tabeli
-- RENTAL z dzisiejszą datą, jako data rezerwacji, numerem ID kopii, numerem ID członka, numerem
-- ID tytułu i sugerowaną datą zwrotu. Należy uwzględnić możliwość pojawienia się klientów z takim
-- samym nazwiskiem (funkcja może w takim przypadku zwrócić NULL i wyświetlić nazwiska, imiona i
-- odpowiadające im identyfikatory).
-- RETURN_MOVIE: procedura publiczna, która aktualizuje status kasety wideo
-- (available, rented lub damaged) i ustawia datę zwrotu. Do procedury należy przekazać ID
-- tytułu, ID kopii i status. Sprawdź, czy są rezerwacje na ten tytuł i wyświetl komunikat,
-- jeśli są. Zaktualizuj tabelę RENTAL i ustaw datę zwrotu na dzisiejszą. Zaktualizuj status
-- w tabeli TITLE_COPY
-- RESERVE_MOVIE: procedura prywatna, która wykonuje się tylko wówczas, gdy wszystkie kopie
-- danego filmu żądane w procedurze NEW_RENTAL mają status RENTED. Do procedury należy przekazać
-- numer ID członka i numer ID tytułu. Wstaw nowy rekord do tabeli RESERVATION. Wypisz komunikat
-- informujący o fakcie zarezerwowania i spodziewanej dacie zwrotu kasety.
-- 3.EXCEPTION_HANDLER: prywatna procedura, która wywoływana jest z sekcji wyjątków jednostek
-- publicznych. Do procedury należy przekazać numer SQLCODE i nazwę podprogramu (jako ciąg znaków).
-- Należy zastosować składnię RAISE_APPLICATION_ERROR wywołać znany wyjątek (naruszenie klucza
-- podstawowego (-1) , klucza obcego (-2292)). Dla pozostałych błędów można pozostawić komunikaty
-- domyślne.
-- Sprawdź poprawność swoich definicji za pomocą następujących skryptów:
-- •Dodaj dwóch członków za pomocą skryptu sol_apb_04_b_new_rentals.sql.
-- •Zwróć film za pomocą skryptu sol_apb_04_c_return_movie.sql script.
-- Godziny pracy wypożyczalni to 8:00 a.m. do 10:00 p.m., od niedzieli do piątku, w soboty 8:00 a.m. to 12:00 a.m.
--
-- 5. Zdefiniuj procedurę TIME_CHECK , która sprawdza bieżącą godzinę pod kątem godzin pracy.
-- Jeśli nie są to godziny pracy, użyj RAISE_APPLICATION_ERROR generując odpowiedni komunikat.
--
-- 6. Zdefiniuj wyzwalacz na każdej z pięciu tabel uruchamiany przed wstawieniem, aktualizacją
-- lub usuwaniem danych. Z wyzwalaczy wywołuj procedurę TIME_CHECK.
----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1 --


-- PODPUNKT 2 --


-- PODPUNKT 3 --


-- PODPUNKT 4 --


-- PODPUNKT 5 --
