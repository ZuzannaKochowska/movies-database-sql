CREATE TABLE `movies_clean` (
  `id` int NOT NULL,
  `title` text,
  `original_language` text,
  `release_date` date DEFAULT NULL,
  `budget` int DEFAULT NULL,
  `revenue` bigint DEFAULT NULL,
  `runtime` int DEFAULT NULL,
  `vote_average` decimal(10,0) DEFAULT NULL,
  `vote_count` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci