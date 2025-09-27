CREATE TABLE `genres` (
  `movie_id` int NOT NULL,
  `genre_id` int NOT NULL,
  `genre_name` text,
  KEY `fk_genres` (`movie_id`),
  CONSTRAINT `fk_genres` FOREIGN KEY (`movie_id`) REFERENCES `movies_clean` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci