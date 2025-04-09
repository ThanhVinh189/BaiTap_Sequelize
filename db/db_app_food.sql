-- Tạo database
CREATE DATABASE IF NOT EXISTS `db_app_food`;
USE `db_app_food`;

-- Bảng users
CREATE TABLE `users` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `full_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    
    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `users` (`full_name`, `email`, `password`) VALUES
('Nguyễn Văn A', 'nguyenvana@example.com', 'password123'),
('Trần Thị B', 'tranthib@example.com', 'password456'),
('Lê Văn C', 'levanc@example.com', 'password789'),
('Phạm Hồng D', 'phamhongd@example.com', 'pass1234'),
('Bùi Thị E', 'buithie@example.com', 'pass5678'),
('Hoàng Minh F', 'hoangminhf@example.com', 'pass91011'),
('Vũ Văn G', 'vuvang@example.com', 'pass1213'),
('Đỗ Thị H', 'dothih@example.com', 'pass1415'),
('Trịnh Xuân I', 'trinhxuani@example.com', 'pass1617'),
('Cao Văn K', 'caovank@example.com', 'pass1819'),
('Nguyễn Hữu L', 'nguyenhuul@example.com', 'pass1122'),
('Trần Văn M', 'tranvanm@example.com', 'pass2233'),
('Lê Thị N', 'lethin@example.com', 'pass3344'),
('Phạm Quốc O', 'phamquoco@example.com', 'pass4455'),
('Bùi Minh P', 'buiminhp@example.com', 'pass5566');


-- Bảng restaurant
CREATE TABLE `restaurant` (
    `res_id` INT PRIMARY KEY AUTO_INCREMENT,
    `res_name` VARCHAR(255) NOT NULL,
    `image` VARCHAR(255),
    `description` VARCHAR(255),
    
    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
    `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
    `deletedAt` TIMESTAMP NULL DEFAULT NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `restaurant` (`res_name`, `image`, `description`) VALUES
('Gogi House', 'gogi.jpg', 'Chuyên đồ nướng Hàn Quốc'),
('Lẩu Phan', 'lauphan.jpg', 'Lẩu buffet ngon bổ rẻ'),
('KFC', 'kfc.jpg', 'Gà rán nổi tiếng thế giới'),
('Pizza Hut', 'pizzahut.jpg', 'Pizza thơm ngon chuẩn vị Ý'),
('Lotteria', 'lotteria.jpg', 'Chuỗi nhà hàng thức ăn nhanh'),
('Bún Chả Hà Nội', 'buncha.jpg', 'Bún chả ngon đúng vị'),
('Mì Cay Sasin', 'micay.jpg', 'Mì cay Hàn Quốc 7 cấp độ'),
('Highlands Coffee', 'highlands.jpg', 'Chuỗi quán cà phê Việt Nam'),
('The Coffee House', 'coffeehouse.jpg', 'Quán cà phê phong cách hiện đại'),
('Chè Ngon 3 Miền', 'che3mien.jpg', 'Các món chè đặc sản 3 miền');


-- Bảng like_res (Lượt thích nhà hàng)
CREATE TABLE `like_res` (
    `user_id` INT,
    `res_id` INT,
    `date_like` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`user_id`, `res_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`res_id`) REFERENCES `restaurant`(`res_id`) ON DELETE CASCADE,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  `like_res` (`user_id`, `res_id`)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (4, 3),
  (5, 4),
  (6, 5),
  (7, 6),
  (8, 7),
  (9, 8),
  (9, 5),
  (10, 9);
  

-- Bảng rate_res (Đánh giá nhà hàng)
CREATE TABLE `rate_res` (
    `user_id` INT,
    `res_id` INT,
    `amount` INT CHECK(`amount` BETWEEN 1 AND 5),
    `date_rate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`user_id`, `res_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`res_id`) REFERENCES `restaurant`(`res_id`) ON DELETE CASCADE,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  `rate_res` (`user_id`, `res_id`, `amount`)
VALUES
  (1, 1, 5),
  (2, 2, 4),
  (3, 3, 3),
  (4, 4, 5),
  (5, 5, 4),
  (6, 6, 3),
  (7, 7, 5),
  (8, 8, 4),
  (9, 9, 5),
  (10, 10, 4);

-- Bảng food_type (Loại món ăn)
CREATE TABLE `food_type` (
    `type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `type_name` VARCHAR(255) NOT NULL,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  `food_type` (`type_name`)
VALUES
  ('Món nướng'),
  ('Lẩu'),
  ('Gà rán'),
  ('Pizza'),
  ('Món Việt'),
  ('Mì cay'),
  ('Cà phê'),
  ('Nước ép'),
  ('Bánh ngọt'),
  ('Chè');

-- Bảng food (Món ăn)
CREATE TABLE `food` (
    `food_id` INT PRIMARY KEY AUTO_INCREMENT,
    `food_name` VARCHAR(255) NOT NULL,
    `image` VARCHAR(255),
    `price` DECIMAL(10,2) NOT NULL,
    `description` VARCHAR(255),
    `type_id` INT,
    FOREIGN KEY (`type_id`) REFERENCES `food_type`(`type_id`) ON DELETE CASCADE,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `food` (`food_name`, `image`, `price`, `description`, `type_id`) VALUES
('Ba chỉ bò nướng', 'bacon_grill.jpg', 150000, 'Ba chỉ bò Mỹ nướng tảng', 1),
('Lẩu Thái', 'hotpot_thai.jpg', 200000, 'Lẩu Thái cay chua đặc biệt', 2),
('Gà rán KFC', 'kfc_fried.jpg', 75000, 'Gà rán giòn tan KFC', 3),
('Pizza Hải Sản', 'pizza_seafood.jpg', 250000, 'Pizza hải sản phô mai kéo sợi', 4),
('Bún Chả Hà Nội', 'buncha.jpg', 50000, 'Bún chả thơm ngon đúng vị Hà Nội', 5),
('Mì cay cấp độ 7', 'micay.jpg', 70000, 'Mì cay Hàn Quốc với 7 cấp độ', 6),
('Cà phê sữa đá', 'cafe_suada.jpg', 35000, 'Cà phê sữa đá thơm ngon', 7),
('Nước ép cam', 'juice_orange.jpg', 40000, 'Nước ép cam nguyên chất', 8),
('Bánh bông lan trứng muối', 'banh_bong_lan.jpg', 60000, 'Bánh bông lan trứng muối đặc biệt', 9),
('Chè thái sầu riêng', 'chethai.jpg', 50000, 'Chè thái sầu riêng ngọt béo thơm ngon', 10);


-- Bảng sub_food (Topping / Món ăn kèm)
CREATE TABLE `sub_food` (
    `sub_id` INT PRIMARY KEY AUTO_INCREMENT,
    `sub_name` VARCHAR(255) NOT NULL,
    `sub_price` DECIMAL(10,2) NOT NULL,
    `food_id` INT,
    FOREIGN KEY (`food_id`) REFERENCES `food`(`food_id`) ON DELETE CASCADE,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  `sub_food` (`sub_name`, `sub_price`, `food_id`)
VALUES
  ('Phô mai', 20000, 1),
  ('Bánh mì bơ tỏi', 15000, 2),
  ('Tương ớt đặc biệt', 5000, 3),
  ('Xúc xích', 25000, 4),
  ('Hành phi', 5000, 5),
  ('Chả cá', 20000, 6),
  ('Kem tươi', 10000, 7),
  ('Chanh tươi', 5000, 8),
  ('Hạnh nhân', 15000, 9),
  ('Thạch dừa', 10000, 10);


-- Bảng orders (Đơn hàng)
CREATE TABLE `orders` (
    `order_id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT,
    `food_id` INT,
    `amount` INT NOT NULL,
    `code` VARCHAR(255) UNIQUE NOT NULL,
    `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`food_id`) REFERENCES `food`(`food_id`) ON DELETE CASCADE,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
    `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
    `deletedAt` TIMESTAMP NULL DEFAULT NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `orders` (`user_id`, `food_id`, `amount`, `code`)
VALUES
  (1, 1, 2, 'ORD001'),
  (2, 2, 1, 'ORD002'),
  (3, 3, 3, 'ORD003'),
  (4, 4, 1, 'ORD004'),
  (5, 5, 2, 'ORD005'),
  (6, 6, 1, 'ORD006'),
  (7, 7, 3, 'ORD007'),
  (8, 8, 2, 'ORD008'),
  (9, 9, 1, 'ORD009'),
  (10, 10, 2, 'ORD010');

-- Bảng order_sub_food (Liên kết đơn hàng và món ăn kèm)
CREATE TABLE `order_sub_food` (
    `order_id` INT,
    `sub_id` INT,
    PRIMARY KEY (`order_id`, `sub_id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`) ON DELETE CASCADE,
    FOREIGN KEY (`sub_id`) REFERENCES `sub_food`(`sub_id`) ON DELETE CASCADE,

    -- Thông tin mặc định
    `deletedBy` INT NOT NULL DEFAULT 0,
	  `isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	  `deletedAt` TIMESTAMP NULL DEFAULT NULL,
	  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  `order_sub_food` (`order_id`, `sub_id`)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (3, 7),
  (3, 8),
  (4, 10),
  (5, 2),
  (5, 7),
  (5, 8),
  (5, 9),
  (6, 1),
  (6, 2),
  (6, 3),
  (6, 4),
  (6, 5),
  (7, 6),
  (8, 10),
  (8, 2),
  (9, 5),
  (9, 9),
  (9, 10),
  (10, 7),
  (10, 8);

-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT `user_id`, COUNT(*) AS `like_count`
FROM `like_res`
GROUP BY `user_id`
ORDER BY `like_count` DESC
LIMIT 5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT `res_id`, COUNT(*) AS `like_count`
FROM `like_res`
GROUP BY `res_id`
ORDER BY `like_count` DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất
SELECT `user_id`, COUNT(*) AS `order_count`
FROM `orders`
GROUP BY `user_id`
ORDER BY `order_count` DESC
LIMIT 1;

-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng)
SELECT `users`.`user_id`, `users`.`full_name`, `users`.`email`
FROM `users`
LEFT JOIN `orders` ON `users`.`user_id` = `orders`.`user_id`
LEFT JOIN `like_res` ON `users`.`user_id` = `like_res`.`user_id`
LEFT JOIN `rate_res` ON `users`.`user_id` = `rate_res`.`user_id`
WHERE `orders`.`user_id` IS NULL AND `like_res`.`user_id` IS NULL AND `rate_res`.`user_id` IS NULL;