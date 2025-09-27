CREATE TABLE `crew_clean` (
  `movie_id` int NOT NULL,
  `person_id` int NOT NULL,
  `name` text,
  `department` text,
  `job` text,
  `gender` int DEFAULT NULL,
  `profile_path` text,
  KEY `fk_crew_clean` (`movie_id`),
  CONSTRAINT `fk_crew_clean` FOREIGN KEY (`movie_id`) REFERENCES `movies_clean` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci