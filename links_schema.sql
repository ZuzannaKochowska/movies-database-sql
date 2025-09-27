CREATE TABLE `links` (
  `movie_id` int NOT NULL,
  `imdbId` bigint DEFAULT NULL,
  `tmdbId` double DEFAULT NULL,
  KEY `movieId_idx` (`movie_id`),
  CONSTRAINT `fk_links` FOREIGN KEY (`movie_id`) REFERENCES `movies_clean` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci