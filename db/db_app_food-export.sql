/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`food_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `food_type` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `food_type`;
CREATE TABLE `food_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `like_res`;
CREATE TABLE `like_res` (
  `user_id` int NOT NULL,
  `res_id` int NOT NULL,
  `date_like` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`res_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `like_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `like_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `order_sub_food`;
CREATE TABLE `order_sub_food` (
  `order_id` int NOT NULL,
  `sub_id` int NOT NULL,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`,`sub_id`),
  KEY `sub_id` (`sub_id`),
  CONSTRAINT `order_sub_food_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_sub_food_ibfk_2` FOREIGN KEY (`sub_id`) REFERENCES `sub_food` (`sub_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `amount` int NOT NULL,
  `code` varchar(255) NOT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `code` (`code`),
  KEY `user_id` (`user_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `rate_res`;
CREATE TABLE `rate_res` (
  `user_id` int NOT NULL,
  `res_id` int NOT NULL,
  `amount` int DEFAULT NULL,
  `date_rate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`res_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `rate_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `rate_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`) ON DELETE CASCADE,
  CONSTRAINT `rate_res_chk_1` CHECK ((`amount` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `restaurant`;
CREATE TABLE `restaurant` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `sub_food`;
CREATE TABLE `sub_food` (
  `sub_id` int NOT NULL AUTO_INCREMENT,
  `sub_name` varchar(255) NOT NULL,
  `sub_price` decimal(10,2) NOT NULL,
  `food_id` int DEFAULT NULL,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sub_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `sub_food_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `deletedBy` int NOT NULL DEFAULT '0',
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 'Ba chỉ bò nướng', 'bacon_grill.jpg', '150000.00', 'Ba chỉ bò Mỹ nướng tảng', 1, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 'Lẩu Thái', 'hotpot_thai.jpg', '200000.00', 'Lẩu Thái cay chua đặc biệt', 2, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 'Gà rán KFC', 'kfc_fried.jpg', '75000.00', 'Gà rán giòn tan KFC', 3, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 'Pizza Hải Sản', 'pizza_seafood.jpg', '250000.00', 'Pizza hải sản phô mai kéo sợi', 4, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 'Bún Chả Hà Nội', 'buncha.jpg', '50000.00', 'Bún chả thơm ngon đúng vị Hà Nội', 5, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 'Mì cay cấp độ 7', 'micay.jpg', '70000.00', 'Mì cay Hàn Quốc với 7 cấp độ', 6, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 'Cà phê sữa đá', 'cafe_suada.jpg', '35000.00', 'Cà phê sữa đá thơm ngon', 7, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 'Nước ép cam', 'juice_orange.jpg', '40000.00', 'Nước ép cam nguyên chất', 8, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 'Bánh bông lan trứng muối', 'banh_bong_lan.jpg', '60000.00', 'Bánh bông lan trứng muối đặc biệt', 9, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 'Chè thái sầu riêng', 'chethai.jpg', '50000.00', 'Chè thái sầu riêng ngọt béo thơm ngon', 10, 0, 0, NULL, '2025-04-08 20:49:12', '2025-04-08 20:49:12');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 'Món nướng', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 'Lẩu', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 'Gà rán', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 'Pizza', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 'Món Việt', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 'Mì cay', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 'Cà phê', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 'Nước ép', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 'Bánh ngọt', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `food_type` (`type_id`, `type_name`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 'Chè', 0, 0, NULL, '2025-04-08 20:49:06', '2025-04-08 20:49:06');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 1, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 2, '2025-04-09 05:20:27', 0, 0, NULL, '2025-04-09 05:20:27', '2025-04-09 05:20:27');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 1, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 2, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 3, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 4, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 5, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 6, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 7, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 5, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 8, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 9, '2025-04-08 20:48:55', 0, 0, NULL, '2025-04-08 20:48:55', '2025-04-08 20:48:55');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 1, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 2, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 3, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 3, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 4, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 5, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 6, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 7, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 8, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 10, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 2, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 7, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 8, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 9, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 1, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 2, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 3, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 4, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 5, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 6, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 2, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 10, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 5, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 9, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 10, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 7, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 8, 0, 0, NULL, '2025-04-09 06:40:24', '2025-04-09 06:40:24');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(11, 1, 0, 0, NULL, '2025-04-09 07:28:59', '2025-04-09 07:28:59');
INSERT INTO `order_sub_food` (`order_id`, `sub_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(11, 2, 0, 0, NULL, '2025-04-09 07:28:59', '2025-04-09 07:28:59');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 2, 'ORD001', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 2, 2, 1, 'ORD002', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 3, 3, 3, 'ORD003', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 4, 4, 1, 'ORD004', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 5, 5, 2, 'ORD005', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 6, 6, 1, 'ORD006', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 7, 7, 3, 'ORD007', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 8, 8, 2, 'ORD008', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 9, 9, 1, 'ORD009', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 10, 10, 2, 'ORD010', '2025-04-09 06:40:19', 0, 0, NULL, '2025-04-09 06:40:19', '2025-04-09 06:40:19');
INSERT INTO `orders` (`order_id`, `user_id`, `food_id`, `amount`, `code`, `order_date`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(11, 1, 2, 1, 'ORD034', '2025-04-09 07:28:59', 0, 0, NULL, '2025-04-09 07:28:59', '2025-04-09 07:28:59');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 1, 5, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 2, 4, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 3, 3, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 4, 5, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 5, 4, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 6, 3, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 7, 5, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 8, 4, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 9, 5, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 10, 4, '2025-04-08 20:49:01', 0, 0, NULL, '2025-04-08 20:49:01', '2025-04-08 20:49:01');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 'Gogi House', 'gogi.jpg', 'Chuyên đồ nướng Hàn Quốc', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 'Lẩu Phan', 'lauphan.jpg', 'Lẩu buffet ngon bổ rẻ', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 'KFC', 'kfc.jpg', 'Gà rán nổi tiếng thế giới', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 'Pizza Hut', 'pizzahut.jpg', 'Pizza thơm ngon chuẩn vị Ý', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 'Lotteria', 'lotteria.jpg', 'Chuỗi nhà hàng thức ăn nhanh', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 'Bún Chả Hà Nội', 'buncha.jpg', 'Bún chả ngon đúng vị', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 'Mì Cay Sasin', 'micay.jpg', 'Mì cay Hàn Quốc 7 cấp độ', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 'Highlands Coffee', 'highlands.jpg', 'Chuỗi quán cà phê Việt Nam', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 'The Coffee House', 'coffeehouse.jpg', 'Quán cà phê phong cách hiện đại', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `description`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 'Chè Ngon 3 Miền', 'che3mien.jpg', 'Các món chè đặc sản 3 miền', 0, 0, NULL, '2025-04-08 20:48:50', '2025-04-08 20:48:50');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 'Phô mai', '20000.00', 1, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 'Bánh mì bơ tỏi', '15000.00', 2, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 'Tương ớt đặc biệt', '5000.00', 3, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 'Xúc xích', '25000.00', 4, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 'Hành phi', '5000.00', 5, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 'Chả cá', '20000.00', 6, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 'Kem tươi', '10000.00', 7, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 'Chanh tươi', '5000.00', 8, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 'Hạnh nhân', '15000.00', 9, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 'Thạch dừa', '10000.00', 10, 0, 0, NULL, '2025-04-08 20:49:18', '2025-04-08 20:49:18');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(1, 'Nguyễn Văn A', 'nguyenvana@example.com', 'password123', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(2, 'Trần Thị B', 'tranthib@example.com', 'password456', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(3, 'Lê Văn C', 'levanc@example.com', 'password789', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(4, 'Phạm Hồng D', 'phamhongd@example.com', 'pass1234', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(5, 'Bùi Thị E', 'buithie@example.com', 'pass5678', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(6, 'Hoàng Minh F', 'hoangminhf@example.com', 'pass91011', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(7, 'Vũ Văn G', 'vuvang@example.com', 'pass1213', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(8, 'Đỗ Thị H', 'dothih@example.com', 'pass1415', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(9, 'Trịnh Xuân I', 'trinhxuani@example.com', 'pass1617', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(10, 'Cao Văn K', 'caovank@example.com', 'pass1819', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(11, 'Nguyễn Hữu L', 'nguyenhuul@example.com', 'pass1122', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(12, 'Trần Văn M', 'tranvanm@example.com', 'pass2233', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(13, 'Lê Thị N', 'lethin@example.com', 'pass3344', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(14, 'Phạm Quốc O', 'phamquoco@example.com', 'pass4455', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `deletedBy`, `isDeleted`, `deletedAt`, `createdAt`, `updatedAt`) VALUES
(15, 'Bùi Minh P', 'buiminhp@example.com', 'pass5566', 0, 0, NULL, '2025-04-08 20:48:40', '2025-04-08 20:48:40');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;