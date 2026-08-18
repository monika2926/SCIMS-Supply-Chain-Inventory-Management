-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 04_Schema_Updates_&_Cleaning_Data.sql
-- Purpose  : Perform Schema Updates and Data Cleaning
-- ==========================================================

-- ==========================================
-- Schema Update   : Purchase_Orders
-- Purpose         : Modify Purchase Orders Table Structure
-- ==========================================

ALTER TABLE purchase_orders
ADD COLUMN Employee_Id INT AFTER Warehouse_Id;

ALTER TABLE purchase_orders
ADD CONSTRAINT fk_po_employee
FOREIGN KEY (Employee_Id)
REFERENCES employees(Employee_Id);

ALTER TABLE purchase_orders
ADD COLUMN Remarks VARCHAR(255) NULL
AFTER Payment_Status;

UPDATE purchase_orders
SET Employee_Id = 1 + FLOOR(RAND() * 500);


-- ==========================================
-- Verification : Purchase_Order
-- Purpose      : Verify Schema Update
-- ==========================================

DESCRIBE Purchase_Order


-- ==========================================
-- Schema Update   : Purchase_order_items
-- Purpose         : Modify  purchase_order_items Table Structure
-- ==========================================


ALTER TABLE purchase_order_items
ADD COLUMN Received_Qty INT
AFTER Quantity;

-- ==========================================
-- Verification : Purchase Order Items
-- Purpose      : Verify Schema Update
-- ==========================================

DESCRIBE Purchase_Order_Items;



-- ==========================================
-- Data Cleaning   : Warehouse_Capacity
-- Purpose         : Update Available Capacity
-- ==========================================

UPDATE warehouse_capacity
SET Available_Capacity = Total_Capacity - Used_Capacity;

-- ==========================================
-- Verification : Warehouse Capacity
-- Purpose      : Verify Updated Capacity
-- ==========================================

SELECT
    Warehouse_Id, Total_Capacity, Used_Capacity, Available_Capacity
	FROM Warehouse_Capacity;


-- ==========================================
-- Procedure : Update_Product_Price
-- Purpose   : Update Product Cost and Selling Price
-- ==========================================

DROP PROCEDURE IF EXISTS Update_Product_Price;

DELIMITER $$

CREATE PROCEDURE Update_Product_Price
(
    IN p_Product_Id INT,
    IN p_Cost_Price DECIMAL(10,2),
    IN p_Selling_Price DECIMAL(10,2)
)
BEGIN

    UPDATE products
    SET
        Cost_Price = p_Cost_Price,
        Selling_Price = p_Selling_Price
    WHERE Product_Id = p_Product_Id;

    SELECT
        Product_Id,
        Product_Name,
        Cost_Price,
        Selling_Price
    FROM products
    WHERE Product_Id = p_Product_Id;

END $$

DELIMITER ;

-- ==========================================
-- Execute : Update_Product_Price
-- Purpose : Update Product Price
-- ==========================================

CALL Update_Product_Price(12,120.00,170.00);


-- ==========================================
-- Data Cleaning   : Employees
-- Purpose         : Update Employee Names and Email Addresses
-- ==========================================
       
UPDATE employees
SET
First_Name = CASE Employee_Id
WHEN 1 THEN 'Rahul'
WHEN 2 THEN 'Ravi'
WHEN 3 THEN 'Priya'
WHEN 4 THEN 'Amit'
WHEN 5 THEN 'Neha'
WHEN 6 THEN 'Rohit'
WHEN 7 THEN 'Pooja'
WHEN 8 THEN 'Vikas'
WHEN 9 THEN 'Sneha'
WHEN 10 THEN 'Arjun'
WHEN 11 THEN 'Anjali'
WHEN 12 THEN 'Deepak'
WHEN 13 THEN 'Kavita'
WHEN 14 THEN 'Mohit'
WHEN 15 THEN 'Riya'
WHEN 16 THEN 'Sandeep'
WHEN 17 THEN 'Nisha'
WHEN 18 THEN 'Ajay'
WHEN 19 THEN 'Komal'
WHEN 20 THEN 'Manish'
ELSE First_Name
END,

Last_Name = CASE Employee_Id
WHEN 1 THEN 'Sharma'
WHEN 2 THEN 'Verma'
WHEN 3 THEN 'Gupta'
WHEN 4 THEN 'Singh'
WHEN 5 THEN 'Jain'
WHEN 6 THEN 'Mehta'
WHEN 7 THEN 'Agrawal'
WHEN 8 THEN 'Yadav'
WHEN 9 THEN 'Kapoor'
WHEN 10 THEN 'Joshi'
WHEN 11 THEN 'Malhotra'
WHEN 12 THEN 'Mishra'
WHEN 13 THEN 'Chauhan'
WHEN 14 THEN 'Patel'
WHEN 15 THEN 'Saxena'
WHEN 16 THEN 'Bansal'
WHEN 17 THEN 'Goyal'
WHEN 18 THEN 'Tiwari'
WHEN 19 THEN 'Agarwal'
WHEN 20 THEN 'Soni'
ELSE Last_Name
END,

Email = CASE Employee_Id
WHEN 1 THEN 'rahul.sharma@scims.com'
WHEN 2 THEN 'ravi.verma@scims.com'
WHEN 3 THEN 'priya.gupta@scims.com'
WHEN 4 THEN 'amit.singh@scims.com'
WHEN 5 THEN 'neha.jain@scims.com'
WHEN 6 THEN 'rohit.mehta@scims.com'
WHEN 7 THEN 'pooja.agrawal@scims.com'
WHEN 8 THEN 'vikas.yadav@scims.com'
WHEN 9 THEN 'sneha.kapoor@scims.com'
WHEN 10 THEN 'arjun.joshi@scims.com'
WHEN 11 THEN 'anjali.malhotra@scims.com'
WHEN 12 THEN 'deepak.mishra@scims.com'
WHEN 13 THEN 'kavita.chauhan@scims.com'
WHEN 14 THEN 'mohit.patel@scims.com'
WHEN 15 THEN 'riya.saxena@scims.com'
WHEN 16 THEN 'sandeep.bansal@scims.com'
WHEN 17 THEN 'nisha.goyal@scims.com'
WHEN 18 THEN 'ajay.tiwari@scims.com'
WHEN 19 THEN 'komal.agarwal@scims.com'
WHEN 20 THEN 'manish.soni@scims.com'
ELSE Email
END
WHERE Employee_Id BETWEEN 1 AND 20;

-- ==========================================
-- Data Cleaning   : Employees
-- Purpose         : Update Remaining Employee Records
-- ==========================================

UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma21@scims.com' WHERE Employee_Id=21;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma22@scims.com' WHERE Employee_Id=22;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta23@scims.com' WHERE Employee_Id=23;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh24@scims.com' WHERE Employee_Id=24;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain25@scims.com' WHERE Employee_Id=25;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta26@scims.com' WHERE Employee_Id=26;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal27@scims.com' WHERE Employee_Id=27;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav28@scims.com' WHERE Employee_Id=28;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor29@scims.com' WHERE Employee_Id=29;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi30@scims.com' WHERE Employee_Id=30;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra31@scims.com' WHERE Employee_Id=31;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra32@scims.com' WHERE Employee_Id=32;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan33@scims.com' WHERE Employee_Id=33;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel34@scims.com' WHERE Employee_Id=34;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena35@scims.com' WHERE Employee_Id=35;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal36@scims.com' WHERE Employee_Id=36;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal37@scims.com' WHERE Employee_Id=37;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari38@scims.com' WHERE Employee_Id=38;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal39@scims.com' WHERE Employee_Id=39;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni40@scims.com' WHERE Employee_Id=40;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma41@scims.com' WHERE Employee_Id=41;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma42@scims.com' WHERE Employee_Id=42;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta43@scims.com' WHERE Employee_Id=43;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh44@scims.com' WHERE Employee_Id=44;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain45@scims.com' WHERE Employee_Id=45;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta46@scims.com' WHERE Employee_Id=46;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal47@scims.com' WHERE Employee_Id=47;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav48@scims.com' WHERE Employee_Id=48;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor49@scims.com' WHERE Employee_Id=49;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi50@scims.com' WHERE Employee_Id=50;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra51@scims.com' WHERE Employee_Id=51;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra52@scims.com' WHERE Employee_Id=52;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan53@scims.com' WHERE Employee_Id=53;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel54@scims.com' WHERE Employee_Id=54;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena55@scims.com' WHERE Employee_Id=55;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal56@scims.com' WHERE Employee_Id=56;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal57@scims.com' WHERE Employee_Id=57;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari58@scims.com' WHERE Employee_Id=58;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal59@scims.com' WHERE Employee_Id=59;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni60@scims.com' WHERE Employee_Id=60;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma61@scims.com' WHERE Employee_Id=61;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma62@scims.com' WHERE Employee_Id=62;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta63@scims.com' WHERE Employee_Id=63;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh64@scims.com' WHERE Employee_Id=64;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain65@scims.com' WHERE Employee_Id=65;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta66@scims.com' WHERE Employee_Id=66;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal67@scims.com' WHERE Employee_Id=67;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav68@scims.com' WHERE Employee_Id=68;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor69@scims.com' WHERE Employee_Id=69;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi70@scims.com' WHERE Employee_Id=70;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra71@scims.com' WHERE Employee_Id=71;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra72@scims.com' WHERE Employee_Id=72;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan73@scims.com' WHERE Employee_Id=73;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel74@scims.com' WHERE Employee_Id=74;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena75@scims.com' WHERE Employee_Id=75;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal76@scims.com' WHERE Employee_Id=76;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal77@scims.com' WHERE Employee_Id=77;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari78@scims.com' WHERE Employee_Id=78;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal79@scims.com' WHERE Employee_Id=79;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni80@scims.com' WHERE Employee_Id=80;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma81@scims.com' WHERE Employee_Id=81;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma82@scims.com' WHERE Employee_Id=82;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta83@scims.com' WHERE Employee_Id=83;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh84@scims.com' WHERE Employee_Id=84;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain85@scims.com' WHERE Employee_Id=85;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta86@scims.com' WHERE Employee_Id=86;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal87@scims.com' WHERE Employee_Id=87;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav88@scims.com' WHERE Employee_Id=88;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor89@scims.com' WHERE Employee_Id=89;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi90@scims.com' WHERE Employee_Id=90;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra91@scims.com' WHERE Employee_Id=91;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra92@scims.com' WHERE Employee_Id=92;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan93@scims.com' WHERE Employee_Id=93;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel94@scims.com' WHERE Employee_Id=94;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena95@scims.com' WHERE Employee_Id=95;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal96@scims.com' WHERE Employee_Id=96;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal97@scims.com' WHERE Employee_Id=97;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari98@scims.com' WHERE Employee_Id=98;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal99@scims.com' WHERE Employee_Id=99;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni100@scims.com' WHERE Employee_Id=100;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma101@scims.com' WHERE Employee_Id=101;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma102@scims.com' WHERE Employee_Id=102;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta103@scims.com' WHERE Employee_Id=103;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh104@scims.com' WHERE Employee_Id=104;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain105@scims.com' WHERE Employee_Id=105;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta106@scims.com' WHERE Employee_Id=106;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal107@scims.com' WHERE Employee_Id=107;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav108@scims.com' WHERE Employee_Id=108;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor109@scims.com' WHERE Employee_Id=109;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi110@scims.com' WHERE Employee_Id=110;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra111@scims.com' WHERE Employee_Id=111;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra112@scims.com' WHERE Employee_Id=112;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan113@scims.com' WHERE Employee_Id=113;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel114@scims.com' WHERE Employee_Id=114;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena115@scims.com' WHERE Employee_Id=115;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal116@scims.com' WHERE Employee_Id=116;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal117@scims.com' WHERE Employee_Id=117;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari118@scims.com' WHERE Employee_Id=118;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal119@scims.com' WHERE Employee_Id=119;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni120@scims.com' WHERE Employee_Id=120;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma121@scims.com' WHERE Employee_Id=121;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma122@scims.com' WHERE Employee_Id=122;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta123@scims.com' WHERE Employee_Id=123;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh124@scims.com' WHERE Employee_Id=124;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain125@scims.com' WHERE Employee_Id=125;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta126@scims.com' WHERE Employee_Id=126;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal127@scims.com' WHERE Employee_Id=127;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav128@scims.com' WHERE Employee_Id=128;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor129@scims.com' WHERE Employee_Id=129;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi130@scims.com' WHERE Employee_Id=130;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra131@scims.com' WHERE Employee_Id=131;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra132@scims.com' WHERE Employee_Id=132;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan133@scims.com' WHERE Employee_Id=133;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel134@scims.com' WHERE Employee_Id=134;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena135@scims.com' WHERE Employee_Id=135;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal136@scims.com' WHERE Employee_Id=136;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal137@scims.com' WHERE Employee_Id=137;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari138@scims.com' WHERE Employee_Id=138;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal139@scims.com' WHERE Employee_Id=139;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni140@scims.com' WHERE Employee_Id=140;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma141@scims.com' WHERE Employee_Id=141;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma142@scims.com' WHERE Employee_Id=142;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta143@scims.com' WHERE Employee_Id=143;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh144@scims.com' WHERE Employee_Id=144;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain145@scims.com' WHERE Employee_Id=145;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta146@scims.com' WHERE Employee_Id=146;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal147@scims.com' WHERE Employee_Id=147;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav148@scims.com' WHERE Employee_Id=148;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor149@scims.com' WHERE Employee_Id=149;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi150@scims.com' WHERE Employee_Id=150;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra151@scims.com' WHERE Employee_Id=151;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra152@scims.com' WHERE Employee_Id=152;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan153@scims.com' WHERE Employee_Id=153;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel154@scims.com' WHERE Employee_Id=154;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena155@scims.com' WHERE Employee_Id=155;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal156@scims.com' WHERE Employee_Id=156;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal157@scims.com' WHERE Employee_Id=157;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari158@scims.com' WHERE Employee_Id=158;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal159@scims.com' WHERE Employee_Id=159;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni160@scims.com' WHERE Employee_Id=160;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma161@scims.com' WHERE Employee_Id=161;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma162@scims.com' WHERE Employee_Id=162;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta163@scims.com' WHERE Employee_Id=163;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh164@scims.com' WHERE Employee_Id=164;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain165@scims.com' WHERE Employee_Id=165;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta166@scims.com' WHERE Employee_Id=166;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal167@scims.com' WHERE Employee_Id=167;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav168@scims.com' WHERE Employee_Id=168;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor169@scims.com' WHERE Employee_Id=169;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi170@scims.com' WHERE Employee_Id=170;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra171@scims.com' WHERE Employee_Id=171;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra172@scims.com' WHERE Employee_Id=172;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan173@scims.com' WHERE Employee_Id=173;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel174@scims.com' WHERE Employee_Id=174;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena175@scims.com' WHERE Employee_Id=175;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal176@scims.com' WHERE Employee_Id=176;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal177@scims.com' WHERE Employee_Id=177;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari178@scims.com' WHERE Employee_Id=178;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal179@scims.com' WHERE Employee_Id=179;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni180@scims.com' WHERE Employee_Id=180;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma181@scims.com' WHERE Employee_Id=181;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma182@scims.com' WHERE Employee_Id=182;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta183@scims.com' WHERE Employee_Id=183;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh184@scims.com' WHERE Employee_Id=184;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain185@scims.com' WHERE Employee_Id=185;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta186@scims.com' WHERE Employee_Id=186;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal187@scims.com' WHERE Employee_Id=187;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav188@scims.com' WHERE Employee_Id=188;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor189@scims.com' WHERE Employee_Id=189;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi190@scims.com' WHERE Employee_Id=190;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra191@scims.com' WHERE Employee_Id=191;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra192@scims.com' WHERE Employee_Id=192;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan193@scims.com' WHERE Employee_Id=193;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel194@scims.com' WHERE Employee_Id=194;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena195@scims.com' WHERE Employee_Id=195;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal196@scims.com' WHERE Employee_Id=196;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal197@scims.com' WHERE Employee_Id=197;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari198@scims.com' WHERE Employee_Id=198;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal199@scims.com' WHERE Employee_Id=199;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni200@scims.com' WHERE Employee_Id=200;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma201@scims.com' WHERE Employee_Id=201;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma202@scims.com' WHERE Employee_Id=202;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta203@scims.com' WHERE Employee_Id=203;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh204@scims.com' WHERE Employee_Id=204;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain205@scims.com' WHERE Employee_Id=205;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta206@scims.com' WHERE Employee_Id=206;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal207@scims.com' WHERE Employee_Id=207;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav208@scims.com' WHERE Employee_Id=208;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor209@scims.com' WHERE Employee_Id=209;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi210@scims.com' WHERE Employee_Id=210;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra211@scims.com' WHERE Employee_Id=211;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra212@scims.com' WHERE Employee_Id=212;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan213@scims.com' WHERE Employee_Id=213;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel214@scims.com' WHERE Employee_Id=214;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena215@scims.com' WHERE Employee_Id=215;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal216@scims.com' WHERE Employee_Id=216;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal217@scims.com' WHERE Employee_Id=217;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari218@scims.com' WHERE Employee_Id=218;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal219@scims.com' WHERE Employee_Id=219;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni220@scims.com' WHERE Employee_Id=220;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma221@scims.com' WHERE Employee_Id=221;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma222@scims.com' WHERE Employee_Id=222;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta223@scims.com' WHERE Employee_Id=223;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh224@scims.com' WHERE Employee_Id=224;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain225@scims.com' WHERE Employee_Id=225;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta226@scims.com' WHERE Employee_Id=226;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal227@scims.com' WHERE Employee_Id=227;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav228@scims.com' WHERE Employee_Id=228;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor229@scims.com' WHERE Employee_Id=229;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi230@scims.com' WHERE Employee_Id=230;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra231@scims.com' WHERE Employee_Id=231;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra232@scims.com' WHERE Employee_Id=232;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan233@scims.com' WHERE Employee_Id=233;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel234@scims.com' WHERE Employee_Id=234;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena235@scims.com' WHERE Employee_Id=235;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal236@scims.com' WHERE Employee_Id=236;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal237@scims.com' WHERE Employee_Id=237;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari238@scims.com' WHERE Employee_Id=238;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal239@scims.com' WHERE Employee_Id=239;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni240@scims.com' WHERE Employee_Id=240;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma241@scims.com' WHERE Employee_Id=241;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma242@scims.com' WHERE Employee_Id=242;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta243@scims.com' WHERE Employee_Id=243;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh244@scims.com' WHERE Employee_Id=244;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain245@scims.com' WHERE Employee_Id=245;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta246@scims.com' WHERE Employee_Id=246;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal247@scims.com' WHERE Employee_Id=247;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav248@scims.com' WHERE Employee_Id=248;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor249@scims.com' WHERE Employee_Id=249;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi250@scims.com' WHERE Employee_Id=250;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra251@scims.com' WHERE Employee_Id=251;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra252@scims.com' WHERE Employee_Id=252;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan253@scims.com' WHERE Employee_Id=253;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel254@scims.com' WHERE Employee_Id=254;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena255@scims.com' WHERE Employee_Id=255;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal256@scims.com' WHERE Employee_Id=256;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal257@scims.com' WHERE Employee_Id=257;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari258@scims.com' WHERE Employee_Id=258;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal259@scims.com' WHERE Employee_Id=259;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni260@scims.com' WHERE Employee_Id=260;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma261@scims.com' WHERE Employee_Id=261;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma262@scims.com' WHERE Employee_Id=262;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta263@scims.com' WHERE Employee_Id=263;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh264@scims.com' WHERE Employee_Id=264;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain265@scims.com' WHERE Employee_Id=265;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta266@scims.com' WHERE Employee_Id=266;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal267@scims.com' WHERE Employee_Id=267;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav268@scims.com' WHERE Employee_Id=268;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor269@scims.com' WHERE Employee_Id=269;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi270@scims.com' WHERE Employee_Id=270;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra271@scims.com' WHERE Employee_Id=271;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra272@scims.com' WHERE Employee_Id=272;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan273@scims.com' WHERE Employee_Id=273;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel274@scims.com' WHERE Employee_Id=274;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena275@scims.com' WHERE Employee_Id=275;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal276@scims.com' WHERE Employee_Id=276;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal277@scims.com' WHERE Employee_Id=277;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari278@scims.com' WHERE Employee_Id=278;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal279@scims.com' WHERE Employee_Id=279;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni280@scims.com' WHERE Employee_Id=280;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma281@scims.com' WHERE Employee_Id=281;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma282@scims.com' WHERE Employee_Id=282;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta283@scims.com' WHERE Employee_Id=283;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh284@scims.com' WHERE Employee_Id=284;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain285@scims.com' WHERE Employee_Id=285;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta286@scims.com' WHERE Employee_Id=286;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal287@scims.com' WHERE Employee_Id=287;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav288@scims.com' WHERE Employee_Id=288;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor289@scims.com' WHERE Employee_Id=289;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi290@scims.com' WHERE Employee_Id=290;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra291@scims.com' WHERE Employee_Id=291;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra292@scims.com' WHERE Employee_Id=292;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan293@scims.com' WHERE Employee_Id=293;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel294@scims.com' WHERE Employee_Id=294;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena295@scims.com' WHERE Employee_Id=295;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal296@scims.com' WHERE Employee_Id=296;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal297@scims.com' WHERE Employee_Id=297;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari298@scims.com' WHERE Employee_Id=298;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal299@scims.com' WHERE Employee_Id=299;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni300@scims.com' WHERE Employee_Id=300;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma301@scims.com' WHERE Employee_Id=301;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma302@scims.com' WHERE Employee_Id=302;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta303@scims.com' WHERE Employee_Id=303;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh304@scims.com' WHERE Employee_Id=304;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain305@scims.com' WHERE Employee_Id=305;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta306@scims.com' WHERE Employee_Id=306;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal307@scims.com' WHERE Employee_Id=307;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav308@scims.com' WHERE Employee_Id=308;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor309@scims.com' WHERE Employee_Id=309;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi310@scims.com' WHERE Employee_Id=310;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra311@scims.com' WHERE Employee_Id=311;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra312@scims.com' WHERE Employee_Id=312;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan313@scims.com' WHERE Employee_Id=313;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel314@scims.com' WHERE Employee_Id=314;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena315@scims.com' WHERE Employee_Id=315;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal316@scims.com' WHERE Employee_Id=316;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal317@scims.com' WHERE Employee_Id=317;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari318@scims.com' WHERE Employee_Id=318;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal319@scims.com' WHERE Employee_Id=319;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni320@scims.com' WHERE Employee_Id=320;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma321@scims.com' WHERE Employee_Id=321;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma322@scims.com' WHERE Employee_Id=322;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta323@scims.com' WHERE Employee_Id=323;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh324@scims.com' WHERE Employee_Id=324;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain325@scims.com' WHERE Employee_Id=325;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta326@scims.com' WHERE Employee_Id=326;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal327@scims.com' WHERE Employee_Id=327;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav328@scims.com' WHERE Employee_Id=328;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor329@scims.com' WHERE Employee_Id=329;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi330@scims.com' WHERE Employee_Id=330;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra331@scims.com' WHERE Employee_Id=331;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra332@scims.com' WHERE Employee_Id=332;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan333@scims.com' WHERE Employee_Id=333;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel334@scims.com' WHERE Employee_Id=334;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena335@scims.com' WHERE Employee_Id=335;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal336@scims.com' WHERE Employee_Id=336;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal337@scims.com' WHERE Employee_Id=337;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari338@scims.com' WHERE Employee_Id=338;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal339@scims.com' WHERE Employee_Id=339;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni340@scims.com' WHERE Employee_Id=340;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma341@scims.com' WHERE Employee_Id=341;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma342@scims.com' WHERE Employee_Id=342;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta343@scims.com' WHERE Employee_Id=343;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh344@scims.com' WHERE Employee_Id=344;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain345@scims.com' WHERE Employee_Id=345;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta346@scims.com' WHERE Employee_Id=346;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal347@scims.com' WHERE Employee_Id=347;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav348@scims.com' WHERE Employee_Id=348;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor349@scims.com' WHERE Employee_Id=349;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi350@scims.com' WHERE Employee_Id=350;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra351@scims.com' WHERE Employee_Id=351;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra352@scims.com' WHERE Employee_Id=352;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan353@scims.com' WHERE Employee_Id=353;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel354@scims.com' WHERE Employee_Id=354;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena355@scims.com' WHERE Employee_Id=355;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal356@scims.com' WHERE Employee_Id=356;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal357@scims.com' WHERE Employee_Id=357;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari358@scims.com' WHERE Employee_Id=358;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal359@scims.com' WHERE Employee_Id=359;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni360@scims.com' WHERE Employee_Id=360;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma361@scims.com' WHERE Employee_Id=361;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma362@scims.com' WHERE Employee_Id=362;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta363@scims.com' WHERE Employee_Id=363;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh364@scims.com' WHERE Employee_Id=364;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain365@scims.com' WHERE Employee_Id=365;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta366@scims.com' WHERE Employee_Id=366;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal367@scims.com' WHERE Employee_Id=367;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav368@scims.com' WHERE Employee_Id=368;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor369@scims.com' WHERE Employee_Id=369;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi370@scims.com' WHERE Employee_Id=370;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra371@scims.com' WHERE Employee_Id=371;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra372@scims.com' WHERE Employee_Id=372;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan373@scims.com' WHERE Employee_Id=373;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel374@scims.com' WHERE Employee_Id=374;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena375@scims.com' WHERE Employee_Id=375;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal376@scims.com' WHERE Employee_Id=376;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal377@scims.com' WHERE Employee_Id=377;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari378@scims.com' WHERE Employee_Id=378;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal379@scims.com' WHERE Employee_Id=379;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni380@scims.com' WHERE Employee_Id=380;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma381@scims.com' WHERE Employee_Id=381;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma382@scims.com' WHERE Employee_Id=382;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta383@scims.com' WHERE Employee_Id=383;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh384@scims.com' WHERE Employee_Id=384;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain385@scims.com' WHERE Employee_Id=385;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta386@scims.com' WHERE Employee_Id=386;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal387@scims.com' WHERE Employee_Id=387;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav388@scims.com' WHERE Employee_Id=388;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor389@scims.com' WHERE Employee_Id=389;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi390@scims.com' WHERE Employee_Id=390;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra391@scims.com' WHERE Employee_Id=391;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra392@scims.com' WHERE Employee_Id=392;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan393@scims.com' WHERE Employee_Id=393;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel394@scims.com' WHERE Employee_Id=394;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena395@scims.com' WHERE Employee_Id=395;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal396@scims.com' WHERE Employee_Id=396;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal397@scims.com' WHERE Employee_Id=397;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari398@scims.com' WHERE Employee_Id=398;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal399@scims.com' WHERE Employee_Id=399;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni400@scims.com' WHERE Employee_Id=400;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma401@scims.com' WHERE Employee_Id=401;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma402@scims.com' WHERE Employee_Id=402;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta403@scims.com' WHERE Employee_Id=403;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh404@scims.com' WHERE Employee_Id=404;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain405@scims.com' WHERE Employee_Id=405;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta406@scims.com' WHERE Employee_Id=406;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal407@scims.com' WHERE Employee_Id=407;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav408@scims.com' WHERE Employee_Id=408;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor409@scims.com' WHERE Employee_Id=409;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi410@scims.com' WHERE Employee_Id=410;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra411@scims.com' WHERE Employee_Id=411;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra412@scims.com' WHERE Employee_Id=412;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan413@scims.com' WHERE Employee_Id=413;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel414@scims.com' WHERE Employee_Id=414;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena415@scims.com' WHERE Employee_Id=415;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal416@scims.com' WHERE Employee_Id=416;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal417@scims.com' WHERE Employee_Id=417;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari418@scims.com' WHERE Employee_Id=418;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal419@scims.com' WHERE Employee_Id=419;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni420@scims.com' WHERE Employee_Id=420;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma421@scims.com' WHERE Employee_Id=421;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma422@scims.com' WHERE Employee_Id=422;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta423@scims.com' WHERE Employee_Id=423;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh424@scims.com' WHERE Employee_Id=424;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain425@scims.com' WHERE Employee_Id=425;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta426@scims.com' WHERE Employee_Id=426;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal427@scims.com' WHERE Employee_Id=427;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav428@scims.com' WHERE Employee_Id=428;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor429@scims.com' WHERE Employee_Id=429;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi430@scims.com' WHERE Employee_Id=430;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra431@scims.com' WHERE Employee_Id=431;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra432@scims.com' WHERE Employee_Id=432;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan433@scims.com' WHERE Employee_Id=433;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel434@scims.com' WHERE Employee_Id=434;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena435@scims.com' WHERE Employee_Id=435;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal436@scims.com' WHERE Employee_Id=436;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal437@scims.com' WHERE Employee_Id=437;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari438@scims.com' WHERE Employee_Id=438;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal439@scims.com' WHERE Employee_Id=439;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni440@scims.com' WHERE Employee_Id=440;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma441@scims.com' WHERE Employee_Id=441;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma442@scims.com' WHERE Employee_Id=442;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta443@scims.com' WHERE Employee_Id=443;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh444@scims.com' WHERE Employee_Id=444;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain445@scims.com' WHERE Employee_Id=445;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta446@scims.com' WHERE Employee_Id=446;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal447@scims.com' WHERE Employee_Id=447;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav448@scims.com' WHERE Employee_Id=448;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor449@scims.com' WHERE Employee_Id=449;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi450@scims.com' WHERE Employee_Id=450;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra451@scims.com' WHERE Employee_Id=451;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra452@scims.com' WHERE Employee_Id=452;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan453@scims.com' WHERE Employee_Id=453;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel454@scims.com' WHERE Employee_Id=454;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena455@scims.com' WHERE Employee_Id=455;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal456@scims.com' WHERE Employee_Id=456;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal457@scims.com' WHERE Employee_Id=457;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari458@scims.com' WHERE Employee_Id=458;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal459@scims.com' WHERE Employee_Id=459;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni460@scims.com' WHERE Employee_Id=460;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma461@scims.com' WHERE Employee_Id=461;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma462@scims.com' WHERE Employee_Id=462;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta463@scims.com' WHERE Employee_Id=463;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh464@scims.com' WHERE Employee_Id=464;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain465@scims.com' WHERE Employee_Id=465;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta466@scims.com' WHERE Employee_Id=466;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal467@scims.com' WHERE Employee_Id=467;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav468@scims.com' WHERE Employee_Id=468;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor469@scims.com' WHERE Employee_Id=469;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi470@scims.com' WHERE Employee_Id=470;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra471@scims.com' WHERE Employee_Id=471;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra472@scims.com' WHERE Employee_Id=472;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan473@scims.com' WHERE Employee_Id=473;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel474@scims.com' WHERE Employee_Id=474;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena475@scims.com' WHERE Employee_Id=475;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal476@scims.com' WHERE Employee_Id=476;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal477@scims.com' WHERE Employee_Id=477;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari478@scims.com' WHERE Employee_Id=478;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal479@scims.com' WHERE Employee_Id=479;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni480@scims.com' WHERE Employee_Id=480;
UPDATE employees SET First_Name='Priya', Last_Name='Sharma', Email='priya.sharma481@scims.com' WHERE Employee_Id=481;
UPDATE employees SET First_Name='Ravi', Last_Name='Verma', Email='ravi.verma482@scims.com' WHERE Employee_Id=482;
UPDATE employees SET First_Name='Pooja', Last_Name='Gupta', Email='pooja.gupta483@scims.com' WHERE Employee_Id=483;
UPDATE employees SET First_Name='Rohit', Last_Name='Singh', Email='rohit.singh484@scims.com' WHERE Employee_Id=484;
UPDATE employees SET First_Name='Aarti', Last_Name='Jain', Email='aarti.jain485@scims.com' WHERE Employee_Id=485;
UPDATE employees SET First_Name='Sandeep', Last_Name='Mehta', Email='sandeep.mehta486@scims.com' WHERE Employee_Id=486;
UPDATE employees SET First_Name='Nisha', Last_Name='Agrawal', Email='nisha.agrawal487@scims.com' WHERE Employee_Id=487;
UPDATE employees SET First_Name='Vikas', Last_Name='Yadav', Email='vikas.yadav488@scims.com' WHERE Employee_Id=488;
UPDATE employees SET First_Name='Anjali', Last_Name='Kapoor', Email='anjali.kapoor489@scims.com' WHERE Employee_Id=489;
UPDATE employees SET First_Name='Karan', Last_Name='Joshi', Email='karan.joshi490@scims.com' WHERE Employee_Id=490;
UPDATE employees SET First_Name='Shreya', Last_Name='Malhotra', Email='shreya.malhotra491@scims.com' WHERE Employee_Id=491;
UPDATE employees SET First_Name='Nitin', Last_Name='Mishra', Email='nitin.mishra492@scims.com' WHERE Employee_Id=492;
UPDATE employees SET First_Name='Payal', Last_Name='Chauhan', Email='payal.chauhan493@scims.com' WHERE Employee_Id=493;
UPDATE employees SET First_Name='Vivek', Last_Name='Patel', Email='vivek.patel494@scims.com' WHERE Employee_Id=494;
UPDATE employees SET First_Name='Divya', Last_Name='Saxena', Email='divya.saxena495@scims.com' WHERE Employee_Id=495;
UPDATE employees SET First_Name='Manish', Last_Name='Bansal', Email='manish.bansal496@scims.com' WHERE Employee_Id=496;
UPDATE employees SET First_Name='Swati', Last_Name='Goyal', Email='swati.goyal497@scims.com' WHERE Employee_Id=497;
UPDATE employees SET First_Name='Sachin', Last_Name='Tiwari', Email='sachin.tiwari498@scims.com' WHERE Employee_Id=498;
UPDATE employees SET First_Name='Megha', Last_Name='Agarwal', Email='megha.agarwal499@scims.com' WHERE Employee_Id=499;
UPDATE employees SET First_Name='Sumit', Last_Name='Soni', Email='sumit.soni500@scims.com' WHERE Employee_Id=500;


UPDATE employees
SET
First_Name = ELT(
MOD(Employee_Id-1,20)+1,
'Rahul','Ravi','Amit','Rohit','Ankit',
'Sandeep','Deepak','Vikas','Arjun','Karan',
'Priya','Neha','Pooja','Sneha','Anjali',
'Riya','Nisha','Kavita','Komal','Sumit'
),

Last_Name = ELT(
MOD(Employee_Id-1,20)+1,
'Sharma','Verma','Gupta','Singh','Jain',
'Mehta','Patel','Yadav','Kapoor','Joshi',
'Malhotra','Mishra','Chauhan','Bansal','Goyal',
'Tiwari','Agarwal','Saxena','Soni','Pandey'
),

Email = LOWER(CONCAT(
ELT(
MOD(Employee_Id-1,20)+1,
'Rahul','Ravi','Amit','Rohit','Ankit',
'Sandeep','Deepak','Vikas','Arjun','Karan',
'Priya','Neha','Pooja','Sneha','Anjali',
'Riya','Nisha','Kavita','Komal','Sumit'
),
'.',
ELT(
MOD(Employee_Id-1,20)+1,
'Sharma','Verma','Gupta','Singh','Jain',
'Mehta','Patel','Yadav','Kapoor','Joshi',
'Malhotra','Mishra','Chauhan','Bansal','Goyal',
'Tiwari','Agarwal','Saxena','Soni','Pandey'
),
Employee_Id,
'@scims.com'
));

-- ==========================================
-- Verification : Employees
-- Purpose      : Verify Employee Master Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Employees
FROM Employees;

-- ==========================================
-- Data Cleaning   : Users
-- Purpose         : Update Username Records
-- ==========================================

WITH User_New_Name AS
(
    SELECT
        u.User_Id,
        LOWER(
            CONCAT(
                e.First_Name,
                '.',
                e.Last_Name,
                CASE 
                    WHEN ROW_NUMBER() OVER(
                        PARTITION BY e.First_Name,e.Last_Name 
                        ORDER BY u.User_Id
                    ) = 1 
                    THEN ''
                    ELSE ROW_NUMBER() OVER(
                        PARTITION BY e.First_Name,e.Last_Name 
                        ORDER BY u.User_Id
                    )
                END
            )
        ) AS New_Username
    FROM Users u
    JOIN Employees e
    ON u.Employee_Id = e.Employee_Id
)

UPDATE Users u
JOIN User_New_Name n
ON u.User_Id = n.User_Id
SET u.Username = n.New_Username;

-- ==========================================
-- Verification : Users
-- Purpose      : Verify User Master Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Users
FROM Users;

-- ==========================================
-- Data Cleaning  : Stores
-- Purpose         : Update Stores Records
-- ==========================================

UPDATE Stores
SET
Store_Name = CASE Store_Id
WHEN 1 THEN 'Jaipur Mansarovar Store'
WHEN 2 THEN 'Jaipur Vaishali Nagar Store'
WHEN 3 THEN 'Jaipur Malviya Nagar Store'
WHEN 4 THEN 'Jaipur Raja Park Store'
WHEN 5 THEN 'Jaipur Jagatpura Store'
WHEN 6 THEN 'Delhi Connaught Place Store'
WHEN 7 THEN 'Delhi Rohini Store'
WHEN 8 THEN 'Delhi Dwarka Store'
WHEN 9 THEN 'Delhi Karol Bagh Store'
WHEN 10 THEN 'Delhi Lajpat Nagar Store'
WHEN 11 THEN 'Mumbai Andheri West Store'
WHEN 12 THEN 'Mumbai Borivali Store'
WHEN 13 THEN 'Mumbai Powai Store'
WHEN 14 THEN 'Mumbai Navi Mumbai Store'
WHEN 15 THEN 'Mumbai Dadar Store'
WHEN 16 THEN 'Bengaluru Indiranagar Store'
WHEN 17 THEN 'Bengaluru Whitefield Store'
WHEN 18 THEN 'Bengaluru Koramangala Store'
WHEN 19 THEN 'Bengaluru Electronic City Store'
WHEN 20 THEN 'Bengaluru Jayanagar Store'
WHEN 21 THEN 'Hyderabad Gachibowli Store'
WHEN 22 THEN 'Hyderabad Banjara Hills Store'
WHEN 23 THEN 'Hyderabad Hitech City Store'
WHEN 24 THEN 'Hyderabad Kukatpally Store'
WHEN 25 THEN 'Hyderabad Madhapur Store'
END,

City = CASE Store_Id
WHEN 1 THEN 'Jaipur'
WHEN 2 THEN 'Jaipur'
WHEN 3 THEN 'Jaipur'
WHEN 4 THEN 'Jaipur'
WHEN 5 THEN 'Jaipur'
WHEN 6 THEN 'Delhi'
WHEN 7 THEN 'Delhi'
WHEN 8 THEN 'Delhi'
WHEN 9 THEN 'Delhi'
WHEN 10 THEN 'Delhi'
WHEN 11 THEN 'Mumbai'
WHEN 12 THEN 'Mumbai'
WHEN 13 THEN 'Mumbai'
WHEN 14 THEN 'Mumbai'
WHEN 15 THEN 'Mumbai'
WHEN 16 THEN 'Bengaluru'
WHEN 17 THEN 'Bengaluru'
WHEN 18 THEN 'Bengaluru'
WHEN 19 THEN 'Bengaluru'
WHEN 20 THEN 'Bengaluru'
WHEN 21 THEN 'Hyderabad'
WHEN 22 THEN 'Hyderabad'
WHEN 23 THEN 'Hyderabad'
WHEN 24 THEN 'Hyderabad'
WHEN 25 THEN 'Hyderabad'
END,

State = CASE Store_Id
WHEN 1 THEN 'Rajasthan'
WHEN 2 THEN 'Rajasthan'
WHEN 3 THEN 'Rajasthan'
WHEN 4 THEN 'Rajasthan'
WHEN 5 THEN 'Rajasthan'
WHEN 6 THEN 'Delhi'
WHEN 7 THEN 'Delhi'
WHEN 8 THEN 'Delhi'
WHEN 9 THEN 'Delhi'
WHEN 10 THEN 'Delhi'
WHEN 11 THEN 'Maharashtra'
WHEN 12 THEN 'Maharashtra'
WHEN 13 THEN 'Maharashtra'
WHEN 14 THEN 'Maharashtra'
WHEN 15 THEN 'Maharashtra'
WHEN 16 THEN 'Karnataka'
WHEN 17 THEN 'Karnataka'
WHEN 18 THEN 'Karnataka'
WHEN 19 THEN 'Karnataka'
WHEN 20 THEN 'Karnataka'
WHEN 21 THEN 'Telangana'
WHEN 22 THEN 'Telangana'
WHEN 23 THEN 'Telangana'
WHEN 24 THEN 'Telangana'
WHEN 25 THEN 'Telangana'
END,

Manager_Name = CASE Store_Id
WHEN 1 THEN 'Rahul Sharma'
WHEN 2 THEN 'Ravi Verma'
WHEN 3 THEN 'Amit Gupta'
WHEN 4 THEN 'Rohit Singh'
WHEN 5 THEN 'Ankit Jain'
WHEN 6 THEN 'Sandeep Mehta'
WHEN 7 THEN 'Deepak Patel'
WHEN 8 THEN 'Vikas Yadav'
WHEN 9 THEN 'Arjun Kapoor'
WHEN 10 THEN 'Karan Joshi'
WHEN 11 THEN 'Priya Malhotra'
WHEN 12 THEN 'Neha Mishra'
WHEN 13 THEN 'Pooja Chauhan'
WHEN 14 THEN 'Sneha Bansal'
WHEN 15 THEN 'Anjali Goyal'
WHEN 16 THEN 'Riya Tiwari'
WHEN 17 THEN 'Nisha Agarwal'
WHEN 18 THEN 'Kavita Saxena'
WHEN 19 THEN 'Komal Soni'
WHEN 20 THEN 'Sumit Pandey'
WHEN 21 THEN 'Rahul Sharma'
WHEN 22 THEN 'Ravi Verma'
WHEN 23 THEN 'Amit Gupta'
WHEN 24 THEN 'Rohit Singh'
WHEN 25 THEN 'Ankit Jain'
END,

Address = CONCAT(Store_Name, ', ', City),

Contact_No = CONCAT('98765', LPAD(Store_Id,5,'0'))

WHERE Store_Id BETWEEN 1 AND 25;

SELECT Store_Id, Store_Name, City, State, Manager_Name
FROM Stores
LIMIT 25;


UPDATE Stores
SET
Store_Name = CASE Store_Id
WHEN 26 THEN 'Pune Hinjewadi Store'
WHEN 27 THEN 'Pune Baner Store'
WHEN 28 THEN 'Pune Kothrud Store'
WHEN 29 THEN 'Pune Viman Nagar Store'
WHEN 30 THEN 'Pune Wakad Store'
WHEN 31 THEN 'Ahmedabad Satellite Store'
WHEN 32 THEN 'Ahmedabad SG Highway Store'
WHEN 33 THEN 'Ahmedabad Navrangpura Store'
WHEN 34 THEN 'Ahmedabad Maninagar Store'
WHEN 35 THEN 'Ahmedabad Bopal Store'
WHEN 36 THEN 'Chennai T Nagar Store'
WHEN 37 THEN 'Chennai Anna Nagar Store'
WHEN 38 THEN 'Chennai Velachery Store'
WHEN 39 THEN 'Chennai OMR Store'
WHEN 40 THEN 'Chennai Tambaram Store'
WHEN 41 THEN 'Kolkata Salt Lake Store'
WHEN 42 THEN 'Kolkata Park Street Store'
WHEN 43 THEN 'Kolkata New Town Store'
WHEN 44 THEN 'Kolkata Howrah Store'
WHEN 45 THEN 'Kolkata Dum Dum Store'
WHEN 46 THEN 'Lucknow Gomti Nagar Store'
WHEN 47 THEN 'Lucknow Hazratganj Store'
WHEN 48 THEN 'Lucknow Alambagh Store'
WHEN 49 THEN 'Lucknow Indira Nagar Store'
WHEN 50 THEN 'Lucknow Aliganj Store'
END,

City = CASE Store_Id
WHEN 26 THEN 'Pune'
WHEN 27 THEN 'Pune'
WHEN 28 THEN 'Pune'
WHEN 29 THEN 'Pune'
WHEN 30 THEN 'Pune'
WHEN 31 THEN 'Ahmedabad'
WHEN 32 THEN 'Ahmedabad'
WHEN 33 THEN 'Ahmedabad'
WHEN 34 THEN 'Ahmedabad'
WHEN 35 THEN 'Ahmedabad'
WHEN 36 THEN 'Chennai'
WHEN 37 THEN 'Chennai'
WHEN 38 THEN 'Chennai'
WHEN 39 THEN 'Chennai'
WHEN 40 THEN 'Chennai'
WHEN 41 THEN 'Kolkata'
WHEN 42 THEN 'Kolkata'
WHEN 43 THEN 'Kolkata'
WHEN 44 THEN 'Kolkata'
WHEN 45 THEN 'Kolkata'
WHEN 46 THEN 'Lucknow'
WHEN 47 THEN 'Lucknow'
WHEN 48 THEN 'Lucknow'
WHEN 49 THEN 'Lucknow'
WHEN 50 THEN 'Lucknow'
END,

State = CASE Store_Id
WHEN 26 THEN 'Maharashtra'
WHEN 27 THEN 'Maharashtra'
WHEN 28 THEN 'Maharashtra'
WHEN 29 THEN 'Maharashtra'
WHEN 30 THEN 'Maharashtra'
WHEN 31 THEN 'Gujarat'
WHEN 32 THEN 'Gujarat'
WHEN 33 THEN 'Gujarat'
WHEN 34 THEN 'Gujarat'
WHEN 35 THEN 'Gujarat'
WHEN 36 THEN 'Tamil Nadu'
WHEN 37 THEN 'Tamil Nadu'
WHEN 38 THEN 'Tamil Nadu'
WHEN 39 THEN 'Tamil Nadu'
WHEN 40 THEN 'Tamil Nadu'
WHEN 41 THEN 'West Bengal'
WHEN 42 THEN 'West Bengal'
WHEN 43 THEN 'West Bengal'
WHEN 44 THEN 'West Bengal'
WHEN 45 THEN 'West Bengal'
WHEN 46 THEN 'Uttar Pradesh'
WHEN 47 THEN 'Uttar Pradesh'
WHEN 48 THEN 'Uttar Pradesh'
WHEN 49 THEN 'Uttar Pradesh'
WHEN 50 THEN 'Uttar Pradesh'
END,

Manager_Name = CASE Store_Id
WHEN 26 THEN 'Sandeep Mehta'
WHEN 27 THEN 'Deepak Patel'
WHEN 28 THEN 'Vikas Yadav'
WHEN 29 THEN 'Arjun Kapoor'
WHEN 30 THEN 'Karan Joshi'
WHEN 31 THEN 'Priya Malhotra'
WHEN 32 THEN 'Neha Mishra'
WHEN 33 THEN 'Pooja Chauhan'
WHEN 34 THEN 'Sneha Bansal'
WHEN 35 THEN 'Anjali Goyal'
WHEN 36 THEN 'Riya Tiwari'
WHEN 37 THEN 'Nisha Agarwal'
WHEN 38 THEN 'Kavita Saxena'
WHEN 39 THEN 'Komal Soni'
WHEN 40 THEN 'Sumit Pandey'
WHEN 41 THEN 'Rahul Sharma'
WHEN 42 THEN 'Ravi Verma'
WHEN 43 THEN 'Amit Gupta'
WHEN 44 THEN 'Rohit Singh'
WHEN 45 THEN 'Ankit Jain'
WHEN 46 THEN 'Sandeep Mehta'
WHEN 47 THEN 'Deepak Patel'
WHEN 48 THEN 'Vikas Yadav'
WHEN 49 THEN 'Arjun Kapoor'
WHEN 50 THEN 'Karan Joshi'
END,

Address = CASE Store_Id
WHEN 26 THEN 'Hinjewadi, Pune'
WHEN 27 THEN 'Baner, Pune'
WHEN 28 THEN 'Kothrud, Pune'
WHEN 29 THEN 'Viman Nagar, Pune'
WHEN 30 THEN 'Wakad, Pune'
WHEN 31 THEN 'Satellite, Ahmedabad'
WHEN 32 THEN 'SG Highway, Ahmedabad'
WHEN 33 THEN 'Navrangpura, Ahmedabad'
WHEN 34 THEN 'Maninagar, Ahmedabad'
WHEN 35 THEN 'Bopal, Ahmedabad'
WHEN 36 THEN 'T Nagar, Chennai'
WHEN 37 THEN 'Anna Nagar, Chennai'
WHEN 38 THEN 'Velachery, Chennai'
WHEN 39 THEN 'Old Mahabalipuram Road, Chennai'
WHEN 40 THEN 'Tambaram, Chennai'
WHEN 41 THEN 'Salt Lake, Kolkata'
WHEN 42 THEN 'Park Street, Kolkata'
WHEN 43 THEN 'New Town, Kolkata'
WHEN 44 THEN 'Howrah, Kolkata'
WHEN 45 THEN 'Dum Dum, Kolkata'
WHEN 46 THEN 'Gomti Nagar, Lucknow'
WHEN 47 THEN 'Hazratganj, Lucknow'
WHEN 48 THEN 'Alambagh, Lucknow'
WHEN 49 THEN 'Indira Nagar, Lucknow'
WHEN 50 THEN 'Aliganj, Lucknow'
END,

Contact_No = CONCAT('98765', LPAD(Store_Id,5,'0'))

WHERE Store_Id BETWEEN 26 AND 50;

SELECT Store_Id, Store_Name, City, State, Manager_Name
FROM Stores
WHERE Store_Id BETWEEN 26 AND 50;

UPDATE Stores
SET
Store_Name = CASE Store_Id
WHEN 51 THEN 'Indore Vijay Nagar Store'
WHEN 52 THEN 'Indore Palasia Store'
WHEN 53 THEN 'Indore Bhawarkua Store'
WHEN 54 THEN 'Indore Rajendra Nagar Store'
WHEN 55 THEN 'Indore AB Road Store'
WHEN 56 THEN 'Bhopal MP Nagar Store'
WHEN 57 THEN 'Bhopal Arera Colony Store'
WHEN 58 THEN 'Bhopal Kolar Road Store'
WHEN 59 THEN 'Bhopal New Market Store'
WHEN 60 THEN 'Bhopal Shahpura Store'
WHEN 61 THEN 'Surat Adajan Store'
WHEN 62 THEN 'Surat Vesu Store'
WHEN 63 THEN 'Surat Katargam Store'
WHEN 64 THEN 'Surat Varachha Store'
WHEN 65 THEN 'Surat Athwa Store'
WHEN 66 THEN 'Nagpur Dharampeth Store'
WHEN 67 THEN 'Nagpur Sitabuldi Store'
WHEN 68 THEN 'Nagpur Wardha Road Store'
WHEN 69 THEN 'Nagpur Manish Nagar Store'
WHEN 70 THEN 'Nagpur Sadar Store'
WHEN 71 THEN 'Chandigarh Sector 17 Store'
WHEN 72 THEN 'Chandigarh Sector 22 Store'
WHEN 73 THEN 'Chandigarh Sector 35 Store'
WHEN 74 THEN 'Chandigarh Manimajra Store'
WHEN 75 THEN 'Chandigarh Zirakpur Store'
END,

City = CASE Store_Id
WHEN 51 THEN 'Indore'
WHEN 52 THEN 'Indore'
WHEN 53 THEN 'Indore'
WHEN 54 THEN 'Indore'
WHEN 55 THEN 'Indore'
WHEN 56 THEN 'Bhopal'
WHEN 57 THEN 'Bhopal'
WHEN 58 THEN 'Bhopal'
WHEN 59 THEN 'Bhopal'
WHEN 60 THEN 'Bhopal'
WHEN 61 THEN 'Surat'
WHEN 62 THEN 'Surat'
WHEN 63 THEN 'Surat'
WHEN 64 THEN 'Surat'
WHEN 65 THEN 'Surat'
WHEN 66 THEN 'Nagpur'
WHEN 67 THEN 'Nagpur'
WHEN 68 THEN 'Nagpur'
WHEN 69 THEN 'Nagpur'
WHEN 70 THEN 'Nagpur'
WHEN 71 THEN 'Chandigarh'
WHEN 72 THEN 'Chandigarh'
WHEN 73 THEN 'Chandigarh'
WHEN 74 THEN 'Chandigarh'
WHEN 75 THEN 'Zirakpur'
END,

State = CASE Store_Id
WHEN 51 THEN 'Madhya Pradesh'
WHEN 52 THEN 'Madhya Pradesh'
WHEN 53 THEN 'Madhya Pradesh'
WHEN 54 THEN 'Madhya Pradesh'
WHEN 55 THEN 'Madhya Pradesh'
WHEN 56 THEN 'Madhya Pradesh'
WHEN 57 THEN 'Madhya Pradesh'
WHEN 58 THEN 'Madhya Pradesh'
WHEN 59 THEN 'Madhya Pradesh'
WHEN 60 THEN 'Madhya Pradesh'
WHEN 61 THEN 'Gujarat'
WHEN 62 THEN 'Gujarat'
WHEN 63 THEN 'Gujarat'
WHEN 64 THEN 'Gujarat'
WHEN 65 THEN 'Gujarat'
WHEN 66 THEN 'Maharashtra'
WHEN 67 THEN 'Maharashtra'
WHEN 68 THEN 'Maharashtra'
WHEN 69 THEN 'Maharashtra'
WHEN 70 THEN 'Maharashtra'
WHEN 71 THEN 'Chandigarh'
WHEN 72 THEN 'Chandigarh'
WHEN 73 THEN 'Chandigarh'
WHEN 74 THEN 'Chandigarh'
WHEN 75 THEN 'Punjab'
END,

Manager_Name = CASE Store_Id
WHEN 51 THEN 'Priya Malhotra'
WHEN 52 THEN 'Neha Mishra'
WHEN 53 THEN 'Pooja Chauhan'
WHEN 54 THEN 'Sneha Bansal'
WHEN 55 THEN 'Anjali Goyal'
WHEN 56 THEN 'Riya Tiwari'
WHEN 57 THEN 'Nisha Agarwal'
WHEN 58 THEN 'Kavita Saxena'
WHEN 59 THEN 'Komal Soni'
WHEN 60 THEN 'Sumit Pandey'
WHEN 61 THEN 'Rahul Sharma'
WHEN 62 THEN 'Ravi Verma'
WHEN 63 THEN 'Amit Gupta'
WHEN 64 THEN 'Rohit Singh'
WHEN 65 THEN 'Ankit Jain'
WHEN 66 THEN 'Sandeep Mehta'
WHEN 67 THEN 'Deepak Patel'
WHEN 68 THEN 'Vikas Yadav'
WHEN 69 THEN 'Arjun Kapoor'
WHEN 70 THEN 'Karan Joshi'
WHEN 71 THEN 'Priya Malhotra'
WHEN 72 THEN 'Neha Mishra'
WHEN 73 THEN 'Pooja Chauhan'
WHEN 74 THEN 'Sneha Bansal'
WHEN 75 THEN 'Anjali Goyal'
END,

Address = CASE Store_Id
WHEN 51 THEN 'Vijay Nagar, Indore'
WHEN 52 THEN 'Palasia, Indore'
WHEN 53 THEN 'Bhawarkua, Indore'
WHEN 54 THEN 'Rajendra Nagar, Indore'
WHEN 55 THEN 'AB Road, Indore'
WHEN 56 THEN 'MP Nagar, Bhopal'
WHEN 57 THEN 'Arera Colony, Bhopal'
WHEN 58 THEN 'Kolar Road, Bhopal'
WHEN 59 THEN 'New Market, Bhopal'
WHEN 60 THEN 'Shahpura, Bhopal'
WHEN 61 THEN 'Adajan, Surat'
WHEN 62 THEN 'Vesu, Surat'
WHEN 63 THEN 'Katargam, Surat'
WHEN 64 THEN 'Varachha, Surat'
WHEN 65 THEN 'Athwa, Surat'
WHEN 66 THEN 'Dharampeth, Nagpur'
WHEN 67 THEN 'Sitabuldi, Nagpur'
WHEN 68 THEN 'Wardha Road, Nagpur'
WHEN 69 THEN 'Manish Nagar, Nagpur'
WHEN 70 THEN 'Sadar, Nagpur'
WHEN 71 THEN 'Sector 17, Chandigarh'
WHEN 72 THEN 'Sector 22, Chandigarh'
WHEN 73 THEN 'Sector 35, Chandigarh'
WHEN 74 THEN 'Manimajra, Chandigarh'
WHEN 75 THEN 'Zirakpur, Punjab'
END,

Contact_No = CONCAT('98765', LPAD(Store_Id,5,'0'))

WHERE Store_Id BETWEEN 51 AND 75;

SELECT Store_Id, Store_Name, City, State
FROM Stores
WHERE Store_Id BETWEEN 51 AND 75;

UPDATE Stores
SET
Store_Name = CASE Store_Id
WHEN 76 THEN 'Kochi MG Road Store'
WHEN 77 THEN 'Kochi Kakkanad Store'
WHEN 78 THEN 'Kochi Edappally Store'
WHEN 79 THEN 'Kochi Aluva Store'
WHEN 80 THEN 'Kochi Vyttila Store'
WHEN 81 THEN 'Bhubaneswar Patia Store'
WHEN 82 THEN 'Bhubaneswar Saheed Nagar Store'
WHEN 83 THEN 'Bhubaneswar Khandagiri Store'
WHEN 84 THEN 'Bhubaneswar Rasulgarh Store'
WHEN 85 THEN 'Bhubaneswar Nayapalli Store'
WHEN 86 THEN 'Coimbatore RS Puram Store'
WHEN 87 THEN 'Coimbatore Gandhipuram Store'
WHEN 88 THEN 'Coimbatore Peelamedu Store'
WHEN 89 THEN 'Coimbatore Saravanampatti Store'
WHEN 90 THEN 'Coimbatore Singanallur Store'
WHEN 91 THEN 'Visakhapatnam MVP Colony Store'
WHEN 92 THEN 'Visakhapatnam Gajuwaka Store'
WHEN 93 THEN 'Visakhapatnam Dwaraka Nagar Store'
WHEN 94 THEN 'Visakhapatnam Madhurawada Store'
WHEN 95 THEN 'Visakhapatnam NAD Junction Store'
WHEN 96 THEN 'Guwahati GS Road Store'
WHEN 97 THEN 'Guwahati Beltola Store'
WHEN 98 THEN 'Guwahati Maligaon Store'
WHEN 99 THEN 'Guwahati Paltan Bazar Store'
WHEN 100 THEN 'Guwahati Zoo Road Store'
END,

City = CASE Store_Id
WHEN 76 THEN 'Kochi'
WHEN 77 THEN 'Kochi'
WHEN 78 THEN 'Kochi'
WHEN 79 THEN 'Kochi'
WHEN 80 THEN 'Kochi'
WHEN 81 THEN 'Bhubaneswar'
WHEN 82 THEN 'Bhubaneswar'
WHEN 83 THEN 'Bhubaneswar'
WHEN 84 THEN 'Bhubaneswar'
WHEN 85 THEN 'Bhubaneswar'
WHEN 86 THEN 'Coimbatore'
WHEN 87 THEN 'Coimbatore'
WHEN 88 THEN 'Coimbatore'
WHEN 89 THEN 'Coimbatore'
WHEN 90 THEN 'Coimbatore'
WHEN 91 THEN 'Visakhapatnam'
WHEN 92 THEN 'Visakhapatnam'
WHEN 93 THEN 'Visakhapatnam'
WHEN 94 THEN 'Visakhapatnam'
WHEN 95 THEN 'Visakhapatnam'
WHEN 96 THEN 'Guwahati'
WHEN 97 THEN 'Guwahati'
WHEN 98 THEN 'Guwahati'
WHEN 99 THEN 'Guwahati'
WHEN 100 THEN 'Guwahati'
END,

State = CASE Store_Id
WHEN 76 THEN 'Kerala'
WHEN 77 THEN 'Kerala'
WHEN 78 THEN 'Kerala'
WHEN 79 THEN 'Kerala'
WHEN 80 THEN 'Kerala'
WHEN 81 THEN 'Odisha'
WHEN 82 THEN 'Odisha'
WHEN 83 THEN 'Odisha'
WHEN 84 THEN 'Odisha'
WHEN 85 THEN 'Odisha'
WHEN 86 THEN 'Tamil Nadu'
WHEN 87 THEN 'Tamil Nadu'
WHEN 88 THEN 'Tamil Nadu'
WHEN 89 THEN 'Tamil Nadu'
WHEN 90 THEN 'Tamil Nadu'
WHEN 91 THEN 'Andhra Pradesh'
WHEN 92 THEN 'Andhra Pradesh'
WHEN 93 THEN 'Andhra Pradesh'
WHEN 94 THEN 'Andhra Pradesh'
WHEN 95 THEN 'Andhra Pradesh'
WHEN 96 THEN 'Assam'
WHEN 97 THEN 'Assam'
WHEN 98 THEN 'Assam'
WHEN 99 THEN 'Assam'
WHEN 100 THEN 'Assam'
END,

Manager_Name = CASE Store_Id
WHEN 76 THEN 'Rahul Sharma'
WHEN 77 THEN 'Ravi Verma'
WHEN 78 THEN 'Amit Gupta'
WHEN 79 THEN 'Rohit Singh'
WHEN 80 THEN 'Ankit Jain'
WHEN 81 THEN 'Sandeep Mehta'
WHEN 82 THEN 'Deepak Patel'
WHEN 83 THEN 'Vikas Yadav'
WHEN 84 THEN 'Arjun Kapoor'
WHEN 85 THEN 'Karan Joshi'
WHEN 86 THEN 'Priya Malhotra'
WHEN 87 THEN 'Neha Mishra'
WHEN 88 THEN 'Pooja Chauhan'
WHEN 89 THEN 'Sneha Bansal'
WHEN 90 THEN 'Anjali Goyal'
WHEN 91 THEN 'Riya Tiwari'
WHEN 92 THEN 'Nisha Agarwal'
WHEN 93 THEN 'Kavita Saxena'
WHEN 94 THEN 'Komal Soni'
WHEN 95 THEN 'Sumit Pandey'
WHEN 96 THEN 'Rahul Sharma'
WHEN 97 THEN 'Ravi Verma'
WHEN 98 THEN 'Amit Gupta'
WHEN 99 THEN 'Rohit Singh'
WHEN 100 THEN 'Ankit Jain'
END,

Address = CASE Store_Id
WHEN 76 THEN 'MG Road, Kochi'
WHEN 77 THEN 'Kakkanad, Kochi'
WHEN 78 THEN 'Edappally, Kochi'
WHEN 79 THEN 'Aluva, Kochi'
WHEN 80 THEN 'Vyttila, Kochi'
WHEN 81 THEN 'Patia, Bhubaneswar'
WHEN 82 THEN 'Saheed Nagar, Bhubaneswar'
WHEN 83 THEN 'Khandagiri, Bhubaneswar'
WHEN 84 THEN 'Rasulgarh, Bhubaneswar'
WHEN 85 THEN 'Nayapalli, Bhubaneswar'
WHEN 86 THEN 'RS Puram, Coimbatore'
WHEN 87 THEN 'Gandhipuram, Coimbatore'
WHEN 88 THEN 'Peelamedu, Coimbatore'
WHEN 89 THEN 'Saravanampatti, Coimbatore'
WHEN 90 THEN 'Singanallur, Coimbatore'
WHEN 91 THEN 'MVP Colony, Visakhapatnam'
WHEN 92 THEN 'Gajuwaka, Visakhapatnam'
WHEN 93 THEN 'Dwaraka Nagar, Visakhapatnam'
WHEN 94 THEN 'Madhurawada, Visakhapatnam'
WHEN 95 THEN 'NAD Junction, Visakhapatnam'
WHEN 96 THEN 'GS Road, Guwahati'
WHEN 97 THEN 'Beltola, Guwahati'
WHEN 98 THEN 'Maligaon, Guwahati'
WHEN 99 THEN 'Paltan Bazar, Guwahati'
WHEN 100 THEN 'Zoo Road, Guwahati'
END,

Contact_No = CONCAT('98765', LPAD(Store_Id,5,'0'))

WHERE Store_Id BETWEEN 76 AND 100;

SELECT Store_Id,
       Store_Name,
       City,
       State,
       Manager_Name
FROM Stores
WHERE Store_Id BETWEEN 76 AND 100;

-- ==========================================
-- Verification : Stores
-- Purpose      : Verify Store Master Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Stores
FROM Stores;


-- ==========================================
-- Schema Update   : Products
-- Purpose         : Add Barcode Column
-- ==========================================

ALTER TABLE Products
ADD Barcode VARCHAR(30) UNIQUE AFTER Product_Code;

-- ==========================================
-- Data Cleaning   : Products
-- Purpose         : Generate Unique Product Barcodes
-- ==========================================

UPDATE Products
SET Barcode = CONCAT('8901', LPAD(Product_Id, 8, '0'));
UPDATE Products
SET Barcode = CONCAT('8901', LPAD(Product_Id, 8, '0'));

-- ==========================================
-- Verification : Products
-- Purpose      : Verify Generated Product Barcodes
-- ==========================================

SELECT
    Product_Id, Product_Code, Barcode
	FROM Products
	LIMIT 10;



-- ==========================================
-- Data Cleaning  : Suppliers
-- Purpose        : Update Supplier Records with Realistic Details
-- Description    : Generate Realistic Supplier Information for Supplier_Id 41–150
-- ==========================================   
   
   UPDATE Suppliers
SET Supplier_Name =
CASE Supplier_Id

WHEN 41 THEN 'Shree Ganesh Traders'
WHEN 42 THEN 'Om Distributors'
WHEN 43 THEN 'Shiv Shakti Enterprises'
WHEN 44 THEN 'Balaji Agencies'
WHEN 45 THEN 'Krishna Wholesale'
WHEN 46 THEN 'Mahalaxmi Traders'
WHEN 47 THEN 'Rajasthan Foods Supply'
WHEN 48 THEN 'Royal FMCG Distributor'
WHEN 49 THEN 'Sai Enterprises'
WHEN 50 THEN 'Annapurna Traders'

WHEN 51 THEN 'Shree Balaji Distributors'
WHEN 52 THEN 'Ganpati Wholesale'
WHEN 53 THEN 'Vinayak Enterprises'
WHEN 54 THEN 'Sharma Food Supply'
WHEN 55 THEN 'Agarwal Trading Company'
WHEN 56 THEN 'Jain Brothers'
WHEN 57 THEN 'Gupta FMCG'
WHEN 58 THEN 'R K Distributors'
WHEN 59 THEN 'National Traders'
WHEN 60 THEN 'Prime Agencies'

WHEN 61 THEN 'Fresh Mart Suppliers'
WHEN 62 THEN 'Super Distributors'
WHEN 63 THEN 'Quality Traders'
WHEN 64 THEN 'Metro Wholesale'
WHEN 65 THEN 'Capital Agencies'
WHEN 66 THEN 'New India Distributors'
WHEN 67 THEN 'Smart Supply Chain'
WHEN 68 THEN 'Universal Traders'
WHEN 69 THEN 'Green India Traders'
WHEN 70 THEN 'Daily Needs Supply'

ELSE Supplier_Name
END
WHERE Supplier_Id BETWEEN 41 AND 70;

UPDATE Suppliers
SET Contact_Person =
CASE Supplier_Id

WHEN 41 THEN 'Rajesh Sharma'
WHEN 42 THEN 'Amit Verma'
WHEN 43 THEN 'Vikas Gupta'
WHEN 44 THEN 'Suresh Patel'
WHEN 45 THEN 'Deepak Singh'
WHEN 46 THEN 'Rohit Jain'
WHEN 47 THEN 'Anil Agarwal'
WHEN 48 THEN 'Manoj Mehta'
WHEN 49 THEN 'Nitin Kumar'
WHEN 50 THEN 'Karan Joshi'

WHEN 51 THEN 'Rahul Sharma'
WHEN 52 THEN 'Pankaj Verma'
WHEN 53 THEN 'Mohit Gupta'
WHEN 54 THEN 'Sanjay Patel'
WHEN 55 THEN 'Ashish Jain'
WHEN 56 THEN 'Ramesh Gupta'
WHEN 57 THEN 'Lokesh Sharma'
WHEN 58 THEN 'Abhishek Singh'
WHEN 59 THEN 'Praveen Mehta'
WHEN 60 THEN 'Raj Kumar'

WHEN 61 THEN 'Sunil Yadav'
WHEN 62 THEN 'Mukesh Sharma'
WHEN 63 THEN 'Dinesh Verma'
WHEN 64 THEN 'Ravi Gupta'
WHEN 65 THEN 'Gaurav Jain'
WHEN 66 THEN 'Harish Patel'
WHEN 67 THEN 'Sachin Sharma'
WHEN 68 THEN 'Ajay Verma'
WHEN 69 THEN 'Naveen Gupta'
WHEN 70 THEN 'Vivek Singh'

ELSE Contact_Person
END
WHERE Supplier_Id BETWEEN 41 AND 70;

UPDATE Suppliers
SET Supplier_Name =
CASE Supplier_Id

WHEN 71 THEN 'Apex Distribution'
WHEN 72 THEN 'Sunrise Traders'
WHEN 73 THEN 'Shree Ram Agencies'
WHEN 74 THEN 'Metro Food Suppliers'
WHEN 75 THEN 'Global FMCG'
WHEN 76 THEN 'City Wholesale'
WHEN 77 THEN 'FoodLink Distributors'
WHEN 78 THEN 'Classic Enterprises'
WHEN 79 THEN 'JMD Traders'
WHEN 80 THEN 'Golden Agencies'

WHEN 81 THEN 'Maa Durga Distributors'
WHEN 82 THEN 'Hari Om Traders'
WHEN 83 THEN 'Shivam Enterprises'
WHEN 84 THEN 'Sai Kripa Agencies'
WHEN 85 THEN 'Anand Distributors'
WHEN 86 THEN 'Modern Wholesale'
WHEN 87 THEN 'Supreme FMCG'
WHEN 88 THEN 'Reliable Traders'
WHEN 89 THEN 'Excellent Agencies'
WHEN 90 THEN 'Choice Distributors'

WHEN 91 THEN 'Vinay Traders'
WHEN 92 THEN 'Akash Enterprises'
WHEN 93 THEN 'Bright Wholesale'
WHEN 94 THEN 'Perfect Agencies'
WHEN 95 THEN 'Express Distributors'
WHEN 96 THEN 'Indian FMCG Supply'
WHEN 97 THEN 'Rajdhani Traders'
WHEN 98 THEN 'Fresh Choice Agencies'
WHEN 99 THEN 'Blue Star Distributors'
WHEN 100 THEN 'Elite Wholesale'

ELSE Supplier_Name
END
WHERE Supplier_Id BETWEEN 71 AND 100;

UPDATE Suppliers
SET Contact_Person =
CASE Supplier_Id

WHEN 71 THEN 'Rajat Sharma'
WHEN 72 THEN 'Mohit Verma'
WHEN 73 THEN 'Vivek Gupta'
WHEN 74 THEN 'Akash Singh'
WHEN 75 THEN 'Nitin Sharma'
WHEN 76 THEN 'Rohit Agarwal'
WHEN 77 THEN 'Ankit Verma'
WHEN 78 THEN 'Saurabh Jain'
WHEN 79 THEN 'Kapil Sharma'
WHEN 80 THEN 'Yogesh Gupta'

WHEN 81 THEN 'Manish Patel'
WHEN 82 THEN 'Rakesh Sharma'
WHEN 83 THEN 'Abhinav Singh'
WHEN 84 THEN 'Harsh Verma'
WHEN 85 THEN 'Puneet Jain'
WHEN 86 THEN 'Rajiv Gupta'
WHEN 87 THEN 'Lokendra Sharma'
WHEN 88 THEN 'Sumit Verma'
WHEN 89 THEN 'Hemant Patel'
WHEN 90 THEN 'Naresh Singh'

WHEN 91 THEN 'Girish Sharma'
WHEN 92 THEN 'Bhavesh Jain'
WHEN 93 THEN 'Tarun Gupta'
WHEN 94 THEN 'Aakash Verma'
WHEN 95 THEN 'Dharmendra Singh'
WHEN 96 THEN 'Sachin Agarwal'
WHEN 97 THEN 'Kailash Sharma'
WHEN 98 THEN 'Mahesh Gupta'
WHEN 99 THEN 'Rohit Verma'
WHEN 100 THEN 'Prakash Sharma'

ELSE Contact_Person
END
WHERE Supplier_Id BETWEEN 71 AND 100;


-- ==========================================
-- Supplier Names Update
-- Purpose : Replace Dummy Supplier Names with Realistic Supplier Names
-- ==========================================

UPDATE Suppliers
SET Supplier_Name =
CASE Supplier_Id

WHEN 101 THEN 'Shree Balaji FMCG'
WHEN 102 THEN 'Om Sai Distributors'
WHEN 103 THEN 'National Food Supply'
WHEN 104 THEN 'Mahavir Agencies'
WHEN 105 THEN 'Jai Bharat Traders'
WHEN 106 THEN 'Universal Distributors'
WHEN 107 THEN 'Maa Laxmi Enterprises'
WHEN 108 THEN 'Shivam Food Products'
WHEN 109 THEN 'Arihant Trading Co.'
WHEN 110 THEN 'Shree Krishna Distributors'

WHEN 111 THEN 'Vinayak Wholesale'
WHEN 112 THEN 'Shakti Enterprises'
WHEN 113 THEN 'Royal Food Agencies'
WHEN 114 THEN 'Prime Distribution'
WHEN 115 THEN 'City Choice Traders'
WHEN 116 THEN 'Reliable Enterprises'
WHEN 117 THEN 'Metro FMCG'
WHEN 118 THEN 'Good Choice Agencies'
WHEN 119 THEN 'A One Traders'
WHEN 120 THEN 'Best Value Distributors'

WHEN 121 THEN 'Global Food Link'
WHEN 122 THEN 'Food Basket Supply'
WHEN 123 THEN 'Daily Fresh Agencies'
WHEN 124 THEN 'Supreme Distribution'
WHEN 125 THEN 'Annapurna Wholesale'
WHEN 126 THEN 'Green Valley Traders'
WHEN 127 THEN 'Bright Star Agencies'
WHEN 128 THEN 'Indian Grocery Supply'
WHEN 129 THEN 'Modern Trade Solutions'
WHEN 130 THEN 'Choice Wholesale'

WHEN 131 THEN 'Fresh India Traders'
WHEN 132 THEN 'Satyam Enterprises'
WHEN 133 THEN 'Galaxy Distributors'
WHEN 134 THEN 'Future Retail Supply'
WHEN 135 THEN 'Express Food Traders'
WHEN 136 THEN 'Sunshine Agencies'
WHEN 137 THEN 'Max Wholesale'
WHEN 138 THEN 'Shree Nath Enterprises'
WHEN 139 THEN 'Quality Distribution'
WHEN 140 THEN 'Happy Mart Supply'

WHEN 141 THEN 'Bharat Distributors'
WHEN 142 THEN 'Fresh Choice Traders'
WHEN 143 THEN 'Elite Food Supply'
WHEN 144 THEN 'Super Choice Agencies'
WHEN 145 THEN 'Golden Retail Supply'
WHEN 146 THEN 'Value Mart Distributors'
WHEN 147 THEN 'King Food Traders'
WHEN 148 THEN 'Star Wholesale'
WHEN 149 THEN 'Smart Retail Supply'
WHEN 150 THEN 'Perfect Distribution'

ELSE Supplier_Name
END
WHERE Supplier_Id BETWEEN 101 AND 150;



UPDATE Suppliers
SET Contact_Person =
CASE Supplier_Id

WHEN 101 THEN 'Rajesh Gupta'
WHEN 102 THEN 'Amit Sharma'
WHEN 103 THEN 'Vikas Verma'
WHEN 104 THEN 'Rakesh Jain'
WHEN 105 THEN 'Deepak Patel'
WHEN 106 THEN 'Anil Sharma'
WHEN 107 THEN 'Mohit Gupta'
WHEN 108 THEN 'Nitin Verma'
WHEN 109 THEN 'Sandeep Singh'
WHEN 110 THEN 'Rohit Sharma'

WHEN 111 THEN 'Ajay Kumar'
WHEN 112 THEN 'Mukesh Jain'
WHEN 113 THEN 'Sachin Verma'
WHEN 114 THEN 'Praveen Gupta'
WHEN 115 THEN 'Abhishek Sharma'
WHEN 116 THEN 'Dinesh Patel'
WHEN 117 THEN 'Lokesh Jain'
WHEN 118 THEN 'Harish Sharma'
WHEN 119 THEN 'Vivek Gupta'
WHEN 120 THEN 'Tarun Verma'

WHEN 121 THEN 'Sunil Singh'
WHEN 122 THEN 'Raj Kumar'
WHEN 123 THEN 'Pankaj Sharma'
WHEN 124 THEN 'Naresh Gupta'
WHEN 125 THEN 'Ashish Verma'
WHEN 126 THEN 'Gaurav Jain'
WHEN 127 THEN 'Yogesh Sharma'
WHEN 128 THEN 'Hemant Gupta'
WHEN 129 THEN 'Manoj Verma'
WHEN 130 THEN 'Kapil Singh'

WHEN 131 THEN 'Karan Sharma'
WHEN 132 THEN 'Ravi Jain'
WHEN 133 THEN 'Bhavesh Gupta'
WHEN 134 THEN 'Mahesh Verma'
WHEN 135 THEN 'Suresh Sharma'
WHEN 136 THEN 'Ankit Gupta'
WHEN 137 THEN 'Prakash Jain'
WHEN 138 THEN 'Naveen Sharma'
WHEN 139 THEN 'Girish Verma'
WHEN 140 THEN 'Dharmendra Gupta'

WHEN 141 THEN 'Rahul Singh'
WHEN 142 THEN 'Aakash Sharma'
WHEN 143 THEN 'Vijay Patel'
WHEN 144 THEN 'Ramesh Gupta'
WHEN 145 THEN 'Puneet Jain'
WHEN 146 THEN 'Rajiv Sharma'
WHEN 147 THEN 'Harsh Verma'
WHEN 148 THEN 'Kailash Gupta'
WHEN 149 THEN 'Arun Sharma'
WHEN 150 THEN 'Nikhil Jain'

ELSE Contact_Person
END
WHERE Supplier_Id BETWEEN 101 AND 150;

UPDATE Suppliers
SET Supplier_Name='Reliance Retail Supply',
Contact_Person='Sanjay Kapoor'
WHERE Supplier_Id=151;

UPDATE Suppliers
SET Supplier_Name='Adani Wilmar Distribution',
Contact_Person='Rakesh Sharma'
WHERE Supplier_Id=152;

UPDATE Suppliers
SET Supplier_Name='V-Mart Wholesale',
Contact_Person='Anil Verma'
WHERE Supplier_Id=153;

UPDATE Suppliers
SET Supplier_Name='Metro Cash & Carry',
Contact_Person='Deepak Gupta'
WHERE Supplier_Id=154;

UPDATE Suppliers
SET Supplier_Name='Big Basket Supply',
Contact_Person='Rahul Jain'
WHERE Supplier_Id=155;

UPDATE Suppliers
SET Supplier_Name='DMart Distribution',
Contact_Person='Mukesh Agarwal'
WHERE Supplier_Id=156;

UPDATE Suppliers
SET Supplier_Name='Spencer Wholesale',
Contact_Person='Ravi Mehta'
WHERE Supplier_Id=157;

UPDATE Suppliers
SET Supplier_Name='Reliance Fresh Supply',
Contact_Person='Vikas Singh'
WHERE Supplier_Id=158;

UPDATE Suppliers
SET Supplier_Name='Easyday Distribution',
Contact_Person='Mohit Sharma'
WHERE Supplier_Id=159;

UPDATE Suppliers
SET Supplier_Name='More Retail Supply',
Contact_Person='Nitin Patel'
WHERE Supplier_Id=160;

UPDATE Suppliers
SET Supplier_Name='Smart Bazaar Supply',
Contact_Person='Ajay Verma'
WHERE Supplier_Id=161;

UPDATE Suppliers
SET Supplier_Name='Best Price Wholesale',
Contact_Person='Suresh Kumar'
WHERE Supplier_Id=162;

UPDATE Suppliers
SET Supplier_Name='Grofers Supply Chain',
Contact_Person='Amit Gupta'
WHERE Supplier_Id=163;

UPDATE Suppliers
SET Supplier_Name='Nature Basket Supply',
Contact_Person='Prakash Jain'
WHERE Supplier_Id=164;

UPDATE Suppliers
SET Supplier_Name='Daily Fresh Distribution',
Contact_Person='Rohit Singh'
WHERE Supplier_Id=165;

UPDATE Suppliers
SET Supplier_Name='Prime Retail Suppliers',
Contact_Person='Harish Verma'
WHERE Supplier_Id=166;

UPDATE Suppliers
SET Supplier_Name='Value Plus Distribution',
Contact_Person='Naresh Gupta'
WHERE Supplier_Id=167;

UPDATE Suppliers
SET Supplier_Name='Shree Ganesh FMCG',
Contact_Person='Pankaj Sharma'
WHERE Supplier_Id=168;

UPDATE Suppliers
SET Supplier_Name='Annapurna Food Supply',
Contact_Person='Abhishek Patel'
WHERE Supplier_Id=169;

UPDATE Suppliers
SET Supplier_Name='Golden Retail Distribution',
Contact_Person='Kapil Jain'
WHERE Supplier_Id=170;

UPDATE Suppliers
SET Supplier_Name='Universal Food Suppliers',
Contact_Person='Sunil Sharma'
WHERE Supplier_Id=171;


SELECT Supplier_Id,
Supplier_Name,
Contact_Person,
City,
State
FROM Suppliers
ORDER BY Supplier_Id;


UPDATE Suppliers
SET
Supplier_Name = CASE Supplier_Id
WHEN 151 THEN 'Reliance Retail Supply'
WHEN 152 THEN 'Adani Wilmar Distribution'
WHEN 153 THEN 'V-Mart Wholesale'
WHEN 154 THEN 'Metro Cash & Carry'
WHEN 155 THEN 'BigBasket Supply'
WHEN 156 THEN 'DMart Distribution'
WHEN 157 THEN 'Spencer Wholesale'
WHEN 158 THEN 'Reliance Fresh Supply'
WHEN 159 THEN 'Easyday Distribution'
WHEN 160 THEN 'More Retail Supply'
WHEN 161 THEN 'Smart Bazaar Supply'
WHEN 162 THEN 'Best Price Wholesale'
WHEN 163 THEN 'Nature Basket Supply'
WHEN 164 THEN 'Daily Fresh Distribution'
WHEN 165 THEN 'Prime Retail Suppliers'
WHEN 166 THEN 'Value Plus Distribution'
WHEN 167 THEN 'Shree Ganesh FMCG'
WHEN 168 THEN 'Annapurna Food Supply'
WHEN 169 THEN 'Golden Retail Distribution'
WHEN 170 THEN 'Universal Grocery Supply'
END,

Contact_Person = CASE Supplier_Id
WHEN 151 THEN 'Sanjay Kapoor'
WHEN 152 THEN 'Rakesh Sharma'
WHEN 153 THEN 'Anil Verma'
WHEN 154 THEN 'Deepak Gupta'
WHEN 155 THEN 'Rahul Jain'
WHEN 156 THEN 'Mukesh Agarwal'
WHEN 157 THEN 'Ravi Mehta'
WHEN 158 THEN 'Vikas Singh'
WHEN 159 THEN 'Mohit Sharma'
WHEN 160 THEN 'Nitin Patel'
WHEN 161 THEN 'Ajay Verma'
WHEN 162 THEN 'Suresh Kumar'
WHEN 163 THEN 'Prakash Jain'
WHEN 164 THEN 'Rohit Singh'
WHEN 165 THEN 'Harish Verma'
WHEN 166 THEN 'Naresh Gupta'
WHEN 167 THEN 'Pankaj Sharma'
WHEN 168 THEN 'Abhishek Patel'
WHEN 169 THEN 'Kapil Jain'
WHEN 170 THEN 'Rajesh Sharma'
END
WHERE Supplier_Id BETWEEN 151 AND 170;

-- ==========================================
-- Verification : Suppliers
-- Purpose      : Verify Updated Supplier Records
-- ==========================================

SELECT
    Supplier_Id,
    Supplier_Name,
    GST_Number,
    Contact_Person,
    City,
    State
FROM Suppliers
WHERE Supplier_Id BETWEEN 41 AND 150;

-- ==========================================
-- Data Cleaning : Warehouses
-- Purpose      : Update Warehouse Master Records with Realistic Details
-- ==========================================

UPDATE warehouses
SET
Warehouse_Name = CASE Warehouse_Id
WHEN 6 THEN 'Pune Distribution Center'
WHEN 7 THEN 'Hyderabad Logistics Hub'
WHEN 8 THEN 'Chennai South Warehouse'
WHEN 9 THEN 'Bengaluru Tech Warehouse'
WHEN 10 THEN 'Kolkata East Warehouse'
WHEN 11 THEN 'Chandigarh Regional Warehouse'
WHEN 12 THEN 'Bhopal Central Warehouse'
WHEN 13 THEN 'Indore Distribution Center'
WHEN 14 THEN 'Surat Logistics Hub'
WHEN 15 THEN 'Nagpur Central Warehouse'
WHEN 16 THEN 'Kochi Warehouse'
WHEN 17 THEN 'Bhubaneswar Distribution Center'
WHEN 18 THEN 'Patna Regional Warehouse'
WHEN 19 THEN 'Ranchi Warehouse'
WHEN 20 THEN 'Guwahati Logistics Hub'
WHEN 21 THEN 'Ludhiana Warehouse'
WHEN 22 THEN 'Dehradun Regional Warehouse'
WHEN 23 THEN 'Raipur Distribution Center'
WHEN 24 THEN 'Visakhapatnam Warehouse'
WHEN 25 THEN 'Coimbatore Logistics Hub'
END,

City = CASE Warehouse_Id
WHEN 6 THEN 'Pune'
WHEN 7 THEN 'Hyderabad'
WHEN 8 THEN 'Chennai'
WHEN 9 THEN 'Bengaluru'
WHEN 10 THEN 'Kolkata'
WHEN 11 THEN 'Chandigarh'
WHEN 12 THEN 'Bhopal'
WHEN 13 THEN 'Indore'
WHEN 14 THEN 'Surat'
WHEN 15 THEN 'Nagpur'
WHEN 16 THEN 'Kochi'
WHEN 17 THEN 'Bhubaneswar'
WHEN 18 THEN 'Patna'
WHEN 19 THEN 'Ranchi'
WHEN 20 THEN 'Guwahati'
WHEN 21 THEN 'Ludhiana'
WHEN 22 THEN 'Dehradun'
WHEN 23 THEN 'Raipur'
WHEN 24 THEN 'Visakhapatnam'
WHEN 25 THEN 'Coimbatore'
END,

State = CASE Warehouse_Id
WHEN 6 THEN 'Maharashtra'
WHEN 7 THEN 'Telangana'
WHEN 8 THEN 'Tamil Nadu'
WHEN 9 THEN 'Karnataka'
WHEN 10 THEN 'West Bengal'
WHEN 11 THEN 'Chandigarh'
WHEN 12 THEN 'Madhya Pradesh'
WHEN 13 THEN 'Madhya Pradesh'
WHEN 14 THEN 'Gujarat'
WHEN 15 THEN 'Maharashtra'
WHEN 16 THEN 'Kerala'
WHEN 17 THEN 'Odisha'
WHEN 18 THEN 'Bihar'
WHEN 19 THEN 'Jharkhand'
WHEN 20 THEN 'Assam'
WHEN 21 THEN 'Punjab'
WHEN 22 THEN 'Uttarakhand'
WHEN 23 THEN 'Chhattisgarh'
WHEN 24 THEN 'Andhra Pradesh'
WHEN 25 THEN 'Tamil Nadu'
END,

Manager_Name = CASE Warehouse_Id
WHEN 6 THEN 'Rajesh Kulkarni'
WHEN 7 THEN 'Srinivas Rao'
WHEN 8 THEN 'Karthik Iyer'
WHEN 9 THEN 'Ramesh Gowda'
WHEN 10 THEN 'Subhash Roy'
WHEN 11 THEN 'Harpreet Singh'
WHEN 12 THEN 'Mahesh Sharma'
WHEN 13 THEN 'Vivek Jain'
WHEN 14 THEN 'Hitesh Patel'
WHEN 15 THEN 'Pravin Deshmukh'
WHEN 16 THEN 'Anil Nair'
WHEN 17 THEN 'Satyajit Das'
WHEN 18 THEN 'Manoj Kumar'
WHEN 19 THEN 'Sanjay Sinha'
WHEN 20 THEN 'Rakesh Bora'
WHEN 21 THEN 'Gurpreet Singh'
WHEN 22 THEN 'Amit Rawat'
WHEN 23 THEN 'Dinesh Verma'
WHEN 24 THEN 'Sai Krishna'
WHEN 25 THEN 'Prakash Kumar'
END

WHERE Warehouse_Id BETWEEN 6 AND 25;

-- ==========================================
-- Verification : Warehouses
-- Purpose      : Verify Updated Warehouse Records
-- ==========================================

SELECT
    Warehouse_Id,
    Warehouse_Code,
    Warehouse_Name,
    City,
    State,
    Warehouse_Type
FROM Warehouses;







