CREATE TABLE `movies_clean` (
  `id` INT DEFAULT NULL,
  `title` text,
  `original_language` text,
  `release_date` DATE,
  `budget` INT DEFAULT NULL,
  `revenue` INT DEFAULT NULL,
  `runtime` double DEFAULT NULL,
  `vote_average` double DEFAULT NULL,
  `vote_count` INT DEFAULT NULL, 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci