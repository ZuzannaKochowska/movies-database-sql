1. Podstawowe SELECT i filtrowanie
-- Wyświetl wszystkie filmy wydane po 2010 roku.
SELECT * FROM Movies_clean
WHERE release_date > '2010-12-31';

--Znajdź filmy, których tytuł zaczyna się na literę "A".
SELECT title FROM Movies_clean
WHERE title LIKE 'A%';

--Wyświetl filmy z oceną (vote_average) powyżej 8.
SELECT * FROM Movies_clean
WHERE VOTE_AVERAGE > 8;

2. Sortowanie i LIMIT
--Posortuj filmy według daty premiery malejąco i pokaż top 10 najnowszych.
SELECT * 
FROM Movies_clean
ORDER BY release_date DESC
LIMIT 10;

--Top 5 filmów według oceny × liczba głosów
SELECT title, (vote_average*vote_count) AS score
FROM Movies_clean
WHERE vote_count >= 1000
ORDER BY score DESC
LIMIT 100;

--Top 5 filmów według oceny ważonej według wzrotu IMDB
SELECT 
    title,
    vote_average,
    vote_count,
    ROUND(
        ((vote_count / (vote_count + 1000)) * vote_average) + 
        ((1000 / (vote_count + 1000)) * 6.5),
        2
    ) AS weighted_rating
FROM movies_clean
WHERE vote_count >= 100
ORDER BY weighted_rating DESC
LIMIT 20;

3. Agregacje i grupowanie
--Oblicz średnią ocenę filmów z każdego roku.
SELECT 
 YEAR(release_date) AS rok,
 ROUND(AVG(vote_average), 2) AS srednia_ocena,
 COUNT(*) AS liczba_filmow
FROM movies_clean
WHERE release_date IS NOT NULL
GROUP BY rok
ORDER BY rok;

--Policz liczbę filmów wydanych w każdym języku (original_language).
SELECT original_language, COUNT(original_language) 
FROM movies_clean
GROUP BY original_language;

--Znajdź liczbę premier każdego roku.
SELECT YEAR(release_date) AS rok, COUNT(release_date)
FROM movies_clean
WHERE release_date IS NOT NULL
GROUP BY rok
ORDER BY rok;

--Znajdź rok z największą liczbą premier.
SELECT YEAR(release_date) AS rok, count(release_date) AS liczba_filmow
FROM movies_clean
WHERE release_date IS NOT NULL
group by rok
order by liczba_filmow DESC
limit 1;


4. Podzapytania
--Filmy z wyższą oceną niż średnia ocena wszystkich filmów
SELECT title, vote_average FROM movies_clean
WHERE vote_average > (
		SELECT AVG(vote_average) FROM movies_clean);

--Filmy z wyższą popularnością niż średnia popularność wszystkich filmów (liczone poprzez ilosć oddanych głosów na filmy)
SELECT title, vote_count FROM Movies_clean
WHERE vote_count > (
		SELECT AVG(vote_count) FROM movies_clean
					);
					
--Wyświetl filmy, które mają najwyższą ocenę w każdym języku.
SELECT original_language, title, vote_average
 FROM movies_clean
 WHERE vote_average = (
		SELECT MAX(vote_average) FROM movies_clean WHERE vote_count > 10000);

5. Modyfikacje danych
--Zaktualizuj ocenę (vote_average) filmu o konkretnym id.
UPDATE movies_clean 
SET vote_average = 6.5
WHERE id = 36593;

--Usuń filmy wydane przed rokiem 1998.
DELETE FROM movies_clean
WHERE release_date < '1998-01-01';

6. Tworzenie widoków i indeksów
Stwórz widok pokazujący filmy z oceną powyżej 8 i datą premiery po 2015.

Dodaj indeks na kolumnę original_language dla szybszego filtrowania.

7. Transakcje
Wykonaj serię zmian (np. aktualizacja kilku filmów), a potem zrób rollback, by ćwiczyć transakcje.

8. Eksport i import
Wyeksportuj wybrane dane do pliku CSV.

Zaimportuj zmodyfikowany plik z powrotem do bazy.