CREATE TABLE user (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	phone VARCHAR(12),
	password VARCHAR(18),
	realname VARCHAR(10),
	sex VARCHAR(1),
	addr VARCHAR(30)
);

CREATE TABLE boss (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	phone VARCHAR(12),
	password VARCHAR(18),
	realname VARCHAR(10),
	sex VARCHAR(1),
	addr VARCHAR(30),
	idcard VARCHAR(18)
);

CREATE TABLE categories (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	name VARCHAR(10)
);

CREATE TABLE restaurant (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	name VARCHAR(20),
	categories INT,
	boss INT,
	lat VARCHAR(10),
	lng VARCHAR(10),
	service_radius VARCHAR(10),
	FOREIGN KEY (categories) REFERENCES categories(id),
	FOREIGN KEY (boss) REFERENCES boss(id)
);

CREATE TABLE manager (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	username VARCHAR(18),
	password VARCHAR(18)
);

CREATE TABLE food (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	name VARCHAR(10),
	restaurant INT,
	price INT,
	sale_num INT DEFAULT 0,
	enable VARCHAR(1),
	FOREIGN KEY (restaurant) REFERENCES restaurant(id)
);

CREATE TABLE comment (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	restaurant VARCHAR(6) NOT NULL,
	food VARCHAR(6) NOT NULL,
	uid INT NOT NULL,
	create_date DATE,
	content VARCHAR(140),
	star_num VARCHAR(1),
	reply VARCHAR(140),
	FOREIGN KEY (uid) REFERENCES user(id)
);

CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	user INT NOT NULL,
	restaurant INT NOT NULL,
	food INT NOT NULL,
	addr VARCHAR(30),
	phone VARCHAR(12),
	price VARCHAR(6),
	create_date DATE,
	note VARCHAR(20),
	status VARCHAR(1),
	FOREIGN KEY (user) REFERENCES user(id),
	FOREIGN KEY (restaurant) REFERENCES restaurant(id),
	FOREIGN KEY (food) REFERENCES food(id)
);

CREATE TABLE feedback (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	user INT,
	create_date DATE,
	content VARCHAR(140),
	contact VARCHAR(12),
	FOREIGN KEY (user) REFERENCES user(id)
);

CREATE TABLE message (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	receiver VARCHAR(6),
	sender VARCHAR(6),
	create_date DATE,
	content VARCHAR(100),
	is_read VARCHAR(1) DEFAULT 0
);