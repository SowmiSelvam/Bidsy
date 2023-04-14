-- create database BidsyDB;
-- use BidsyDB;

-- Create table bidsy_user(first_name varchar(30), last_name varchar(20), address varchar(100), user_id varchar(30), 
-- email varchar(30), telephone_no integer(10), password varchar(30), bank_acc_no bigint(13), routing_no integer(10),primary key (user_id));

-- Create table bidsy_employee(emp_id varchar(30), is_admin boolean, user_id varchar(30), primary key(user_id), foreign key(user_id) references bidsy_user(user_id));

-- Create table seller(user_id varchar(30), primary key(user_id), foreign key(user_id) references bidsy_user(user_id));

-- Create table buyer(shipping_address varchar(50), user_id varchar(30), primary key(user_id), foreign key(user_id) references bidsy_user(user_id));

-- create table category( category_index int ,category_name varchar(50), primary key(category_index));

-- create table subcategoryBelongs(sub_category_index int, sub_category_name varchar(50), category_index int, 
-- primary key(sub_category_index), foreign key(category_index) references category(category_index));

-- create table itemClassifies(increment_bid int, item_id int auto_increment, title varchar(50), starting_price int, itemDescription varchar(50),
-- email varchar(50), start_auction_time datetime, end_auction_time datetime, bid_id int , sub_category_index int,primary key(item_id), 
-- foreign key(sub_category_index) references subcategoryBelongs(sub_category_index));

-- create table bids(bid_id int auto_increment, secret_upper_price int, bidding_price int, bid_time datetime, 
-- increment_bid int, user_id varchar(30), item_id int, 
-- primary key(bid_id), foreign key(user_id) references bidsy_user(user_id), foreign key(item_id) references itemClassifies(item_id));

-- create table sells(secret_min_price int, user_id varchar(30), item_id int auto_increment, bid_increments int, 
--  primary key(user_id, item_id), foreign key(user_id) references bidsy_user(user_id), foreign key(item_id) references itemClassifies(item_id));

-- select title, itemDescription, start_auction_time, end_auction_time, bid_id  from itemClassifies where end_auction_time > current_timestamp();

-- drop table sells
-- drop table seller


-- Delete from SubcategoryBelongs;
-- Delete from Category;
-- SET SQL_SAFE_UPDATES = 0;

-- INSERT INTO Category (category_index, category_name) 
-- VALUES (1, 'Gaming Laptops'), (2, 'Business Laptops'), (3, 'Ultrabooks'), (4, '2-in-1 Laptops'), (5, 'Budget Laptops'), 
--        (6, 'High-End Laptops'), (7, 'Student Laptops'), (8, 'Workstation Laptops'), (9, 'Chromebooks');

-- INSERT INTO SubcategoryBelongs (sub_category_index, sub_category_name, category_index) 
-- VALUES (1, 'Acer Predator Helios 300', 1), (2, 'Dell G5 15', 1), (3, 'Dell XPS 13', 3), (4, 'Lenovo Flex 5', 4), 
--        (5, 'Acer Aspire 5', 5), (6, 'HP EliteBook 840 G6', 2), (7, 'Apple MacBook Air', 7), (8, 'Lenovo ThinkPad P17', 8), 
--        (9, 'Google Pixelbook Go', 9), (10, 'Dell XPS 17', 6);

-- INSERT INTO ItemClassifies (increment_bid, item_id, title, starting_price, itemDescription, email, start_auction_time, end_auction_time, bid_id, sub_category_index) 
-- VALUES (1, 1, 'Acer Predator Helios 300', 800, 'Gaming Laptop', 'seller@example.com', '2023-04-13 12:00:00.000', '2023-04-20 12:00:00.000', 1, 1),
--        (1, 2, 'Dell XPS 13', 1000, 'Lightweight Ultrabook', 'seller@example.com', '2023-04-13 12:00:00.000', '2023-04-20 12:00:00.000', 2, 3),
--        (1, 3, 'HP EliteBook 840 G6', 900, 'Business Laptop', 'seller@example.com', '2023-04-13 12:00:00.000', '2023-04-20 12:00:00.000', 3, 6),
--        (1, 4, 'Lenovo Flex 5', 600, '2-in-1 Laptop', 'seller@example.com', '2023-04-13 12:00:00.000', '2023-04-20 12:00:00.000', 4, 4),
--        (1, 5, 'Acer Aspire 5', 400, 'Budget Laptop', 'seller@example.com', '2023-04-13 12:00:00.000', '2023-04-20 12:00:00.000', 5, 5),
--        (1, 6, 'Dell XPS 17', 2000, 'High-End Laptop', 'seller@example.com', '2023-04-13 12:00:00.000', '2023-04-20 12:00:00.000', 6, 6);

--  create table comments_inEditsContainsQnA(q_user_id varchar(30), a_user_id varchar(30), date_time datetime, item_id int, question varchar(256), answer varchar(256),
--   primary key(q_user_id, date_time, item_id), foreign key(q_user_id) references bidsy_user(user_id), foreign key(a_user_id) references bidsy_employee(user_id), foreign key(item_id) references ItemClassifies(item_id));

-- drop table comments_inEditsContainsQnA

-- Insert 5 bids for item 1 by 5 different users
-- INSERT INTO bids (secret_upper_price, bidding_price, bid_time, increment_bid, user_id, item_id)
-- VALUES
--     (1200, 800, '2023-04-15 14:20:00.000', 10, 'vj@bidsy.com', 1),
--     (1000, 850, '2023-04-16 10:45:00.000', 5, 'ag@bidsy.com', 1),
--     (1100, 900, '2023-04-17 13:30:00.000', 10, 'hk@bidsy.com', 1),
--     (1500, 1000, '2023-04-18 16:15:00.000', 20, 'selvam@bidsy.com', 1);

-- -- Insert 3 bids for item 2 by 3 different users
-- INSERT INTO bids (secret_upper_price, bidding_price, bid_time, increment_bid, user_id, item_id)
-- VALUES
--     (1800, 1300, '2023-04-16 16:45:00.000', 20, 'vj@bidsy.com', 2),
--     (2000, 1400, '2023-04-18 10:30:00.000', 25, 'ag@bidsy.com', 2),
--     (1700, 1500, '2023-04-19 12:15:00.000', 30, 'hk@bidsy.com', 2);

-- UPDATE itemClassifies
-- SET bid_id = (
--     SELECT MAX(bid_id)
--     FROM bids
--     WHERE bids.item_id = itemClassifies.item_id
-- )




