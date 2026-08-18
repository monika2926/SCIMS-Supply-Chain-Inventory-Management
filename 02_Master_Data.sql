-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 02_Master_Data.sql
-- Purpose  : Insert Master Data into Database Tables
-- ==========================================================

-- ==========================================
-- Table 1 : Categories
-- Purpose : Insert Category Master Data
-- ==========================================

INSERT INTO categories(category_name,description) 
VALUES
('Rice','Rice Products'),
('Flour','Atta & Flour'),
('Oil','Cooking Oil'),
('Sugar','Sugar Products'),
('Salt','Salt Products'),
('Tea','Tea Products'),
('Coffee','Coffee Products'),
('Biscuits','Biscuits'),
('Snacks','Snacks'),
('Beverages','Cold Drinks'),
('Dairy','Milk Products'),
('Spices','Masala'),
('Personal Care','Personal Care'),
('Soap','Bath Soap'),
('Shampoo','Hair Care'),
('Detergent','Cleaning'),
('Toothpaste','Oral Care'),
('Stationery','Office Items'),
('Baby Care','Baby Products'),
('Frozen Food','Frozen Items');

-- ==========================================
-- Verification : Categories
-- Purpose      : Verify Total Category Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Categories
FROM Categories;

-- ==========================================
-- Table 2 : Warehouses
-- Purpose : Insert Warehouse Master Data
-- ==========================================

INSERT INTO warehouses
(warehouse_code, warehouse_name, city, state, warehouse_type,
storage_capacity, current_capacity, manager_name, contact_no,
email, opening_date)
VALUES
('WH001','Jaipur Central Warehouse','Jaipur','Rajasthan','Central',50000,22000,'Amit Sharma','9876500001','wh001@scims.com','2022-01-15'),
('WH002','Delhi Regional Warehouse','Delhi','Delhi','Regional',45000,18000,'Rahul Verma','9876500002','wh002@scims.com','2022-02-20'),
('WH003','Mumbai Central Warehouse','Mumbai','Maharashtra','Central',60000,30000,'Vikas Singh','9876500003','wh003@scims.com','2022-03-10'),
('WH004','Ahmedabad Warehouse','Ahmedabad','Gujarat','Regional',40000,15000,'Suresh Patel','9876500004','wh004@scims.com','2022-04-01'),
('WH005','Lucknow Warehouse','Lucknow','Uttar Pradesh','Regional',35000,12000,'Anil Gupta','9876500005','wh005@scims.com','2022-05-12');

-- ==========================================
-- Procedure : Generate_Warehouses
-- Purpose   : Generate Warehouse Master Records
-- ==========================================
    
DELIMITER $$

CREATE PROCEDURE generate_warehouses()
BEGIN
    DECLARE i INT DEFAULT 6;
	WHILE i <= 25 DO
	INSERT INTO warehouses
        (
    warehouse_code,
	warehouse_name,
	city,
	state,
	warehouse_type,
	storage_capacity,
	current_capacity,
	manager_name,
	contact_no,
	email,
	opening_date
        )
	VALUES
        (
        CONCAT('WH',LPAD(i,3,'0')),
		CONCAT('Warehouse ',i),
		CONCAT('City ',i),
		'India',
		CASE
		WHEN MOD(i,3)=0 THEN 'Central'
		WHEN MOD(i,3)=1 THEN 'Regional'
		ELSE 'Local'
		END,
		50000+(i*1000),
		FLOOR((50000+(i*1000))*0.55),
		CONCAT('Manager ',i),
		CONCAT('98765',LPAD(i,5,'0')),
		CONCAT('wh',i,'@scims.com'),
		CURDATE()
        );
        
        SET i=i+1;
		END WHILE;

END $$
DELIMITER ;

-- ==========================================
-- Execute : Generate_Warehouses
-- Purpose : Generate Warehouse Master Records
-- ==========================================

CALL Generate_Warehouses();

-- ==========================================
-- Verification : Warehouses
-- Purpose      : Verify Total Warehouse Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Warehouses
FROM Warehouses;


-- ==========================================
-- Table 3 : Suppliers
-- Purpose : Insert Supplier Master Data
-- ==========================================

INSERT INTO suppliers
(supplier_code,supplier_name,gst_number,contact_person,phone,email,city,state,payment_terms)
VALUES
('SUP001','ITC Foods','08ABCDE1234F1Z5','Rajesh Kumar','9876511111','itc@scims.com','Jaipur','Rajasthan','30 Days'),
('SUP002','Nestle India','07ABCDE1234F1Z6','Amit Singh','9876511112','nestle@scims.com','Delhi','Delhi','45 Days'),
('SUP003','HUL India','27ABCDE1234F1Z7','Vikas Sharma','9876511113','hul@scims.com','Mumbai','Maharashtra','30 Days'),
('SUP004','Parle Products','24ABCDE1234F1Z8','Rakesh Patel','9876511114','parle@scims.com','Ahmedabad','Gujarat','60 Days'),
('SUP005','Amul Dairy','09ABCDE1234F1Z9','Sanjay Gupta','9876511115','amul@scims.com','Anand','Gujarat','30 Days'),
('SUP006','Britannia Industries','27AAACB1234A1Z5','Rohit Sharma','9876510006','britanniainfo@scims.com','Bengaluru','Karnataka',4.9,'30 Days'),
('SUP007','Dabur India','07AAACD1234A1Z6','Amit Kumar','9876510007','dabur@scims.com','Delhi','Delhi',4.8,'45 Days'),
('SUP008','Marico Ltd','27AAACM1234A1Z7','Vikas Singh','9876510008','marico@scims.com','Mumbai','Maharashtra',4.9,'30 Days'),
('SUP009','Godrej Consumer','27AAACG1234A1Z8','Rakesh Patel','9876510009','godrej@scims.com','Mumbai','Maharashtra',4.8,'60 Days'),
('SUP010','Tata Consumer','29AAACT1234A1Z9','Anil Gupta','9876510010','tata@scims.com','Bengaluru','Karnataka',5.0,'30 Days'),
('SUP011','Patanjali Foods','09AAACP1234A1Z1','Deepak Sharma','9876510011','patanjali@scims.com','Haridwar','Uttarakhand',4.6,'30 Days'),
('SUP012','Emami Ltd','19AAACE1234A1Z2','Manoj Das','9876510012','emami@scims.com','Kolkata','West Bengal',4.7,'45 Days'),
('SUP013','Balaji Wafers','24AAACB1234A1Z3','Ramesh Patel','9876510013','balaji@scims.com','Rajkot','Gujarat',4.8,'30 Days'),
('SUP014','Bikaji Foods','08AAACB1234A1Z4','Suresh Jain','9876510014','bikaji@scims.com','Bikaner','Rajasthan',4.9,'45 Days'),
('SUP015','Mother Dairy','07AAACM1234A1Z5','Ashok Verma','9876510015','motherdairy@scims.com','Delhi','Delhi',4.8,'30 Days'), 
('SUP016','Everest Spices','27AAACE1016A1Z1','Raj Malhotra','9876510016','everest@scims.com','Mumbai','Maharashtra',4.7,'30 Days'),
('SUP017','MDH Spices','07AAACM1017A1Z2','Sanjay Arora','9876510017','mdh@scims.com','Delhi','Delhi',4.8,'45 Days'),
('SUP018','Hatsun Agro','33AAACH1018A1Z3','Karthik Raj','9876510018','hatsun@scims.com','Chennai','Tamil Nadu',4.7,'30 Days'),
('SUP019','MTR Foods','29AAACM1019A1Z4','Mahesh Rao','9876510019','mtr@scims.com','Bengaluru','Karnataka',4.8,'45 Days'),
('SUP020','Paper Boat','27AAACP1020A1Z5','Nitin Mehta','9876510020','paperboat@scims.com','Mumbai','Maharashtra',4.6,'60 Days');


-- ==========================================
-- Procedure : Generate_Suppliers
-- Purpose   : Generate Supplier Master Records
-- ==========================================

DELIMITER $$
CREATE PROCEDURE generate_suppliers()
BEGIN
    DECLARE i INT DEFAULT 21;
	WHILE i <= 150 DO
	INSERT INTO suppliers
        (
            Supplier_Code,
            Supplier_Name,
            Gst_Number,
            Contact_Person,
            Phone,
            Email,
            City,
            State,
            Supplier_Rating,
            Payment_Terms
        )
		VALUES
        (
            CONCAT('SUP',LPAD(i,3,'0')),
			CONCAT('Supplier ',i),
			CONCAT(
                LPAD((i MOD 35)+1,2,'0'),
                'SCIMS',
                LPAD(i,8,'0')
            ),
			CONCAT('Contact ',i),
			CONCAT('98',LPAD(i,8,'0')),
			CONCAT('supplier',i,'@scims.com'),
			ELT(
                (i MOD 10)+1,
                'Jaipur', 'Delhi', 'Mumbai', 'Ahmedabad', 'Lucknow', 'Pune', 'Bengaluru', 'Hyderabad', 'Indore', 'Chandigarh'),
			ELT(
                (i MOD 10)+1,
                'Rajasthan', 'Delhi', 'Maharashtra', 'Gujarat', 'Uttar Pradesh', 'Maharashtra', 'Karnataka', 'Telangana', 'Madhya Pradesh', 'Punjab'),
            ROUND((4 + RAND()),1),
			ELT(
                (i MOD 3)+1,
                '30 Days',
                '45 Days',
                '60 Days'
                )
                );
		SET i=i+1;
		END WHILE;

END$$
DELIMITER ;

-- ==========================================
-- Execute : Generate_Suppliers
-- Purpose : Generate Supplier Master Records
-- ==========================================

CALL Generate_Suppliers();

-- ==========================================
-- Verification : Suppliers
-- Purpose      : Verify Total Supplier Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Suppliers
FROM Suppliers;

-- ==========================================
-- Table 4 : Stores
-- Purpose : Insert Store Master Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Stores
-- Purpose   : Generate Store Master Records
-- ==========================================

DELIMITER $$

CREATE PROCEDURE generate_stores()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE wh INT;
	WHILE i <= 100 DO
		SET wh = ((i - 1) MOD 25) + 1;
		INSERT INTO stores
        (
            warehouse_id,
            store_code,
            store_name,
            city,
            state,
            address,
            manager_name,
            contact_no,
            opening_date
        )
        VALUES
        (
            wh,
            CONCAT('ST', LPAD(i,4,'0')),
            CONCAT('Store ', i),
            CONCAT('City ', wh),
            'India',
            CONCAT('Address ', i),
            CONCAT('Store Manager ', i),
            CONCAT('91234', LPAD(i,5,'0')),
            CURDATE()
        );
		SET i = i + 1;
		END WHILE;

END$$
DELIMITER ;

-- ==========================================
-- Execute : Generate_Stores_V2
-- Purpose : Generate Store Master Records
-- ==========================================

CALL Generate_Stores_V2();

-- ==========================================
-- Verification : Stores
-- Purpose      : Verify Total Store Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Stores
FROM Stores;


-- ==========================================
-- Table 5 : Employees
-- Purpose : Insert Employee Master Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Employees
-- Purpose   : Generate Employee Master Records
-- ==========================================


DELIMITER $$

CREATE PROCEDURE generate_employees()
BEGIN

    DECLARE i INT DEFAULT 1;

    WHILE i<=500 DO

        INSERT INTO employees
        (
            Warehouse_Id,
            Employee_Code,
            First_Name,
            Last_Name,
            Gender,
            Designation,
            Department,
            Salary,
            Phone,
            Email,
            Joining_Date
        )

        VALUES
        (
            ((i-1) MOD 25)+1,
            CONCAT('EMP',LPAD(i,4,'0')),
            CONCAT('First',i),
            CONCAT('Last',i),
            IF(MOD(i,2)=0,'Male','Female'),

            ELT(
                (MOD(i,8)+1),
                'Warehouse Executive',
                'Store Manager',
                'Inventory Analyst',
                'Procurement Officer',
                'HR Executive',
                'Finance Executive',
                'Data Analyst',
                'Operations Manager'
            ),

            ELT(
                (MOD(i,6)+1),
                'Warehouse',
                'Procurement',
                'Sales',
                'HR',
                'Finance',
                'IT'
            ),
			18000 + (MOD(i,63)*1000),
			CONCAT('9',LPAD(i,9,'0')),
			CONCAT('emp',i,'@scims.com'),
			DATE_ADD('2022-01-01',INTERVAL MOD(i,1200) DAY)

        );
		SET i=i+1;
		END WHILE;

END$$
DELIMITER ;

-- ==========================================
-- Execute : Generate_Employees_V2
-- Purpose : Generate Employee Master Records
-- ==========================================

CALL Generate_Employees_V2();

-- ==========================================
-- Verification : Employees
-- Purpose      : Verify Total Employee Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Employees
FROM Employees;


-- ==========================================
-- Table 6 : Users
-- Purpose : Insert User Master Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Users
-- Purpose   : Generate User Master Records
-- ==========================================

DELIMITER $$

CREATE PROCEDURE generate_users()
BEGIN
	DECLARE i INT DEFAULT 1;
	WHILE i <= 500 DO
		INSERT INTO users
        (
            Username,
            Password_Hash,
            Role,
            Employee_Id,
            Status
        )
		VALUES
        (
            CONCAT('emp', LPAD(i,4,'0')),
			SHA2(CONCAT('Emp@', LPAD(i,4,'0')),256),
			ELT(
                (MOD(i,4)+1),
                'Admin',
                'Manager',
                'Warehouse',
                'Viewer'
            ),
			i,
			'Active'
        );
		SET i = i + 1;
		END WHILE;

END$$
DELIMITER ;

-- ==========================================
-- Execute : Generate_Users
-- Purpose : Generate User Master Records
-- ==========================================

CALL Generate_Users();

-- ==========================================
-- Verification : Users
-- Purpose      : Verify Total User Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Users
FROM Users;


-- ==========================================
-- Table 7 : Products
-- Purpose : Insert Product Master Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Products
-- Purpose   : Generate Product Master Records
-- ==========================================

DROP PROCEDURE IF EXISTS generate_products;

DELIMITER $$

CREATE PROCEDURE generate_products()
BEGIN
DECLARE i INT DEFAULT 1;
WHILE i<=500 DO
INSERT INTO products
(
Product_Code,
Product_Name,
Category_Id,
Supplier_Id,
Brand,
Unit,
Weight,
Cost_Price,
Selling_Price,
Reorder_Level,
Shelf_Life_Days
)
VALUES
(
CONCAT('PRD',LPAD(i,5,'0')),

CASE MOD(i,10)
WHEN 0 THEN CONCAT('Aashirvaad Atta ',MOD(i,10)+1,'kg')
WHEN 1 THEN CONCAT('Tata Salt ',MOD(i,5)+1,'kg')
WHEN 2 THEN CONCAT('Fortune Sunflower Oil ',MOD(i,5)+1,'L')
WHEN 3 THEN CONCAT('Maggi Noodles ',MOD(i,5)+1,' Pack')
WHEN 4 THEN CONCAT('Parle G Biscuits ',MOD(i,5)*100+100,'g')
WHEN 5 THEN CONCAT('Amul Butter ',MOD(i,5)*100+100,'g')
WHEN 6 THEN CONCAT('Nescafe Coffee ',MOD(i,5)+1,'kg')
WHEN 7 THEN CONCAT('Red Label Tea ',MOD(i,5)+1,'kg')
WHEN 8 THEN CONCAT('Paper Boat Juice ',MOD(i,5)*200+200,'ml')

ELSE CONCAT('Coca Cola ',MOD(i,5)*250+250,'ml')
END,
MOD(i,20)+1,
22 + MOD(i-1,150),
CASE MOD(i,10)

WHEN 0 THEN 'Aashirvaad'
WHEN 1 THEN 'Tata'
WHEN 2 THEN 'Fortune'
WHEN 3 THEN 'Nestle'
WHEN 4 THEN 'Parle'
WHEN 5 THEN 'Amul'
WHEN 6 THEN 'Nescafe'
WHEN 7 THEN 'Red Label'
WHEN 8 THEN 'Paper Boat'
ELSE 'Coca Cola'
END,
CASE
WHEN MOD(i,10) IN (2,8,9) THEN 'L'
WHEN MOD(i,10)=4 THEN 'g'
WHEN MOD(i,10)=5 THEN 'g'
ELSE 'kg'
END,
ROUND((MOD(i,5)+1),2),
100+MOD(i,400),
150+MOD(i,500),
100,
365
);
SET i=i+1;
END WHILE;

END$$
DELIMITER ;

CALL generate_products();

DROP PROCEDURE IF EXISTS generate_products_v2;

DELIMITER $$

CREATE PROCEDURE generate_products_v2()
BEGIN

    DECLARE i INT DEFAULT 501;

    DECLARE v_brand VARCHAR(50);
    DECLARE v_product VARCHAR(100);
    DECLARE v_unit VARCHAR(10);

    WHILE i<=5000 DO

        SET v_brand=
        CASE MOD(i,15)

            WHEN 0 THEN 'Amul'
            WHEN 1 THEN 'Nestle'
            WHEN 2 THEN 'Parle'
            WHEN 3 THEN 'Britannia'
            WHEN 4 THEN 'ITC'
            WHEN 5 THEN 'Tata'
            WHEN 6 THEN 'Fortune'
            WHEN 7 THEN 'Dabur'
            WHEN 8 THEN 'Patanjali'
            WHEN 9 THEN 'Pepsi'
            WHEN 10 THEN 'Coca Cola'
            WHEN 11 THEN 'Paper Boat'
            WHEN 12 THEN 'Kelloggs'
            WHEN 13 THEN 'MDH'
            ELSE 'Everest'

        END;

        SET v_product=
        CASE MOD(i,20)

            WHEN 0 THEN 'Atta'
            WHEN 1 THEN 'Rice'
            WHEN 2 THEN 'Salt'
            WHEN 3 THEN 'Sugar'
            WHEN 4 THEN 'Tea'
            WHEN 5 THEN 'Coffee'
            WHEN 6 THEN 'Oil'
            WHEN 7 THEN 'Biscuits'
            WHEN 8 THEN 'Noodles'
            WHEN 9 THEN 'Juice'
            WHEN 10 THEN 'Milk'
            WHEN 11 THEN 'Butter'
            WHEN 12 THEN 'Cheese'
            WHEN 13 THEN 'Soap'
            WHEN 14 THEN 'Shampoo'
            WHEN 15 THEN 'Toothpaste'
            WHEN 16 THEN 'Detergent'
            WHEN 17 THEN 'Chips'
            WHEN 18 THEN 'Chocolate'
            ELSE 'Spices'

        END;

        SET v_unit=
        CASE MOD(i,4)

            WHEN 0 THEN 'kg'
            WHEN 1 THEN 'g'
            WHEN 2 THEN 'L'
            ELSE 'ml'

        END;

        INSERT INTO products
        (
            Product_Code,
            Product_Name,
            Category_Id,
            Supplier_Id,
            Brand,
            Unit,
            Weight,
            Cost_Price,
            Selling_Price,
            Reorder_Level,
            Shelf_Life_Days
        )

        VALUES
        (

            CONCAT('PRD',LPAD(i,5,'0')),
			CONCAT(
                v_brand,' ',
                v_product,' ',
                CASE MOD(i,5)
                    WHEN 0 THEN '250'
                    WHEN 1 THEN '500'
                    WHEN 2 THEN '750'
                    WHEN 3 THEN '1000'
                    ELSE '2000'
                END,
                v_unit
            ),

            MOD(i,20)+1,

            22+MOD(i-1,150),

            v_brand,

            v_unit,

            CASE MOD(i,5)
                WHEN 0 THEN 250
                WHEN 1 THEN 500
                WHEN 2 THEN 750
                WHEN 3 THEN 1000
                ELSE 2000
            END,

            ROUND(50+RAND()*500,2),
			ROUND(100+RAND()*700,2),
			FLOOR(20+RAND()*80),
			FLOOR(180+RAND()*365)

        );

        SET i=i+1;

    END WHILE;

END$$

DELIMITER ;

-- ==========================================
-- Execute : Generate_Products_V2
-- Purpose : Generate Product Master Records
-- ==========================================

CALL Generate_Products_V2();

-- ==========================================
-- Verification : Products
-- Purpose      : Verify Total Product Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Products
FROM Products;

