🎬 Projekt SQL – Analiza bazy danych filmowej `movies_clean`

Ten projekt zawiera zestaw zapytań SQL stworzonych na potrzeby analizy bazy danych filmowej o nazwie `movies_clean`. Celem projektu było rozwijanie umiejętności pracy z językiem SQL poprzez praktyczne zadania analityczne oraz przygotowanie materiału, który może zostać wykorzystany jako część mojego portfolio.

Główna tabela:
- **`movies_clean`** – zawiera podstawowe informacje o filmach, takie jak: `id`, `title`, `release_date`, `original_language`, `budget`, `revenue`, `runtime`, `vote_average`, `vote_count`, itp.

Dodatkowe tabele pomocnicze (rozpakowane z danych w formacie JSON):
- **`genres`** – zawiera przypisanie filmów do gatunków (np. komedia, dramat, akcja)
- **`collections`** – informacje o tym, czy film należy do konkretnej kolekcji (np. „Avengers Collection”)
- **`cast_clean`** – dane o obsadzie filmów (aktorzy i ich role)
- **`crew_clean`** – dane o ekipie filmowej (np. reżyserzy, operatorzy, scenarzyści)
- **`links`** – powiązania filmów z innymi bazami (np. IMDb, TMDb)

Wszystkie tabele zostały przygotowane poprzez przekształcenie złożonych struktur JSON do postaci relacyjnej, z wykorzystaniem języka Python (biblioteki Pandas oraz SQLAlchemy).

Technologie użyte w projekcie:

- **MySQL** – baza danych, na której wykonywano zapytania
- **SQL** – użyte konstrukcje: `SELECT`, `WHERE`, `GROUP BY`, `JOIN`, podzapytania, agregacje, sortowanie, `VIEW`, transakcje
- **Python** – przetwarzanie danych (`pandas`, `json`, `sqlalchemy`)
- **Git & GitHub** – wersjonowanie oraz prezentacja projektu

Projekt zawiera praktyczne zapytania SQL z różnych kategorii:

### Podstawowe zapytania:
- Filtrowanie danych (`WHERE`, `BETWEEN`, `LIKE`)
- Sortowanie i ograniczanie wyników

### Agregacje i grupowanie:
- `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- Grupowanie wyników (`GROUP BY`) i filtrowanie grup (`HAVING`)

### Złączenia tabel (`JOIN`):
- Analiza relacji między filmami, gatunkami, obsadą i ekipą
- Łączenie wielu tabel w celu stworzenia raportów

### Podzapytania (`subqueries`):
- Zagnieżdżone zapytania w `SELECT`, `FROM` i `WHERE`

###  Widoki (`VIEW`) i transakcje:
- Tworzenie widoków do analizy
- Praca z transakcjami (`BEGIN`, `COMMIT`, `ROLLBACK`)
