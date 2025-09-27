CREATE TABLE `collections` (
  `movie_id` int NOT NULL,
  `collection_id` int NOT NULL,
  `collection_name` text,
  KEY `fk_collections` (`movie_id`),
  CONSTRAINT `fk_collections` FOREIGN KEY (`movie_id`) REFERENCES `movies_clean` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci