CREATE TABLE `cast_clean` (
  `movie_id` int NOT NULL,
  `actor_id` int NOT NULL,
  `name` text,
  `character` text,
  `gender` int DEFAULT NULL,
  `order` int DEFAULT NULL,
  `profile_path` text,
  KEY `fk_cast_clean` (`movie_id`),
  CONSTRAINT `fk_cast_clean` FOREIGN KEY (`movie_id`) REFERENCES `movies_clean` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci