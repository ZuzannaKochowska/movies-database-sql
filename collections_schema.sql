CREATE TABLE `collections` (
  `movie_id` INT NOT NULL,
  `collection_id` INT DEFAULT NULL,
  `collection_name` text,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci