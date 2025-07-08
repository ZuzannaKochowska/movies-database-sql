CREATE TABLE `collections` (
  `movie_id` bigint NOT NULL,
  `collection_id` bigint DEFAULT NULL,
  `collection_name` text,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci