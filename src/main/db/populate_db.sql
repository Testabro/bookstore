DELETE FROM book;
ALTER TABLE book AUTO_INCREMENT = 1001;

DELETE FROM category;
ALTER TABLE category AUTO_INCREMENT = 1001;

INSERT INTO `category` (`name`) VALUES ('computer-science'),('art'),('trades'),('outdoor');

INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Illiad', 'Homer', 699, TRUE, 1001);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Brothers Karamazov', 'Fyodor Dostoyevski', 799, TRUE, 1002);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Little Dorrit', 'Charles Dickens', 599, TRUE, 1003);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Little Dorrit', 'Charles Dickens', 599, TRUE, 1004);