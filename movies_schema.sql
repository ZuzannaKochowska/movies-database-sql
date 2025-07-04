CREATE TABLE `movies_clean` (
  `id` bigint DEFAULT NULL,
  `title` text,
  `original_language` text,
  `release_date` text,
  `budget` bigint DEFAULT NULL,
  `revenue` bigint DEFAULT NULL,
  `runtime` double DEFAULT NULL,
  `vote_average` double DEFAULT NULL,
  `vote_count` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci