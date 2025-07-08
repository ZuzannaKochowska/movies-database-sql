CREATE TABLE `genres` (
  `movie_id` text,
  `genre_id` bigint DEFAULT NULL,
  `genre_name` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci