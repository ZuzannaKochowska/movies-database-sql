1. Podstawowe SELECT i filtrowanie // Basic SELECT and Filtering
-- Wyświetl wszystkie filmy wydane po 2010 roku. // Display all movies released after 2010.
SELECT * FROM Movies_clean
WHERE release_date > '2010-12-31';

--Znajdź filmy, których tytuł zaczyna się na literę "A". // Find movies with titles starting with the letter "A".
SELECT title FROM Movies_clean
WHERE title LIKE 'A%';

--Wyświetl filmy z oceną (vote_average) powyżej 8. // Display movies with a vote average greater than 8.
SELECT * FROM Movies_clean
WHERE VOTE_AVERAGE > 8;

2. Sortowanie i LIMIT // Sorting and LIMIT
--Posortuj filmy według daty premiery malejąco i pokaż top 10 najnowszych. // Sort movies by release date in descending order and show the top 10 most recent.
SELECT * 
FROM Movies_clean
ORDER BY release_date DESC
LIMIT 10;

--Top 5 filmów według oceny × liczba głosów (ocena popularności)// Display top 5 movies based on popularity (vote_average × vote_count).
SELECT title, (vote_average*vote_count) AS score
FROM Movies_clean
WHERE vote_count >= 1000
ORDER BY score DESC
LIMIT 100;

--Top 5 filmów według oceny ważonej według wzrotu IMDB // Show top 5 movies using the weighted rating formula (IMDB style).
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

--Lista 10 najwyżej ocenianych filmów z największą liczbą głosów // rzetelniejszy ranking jest według wzoru IMDB powyżej //List top 10 highest-rated movies with at least 10,000 votes.
SELECT * FROM movies_clean
WHERE vote_count > 10000
ORDER BY vote_average DESC
LIMIT 10;

3. Agregacje i grupowanie // Aggregation and Grouping
--Oblicz średnią ocenę filmów z każdego roku. // Calculate the average rating of movies per year.
SELECT 
 YEAR(release_date) AS rok,
 ROUND(AVG(vote_average), 2) AS srednia_ocena,
 COUNT(*) AS liczba_filmow
FROM movies_clean
WHERE release_date IS NOT NULL
GROUP BY rok
ORDER BY rok;

--Policz liczbę filmów wydanych w każdym języku (original_language).//Count the number of movies released in each original language.
SELECT original_language, COUNT(original_language) 
FROM movies_clean
GROUP BY original_language;

--Znajdź liczbę premier każdego roku. // Count the number of releases per year.
SELECT YEAR(release_date) AS rok, COUNT(release_date)
FROM movies_clean
WHERE release_date IS NOT NULL
GROUP BY rok
ORDER BY rok;

--Znajdź rok z największą liczbą premier. // Find the year with the most movie releases.
SELECT YEAR(release_date) AS rok, count(release_date) AS liczba_filmow
FROM movies_clean
WHERE release_date IS NOT NULL
group by rok
order by liczba_filmow DESC
limit 1;


4. Podzapytania // Subqueries
--Filmy z wyższą oceną niż średnia ocena wszystkich filmów // Find movies with a higher rating than the average of all movies.
SELECT title, vote_average FROM movies_clean
WHERE vote_average > (
		SELECT AVG(vote_average) FROM movies_clean);

--Filmy z wyższą popularnością niż średnia popularność wszystkich filmów (liczone poprzez ilosć oddanych głosów na filmy) // Find movies with more votes than the average vote count.
SELECT title, vote_count FROM Movies_clean
WHERE vote_count > (
		SELECT AVG(vote_count) FROM movies_clean
					);
					
--Wyświetl filmy, które mają najwyższą ocenę w każdym języku.//Display the highest-rated movie in each original language.
SELECT original_language, title, vote_average
 FROM movies_clean
 WHERE vote_average = (
		SELECT MAX(vote_average) FROM movies_clean WHERE vote_count > 10000);
		
--Najstarszy film w bazie (Użyj MIN(release_date), Pokaż tytuł i datę premiery) // Show the oldest movie in the database.
SELECT title, release_date FROM Movies_clean
WHERE release_date = (
					SELECT MIN(release_date) FROM Movies_clean
					);

--Liczba filmów wydanych każdego roku (posortowane)->(YEAR(release_date), COUNT(*) GROUP BY + ORDER BY) // Count movies released per year (with sorting).
SELECT YEAR(release_date) AS rok, COUNT(*) AS liczba_filmow FROM movies_clean
GROUP BY rok
ORDER BY rok ASC;

--Zidentyfikować najlepiej oceniane filmy w każdym języku z wykorzystaniem MAX() w podzapytaniu i JOIN // Identify the top-rated films in each language using a subquery + JOIN.
SELECT m.*
FROM movies_clean m
JOIN (
    SELECT original_language, MAX(vote_average) AS max_rating
    FROM movies_clean
    GROUP BY original_language
) AS max_per_lang
ON m.original_language = max_per_lang.original_language
   AND m.vote_average = max_per_lang.max_rating
ORDER BY m.original_language;

--Średnia ocena filmów z każdego roku z GROUP BY YEAR(release_date) + AVG(vote_average)
SELECT YEAR(release_date) AS rok, ROUND(AVG(vote_average), 2) AS srednia_ocena, COUNT(*) AS ilosc_filmow_per_rok 
FROM movies_clean
GROUP BY rok
ORDER BY rok ASC;

--Filmy, których tytuły zaczynają się na literę „T" // Show titles of movies starting with “T”.
SELECT title 
FROM movies_clean
WHERE title LIKE 'T%' ;


--Języki, w których nakręcono ponad 100 filmów Z GROUP BY original_language + HAVING COUNT(*) > 100 // Find languages with more than 100 movies produced.
SELECT original_language, count(*) AS ilosc_filmow FROM movies_clean
GROUP BY original_language 
HAVING count(*) > 100;

--Filmy bez podanego budżetu lub WHERE budget IS NULL // Find movies with no budget specified (NULL or 0).
SELECT * FROM movies_clean
WHERE budget IS NULL OR budget=0;

--Najdłuższy i najkrótszy tytuł filmu - CHAR_LENGTH(title) + MAX() i MIN() // Find the longest or shortest movie title using CHAR_LENGTH().
SELECT Title, CHAR_LENGTH(Title) AS dlugosc_tytulu
FROM movies_clean
WHERE CHAR_LENGTH(Title) = (
    SELECT MAX(CHAR_LENGTH(Title)) FROM movies_clean
);

lub 
SELECT  Title, Char_length(title) AS ilosc_znakow from movies_clean
ORDER BY ilosc_znakow DESC
LIMIT 1;

--Liczba filmów na każdy miesiąc - MONTH(release_date) + GROUP BY // Count how many movies were released in each month.
SELECT MONTH(release_date) AS miesiac, COUNT(*) FROM movies_clean
GROUP BY miesiac
ORDER BY miesiac;

--Średnia liczba głosów (vote_count) na film w każdym języku // Calculate the average rating per language.
SELECT original_language, ROUND(AVG(vote_average), 4) AS srednia_ocena, COUNT(*) as liczba_glosow 
FROM movies_clean
GROUP BY original_language
ORDER BY srednia_ocena DESC;


--Filmy, które mają głosów więcej niż 10 000 i ocenę powyżej 8 // Show movies with vote count > 10,000 and rating > 8.
SELECT * FROM movies_clean
WHERE vote_count > 10000 AND vote_average > 8;

-- Znajdź wszystkie filmy, które mają w tytule słowo "love" // Find all movies that contain the word "love" in the title.
SELECT title FROM movies_clean
WHERE title LIKE "%love%";


5. Modyfikacje danych // Data Modification
--Zaktualizuj ocenę (vote_average) filmu o konkretnym id. // Update the rating of a movie with a specific id.
UPDATE movies_clean 
SET vote_average = 6.5
WHERE id = 36593;

--Usuń filmy wydane przed rokiem 1998. // Delete all movies released before 1998.
DELETE FROM movies_clean
WHERE release_date < '1998-01-01';

6. JOINY
--Pokaż tytuły filmów oraz nazwy kolekcji, do których należą (jeśli film należy do kolekcji).
SELECT m.title, c.collection_name 
FROM movies_clean m
LEFT JOIN collections c 
ON m.id = c.movie_id;

--Pokaż liczbę filmów w każdej kolekcji.
SELECT c.collection_name,  COUNT(*) AS ilosc_filmow_w_kolekcji
FROM collections c
LEFT JOIN movies_clean m
ON c.movie_id = m.id
GROUP BY collection_name 
ORDER BY ilosc_filmow_w_kolekcji DESC;

--Pokaż 10 najnowszych filmów z gatunku „Action” 
SELECT m.title, m.release_date, g.genre_name 
FROM movies_clean m 
JOIN genres g
ON m.id = g.movie_id
WHERE g.genre_name = 'Action'
ORDER BY release_date DESC
LIMIT 10;

--Pokaż filmy, które mają większy budżet niż średni budżet wszystkich filmów
SELECT title, budget FROM movies_clean
WHERE budget > (
				SELECT AVG(budget) FROM movies_clean
                );


--Pokaż filmy z więcej niż jednym gatunkiem przypisanym
SELECT  m.title, COUNT(DISTINCT g.genre_name) AS liczba_gatunkow FROM movies_clean m
JOIN genres g
ON m.id = g.movie_id
GROUP BY m.title
HAVING liczba_gatunkow > 1
ORDER BY liczba_gatunkow DESC;

--Dla każdego gatunku pokaż średni budżet filmów

SELECT g.genre_name, AVG(budget)
FROM movies_clean m 
JOIN genres g 
ON m.id = g.movie_id
GROUP BY g.genre_name;

--Wyświetl tytuł filmu i imiona aktorów, którzy zagrali w danym filmie.
SELECT c.name, m.title FROM cast_clean c 
LEFT JOIN  movies_clean m 
ON m.id = c.movie_id;


--Pokaż tytuły filmów i reżysera.
SELECT m.title,  c.name AS 'Director' FROM movies_clean m 
LEFT JOIN  crew_clean c
ON m.id = c.movie_id
WHERE c.job = 'Director';

--Wyświetl tytuły filmów, które należą do jakiejś kolekcji wraz z nazwą tej kolekcji.
SELECT c.collection_name, m.title FROM movies_clean m
JOIN collections c 
ON m.id = c.movie_id;

--Pokaż aktorów, którzy wystąpili w więcej niż 3 filmach.
SELECT name, COUNT(movie_id) AS ilosc_filmow FROM cast_clean
GROUP BY name
HAVING ilosc_filmow >= 3
ORDER BY ilosc_filmow DESC;

--Pokaż tytuły filmów i liczbę osób z ekipy (crew) przypisanych do każdego filmu.
SELECT m.title, COUNT(c.movie_id) AS amount_of_crew FROM movies_clean m
JOIN crew_clean c 
ON m.id = c.movie_id
GROUP by m.title;

--Wyświetl 10 najczęstszych gatunków filmowych i ile filmów do nich należy.
SELECT genre_name, COUNT(genre_name) AS ilosc 
FROM genres
GROUP BY genre_name
ORDER BY ilosc DESC
LIMIT 10;

--Pokaż listę filmów z gatunku "Comedy", które mają więcej niż 7.5 średniej oceny
SELECT m.title, m.vote_average FROM 
movies_clean m
JOIN genres g 
ON m.id = g.movie_id 
WHERE g.genre_name = 'Comedy'
AND m.vote_average >= 7.5
ORDER BY m.vote_average DESC;

--Wyświetl aktorów, którzy wystąpili razem w więcej niż jednym filmie.
SELECT 
	c1.name AS actor1,
    c2.name AS actor2,
    COUNT(*) AS wspolne_filmy   
FROM cast_clean c1 
JOIN cast_clean c2
ON c1.movie_id = c2.movie_id
WHERE c1.name < c2.name
GROUP BY c1.name, c2.name
HAVING COUNT(*) > 1
ORDER BY wspolne_filmy DESC
LIMIT 10;

--Pokaż filmy, których budżet jest wyższy niż średni budżet filmów w tej samej kolekcji.
SELECT m.title, m.budget 
FROM movies_clean m 
WHERE m.budget > (
	SELECT AVG(m2.budget)
	FROM movies_clean m2
	JOIN collections c 
    ON m2.id = c.movie_id
);

--Wyświetl imię i zawód (job) każdej osoby z crew, która pracowała przy filmach w gatunku „Drama”.
SELECT c.name, c.job 
FROM crew_clean c 
JOIN genres g 
ON c.movie_id = g.movie_id
WHERE g.genre_name = 'Drama';

-- Tworzenie widoków i indeksów // Views and Indexing
Stwórz widok pokazujący filmy z oceną powyżej 8 i datą premiery po 2015. // Create a view showing movies with a rating above 8 and release date after 2015.
CREATE VIEW top_movies_2015 AS
SELECT title, release_date, vote_average
FROM movies_clean
WHERE vote_average > 8 AND release_date > '2015-01-01';

--Dodaj indeks na kolumnę original_language dla szybszego filtrowania. // Add an index to the original_language column to improve performance.
CREATE INDEX idx_original_language
ON movies_clean(original_language);


--Transakcje // Transactions
--Wykonaj serię zmian (np. aktualizacja kilku filmów), a potem zrób rollback, by ćwiczyć transakcje. // Execute multiple updates and test the rollback functionality.
START TRANSACTION;

UPDATE movies_clean
SET vote_average = vote_average + 1
WHERE vote_count > 10000;

UPDATE movies_clean
SET budget = budget * 2
WHERE release_date < '2000-01-01';

ROLLBACK;

--Eksport i import // Export and Import
--Wyeksportuj wybrane dane do pliku CSV.// Export selected data to a CSV file.


