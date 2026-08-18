	-- =========================================================
	-- Project  : Supply Chain & Inventory Management System
	-- Code     : SCIMS
	-- Database : SCIMS
	-- Developer: Monika Goyal
	-- Version  : 1.0
	-- File     : 01_Database_Setup.sql
	-- Purpose  : Create Database and Master Tables
	-- =========================================================

	-- ==========================================
	-- Step 1 : Drop Existing Database
	-- ==========================================
	DROP DATABASE IF EXISTS SCIMS;

	-- ==========================================
	-- Step 2 : Create Database
	-- ==========================================
	CREATE DATABASE SCIMS;

	-- ==========================================
	-- Step 3 : Use Database
	-- ==========================================
	USE SCIMS;

	-- ==========================================
	-- Step 4 : Create Tables 
	-- ==========================================


	-- ==========================================
	-- Table 1 : Warehouses
	-- Purpose : Store Warehouse Information
	-- ==========================================

	CREATE TABLE warehouses (
		warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
		warehouse_code VARCHAR(10) NOT NULL UNIQUE,
		warehouse_name VARCHAR(100) NOT NULL,
		city VARCHAR(50) NOT NULL,
		state VARCHAR(50) NOT NULL,
		warehouse_type ENUM('Central','Regional','Local') NOT NULL,
		storage_capacity INT NOT NULL CHECK(storage_capacity > 0),
		current_capacity INT DEFAULT 0,
		manager_name VARCHAR(100),
		contact_no VARCHAR(15),
		email VARCHAR(100),
		opening_date DATE,
		status ENUM('Active','Inactive') DEFAULT 'Active',
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		ON UPDATE CURRENT_TIMESTAMP
	);

	-- ==========================================
	-- Table 2 : Stores
	-- Purpose : Store Retail Store Information
	-- ==========================================

	Create Table Stores (
		Store_Id Int Auto_Increment Primary Key,
		Warehouse_Id Int Not Null,
		Store_Code Varchar(10) Not Null Unique,
		Store_Name Varchar(100) Not Null,
		City Varchar(50) Not Null,
		State Varchar(50) Not Null,
		Address Varchar(200),
		Manager_Name Varchar(100),
		Contact_No Varchar(15),
		Opening_Date Date,
		Status Enum('Active','Inactive') Default 'Active',
		Created_At Timestamp Default Current_Timestamp,
		Updated_At Timestamp Default Current_Timestamp
		On Update Current_Timestamp,
		Constraint Fk_Store_Warehouse
		Foreign Key (Warehouse_Id) References Warehouses(Warehouse_Id)
	);

	-- ==========================================
	-- Table 3 : Suppliers
	-- Purpose : Store Supplier Information
	-- ==========================================

	Create Table Suppliers (
		Supplier_Id Int Auto_Increment Primary Key,
		Supplier_Code Varchar(10) Not Null Unique,
		Supplier_Name Varchar(150) Not Null,
		Gst_Number Varchar(20) Unique,
		Contact_Person Varchar(100),
		Phone Varchar(15),
		Email Varchar(100),
		City Varchar(50),
		State Varchar(50),
		Supplier_Rating Decimal(3,2) Default 5.00,
		Payment_Terms Varchar(50),
		Status Enum('Active','Inactive') Default 'Active',
		Created_At Timestamp Default Current_Timestamp,
		Updated_At Timestamp Default Current_Timestamp
		On Update Current_Timestamp
	);

	-- ==========================================
	-- Table 4 : Categories
	-- Purpose : Store Product Category Information
	-- ==========================================

	Create Table Categories (
		Category_Id Int Auto_Increment Primary Key,
		Category_Name Varchar(100) Not Null Unique,
		Description Varchar(255),
		Status Enum('Active','Inactive') Default 'Active',
		Created_At Timestamp Default Current_Timestamp
	);

	-- ==========================================
	-- Table 5 : Products
	-- Purpose : Store Product Master Information
	-- ==========================================
	 
	 Create Table Products (
		Product_Id Int Auto_Increment Primary Key,
		Product_Code Varchar(20) Not Null Unique,
		Product_Name Varchar(150) Not Null,
		Category_Id Int Not Null,
		Supplier_Id Int Not Null,
		Brand Varchar(100),
		Unit Varchar(20),
		Weight Decimal(10,2),
		Cost_Price Decimal(10,2) Not Null,
		Selling_Price Decimal(10,2) Not Null,
		Reorder_Level Int Default 100,
		Shelf_Life_Days Int,
		Status Enum('Active','Inactive') Default 'Active',
		Created_At Timestamp Default Current_Timestamp,
		Updated_At Timestamp Default Current_Timestamp
		On Update Current_Timestamp,
		Constraint Fk_Product_Category
		Foreign Key(Category_Id) References Categories(Category_Id),
		Constraint Fk_Product_Supplier
		Foreign Key(Supplier_Id) References Suppliers(Supplier_Id)
	); 


	-- ==========================================
	-- Table 6 : Employees
	-- Purpose : Store Employee Information
	-- ==========================================
	 
	 Create Table Employees (
		Employee_Id Int Auto_Increment Primary Key,
		Warehouse_Id Int Not Null,
		Employee_Code Varchar(20) Unique,
		First_Name Varchar(50),
		Last_Name Varchar(50),
		Gender Enum('Male','Female','Other'),
		Designation Varchar(100),
		Department Varchar(100),
		Salary Decimal(12,2),
		Phone Varchar(15),
		Email Varchar(100),
		Joining_Date Date,
		Status Enum('Active','Inactive') Default 'Active',
		Created_At Timestamp Default Current_Timestamp,
		Updated_At Timestamp Default Current_Timestamp
		On Update Current_Timestamp,
		Constraint Fk_Employee_Warehouse
		Foreign Key(Warehouse_Id) References Warehouses(Warehouse_Id)
	);

	-- ==========================================
	-- Table 7 : Inventory
	-- Purpose : Store Warehouse Inventory Details
	-- ==========================================
	 
	 Create Table Inventory (
		Inventory_Id Int Auto_Increment Primary Key,
		Warehouse_Id Int Not Null,
		Product_Id Int Not Null,
		Available_Qty Int Not Null Default 0,
		Reserved_Qty Int Default 0,
		Damaged_Qty Int Default 0,
		Reorder_Level Int Not Null,
		Reorder_Quantity Int Not Null,
		Last_Stock_Update Datetime Default Current_Timestamp,
		Inventory_Status Enum('In Stock','Low Stock','Out Of Stock')Default 'In Stock',
		Created_At Timestamp Default Current_Timestamp,
		Updated_At Timestamp Default Current_Timestamp
		On Update Current_Timestamp,
		Constraint Fk_Inventory_Warehouse
		Foreign Key (Warehouse_Id) References Warehouses(Warehouse_Id),
		Constraint Fk_Inventory_Product
		Foreign Key (Product_Id) References Products(Product_Id),
		Constraint Uk_Inventory Unique(Warehouse_Id, Product_Id)
	);

	-- ==========================================
	-- Table 8 : Purchase_Orders
	-- Purpose : Store Purchase Order Information
	-- ==========================================

	 Create Table Purchase_Orders (
		Po_Id Int Auto_Increment Primary Key,
		Po_Number Varchar(20) Unique Not Null,
		Supplier_Id Int Not Null,
		Warehouse_Id Int Not Null,
		Order_Date Date Not Null,
		Expected_Delivery Date,
		Actual_Delivery Date,
		Total_Amount Decimal(15,2),
		Order_Status Enum('Pending','Approved','Shipped','Delivered','Cancelled') Default 'Pending',
		Payment_Status Enum('Pending','Paid') Default 'Pending',
		Created_At Timestamp Default Current_Timestamp,
		Foreign Key (Supplier_Id) References Suppliers(Supplier_Id),
		Foreign Key (Warehouse_Id) References Warehouses(Warehouse_Id)
	);


	-- ==========================================
	-- Table 9 : Purchase_Order_Items
	-- Purpose : Store Purchase Order Product Details
	-- ==========================================
													
	  Create Table Purchase_Order_Items (
		Po_Item_Id Int Auto_Increment Primary Key,
		Po_Id Int Not Null,
		Product_Id Int Not Null,
		Quantity Int Not Null,
		Unit_Price Decimal(10,2),
		Discount_Percent Decimal(5,2) Default 0,
		Tax_Percent Decimal(5,2) Default 18,
		Line_Total Decimal(15,2),
		Foreign Key (Po_Id) References Purchase_Orders(Po_Id),
		Foreign Key (Product_Id) References Products(Product_Id)
	);

	-- ==========================================
	-- Table 10 : Shipments
	-- Purpose : Store Shipment Information
	-- ==========================================

	Create Table Shipments (
		Shipment_Id Int Auto_Increment Primary Key,
		Po_Id Int Not Null,
		Shipment_Number Varchar(20) Unique,
		Dispatch_Date Date,
		Expected_Arrival Date,
		Arrival_Date Date,
		Transport_Mode Enum('Road','Rail','Air'),
		Vehicle_Number Varchar(20),
		Shipment_Status Enum('In Transit','Delivered','Delayed') Default 'In Transit',
		Created_At Timestamp Default Current_Timestamp,
		Foreign Key (Po_Id) References Purchase_Orders(Po_Id)
	);

	-- ==========================================
	-- Table 11 : Shipment_Tracking
	-- Purpose : Store Shipment Tracking History
	-- ==========================================

	Create Table Shipment_Tracking (
		Tracking_Id Int Auto_Increment Primary Key,
		Shipment_Id Int Not Null,
		Tracking_Datetime Datetime,
		Current_Location Varchar(100),
		Remarks Varchar(255),
		Shipment_Status Enum('In Transit','Delivered','Delayed'),
		Foreign Key (Shipment_Id) References Shipments(Shipment_Id)
	); 

	-- ==========================================
	-- Table 12 : Stock_Transfers
	-- Purpose : Store Warehouse Transfer Information
	-- ==========================================

	Create Table Stock_Transfers (
		Transfer_Id Int Auto_Increment Primary Key,
		Transfer_Number Varchar(20) Unique Not Null,
		From_Warehouse_Id Int Not Null,
		To_Warehouse_Id Int Not Null,
		Transfer_Date Date Not Null,
		Expected_Delivery Date,
		Received_Date Date,
		Transfer_Status Enum('Pending','In Transit','Received','Cancelled') Default 'Pending',
		Remarks Varchar(255),
		Created_At Timestamp Default Current_Timestamp,
		Constraint Fk_Transfer_From
		Foreign Key(From_Warehouse_Id) References Warehouses(Warehouse_Id),
		Constraint Fk_Transfer_To
		Foreign Key(To_Warehouse_Id) References Warehouses(Warehouse_Id)
	);

	-- ==========================================
	-- Table 13 : Transfer_Items
	-- Purpose : Store Stock Transfer Product Details
	-- ==========================================

	Create Table Transfer_Items (
		 Transfer_Item_Id Int Auto_Increment Primary Key,
		 Transfer_Id Int Not Null,
		 Product_Id Int Not Null,
		 Quantity Int Not Null,
		 Foreign Key(Transfer_Id) References Stock_Transfers(Transfer_Id),
		 Foreign Key(Product_Id) References Products(Product_Id)
	); 


	-- ==========================================
	-- Table 14 : Store_Orders
	-- Purpose : Store Orders Raised by Stores
	-- ==========================================

	Create Table Store_Orders (
		Store_Order_Id Int Auto_Increment Primary Key,
		Store_Id Int Not Null,
		Warehouse_Id Int Not Null,
		Order_Date Date,
		Required_Date Date,
		Delivered_Date Date,
		Order_Status Enum('Pending','Approved','Dispatched','Delivered','Cancelled') Default 'Pending',
		Created_At Timestamp Default Current_Timestamp,
		Foreign Key(Store_Id) References Stores(Store_Id),
		Foreign Key(Warehouse_Id) References Warehouses(Warehouse_Id)
	); 

	-- ==========================================
	-- Table 15 : Store_Order_Items
	-- Purpose : Store Store Order Product Details
	-- ==========================================

	Create Table Store_Order_Items (
		Order_Item_Id Int Auto_Increment Primary Key,
		Store_Order_Id Int Not Null,
		Product_Id Int Not Null,
		Quantity Int Not Null,
		Supplied_Quantity Int Default 0,
		Foreign Key(Store_Order_Id) References Store_Orders(Store_Order_Id),
		Foreign Key(Product_Id) References Products(Product_Id)
	);                                                  

	-- ==========================================
	-- Table 16 : Damaged_Stock
	-- Purpose : Store Damaged Product Information
	-- ==========================================

	Create Table Damaged_Stock (
		Damage_Id Int Auto_Increment Primary Key,
		Warehouse_Id Int Not Null,
		Product_Id Int Not Null,
		Damage_Date Date,
		Quantity Int,
		Damage_Reason Varchar(200),
		Action_Taken Varchar(100),
		Foreign Key(Warehouse_Id) References Warehouses(Warehouse_Id),
		Foreign Key(Product_Id) References Products(Product_Id)
	);

	-- ==========================================
	-- Table 17 : Inventory_Audit
	-- Purpose : Store Inventory Change History
	-- ==========================================

	Create Table Inventory_Audit (
		Audit_Id Int Auto_Increment Primary Key,
		Inventory_Id Int Not Null,
		Old_Quantity Int,
		New_Quantity Int,
		Changed_By Int,
		Change_Date Datetime Default Current_Timestamp,
		Remarks Varchar(255),
		Foreign Key(Inventory_Id) References Inventory(Inventory_Id),
		Foreign Key(Changed_By) References Employees(Employee_Id)
	);


	-- ==========================================
	-- Table 18 : Supplier_Performance
	-- Purpose : Store Supplier Performance Metrics
	-- ==========================================

	Create Table Supplier_Performance (
		Performance_Id Int Auto_Increment Primary Key,
		Supplier_Id Int Not Null,
		Performance_Month Date,
		Total_Orders Int,
		On_Time_Delivery_Percent Decimal(5,2),
		Average_Delay_Days Decimal(5,2),
		Supplier_Rating Decimal(3,2),
		Foreign Key(Supplier_Id) References Suppliers(Supplier_Id)
	);

	-- ==========================================
	-- Table 19 : Warehouse_Capacity
	-- Purpose : Store Warehouse Capacity Details
	-- ==========================================

	Create Table Warehouse_Capacity (
		Capacity_Id Int Auto_Increment Primary Key,
		Warehouse_Id Int Not Null,
		Total_Capacity Int,
		Used_Capacity Int,
		Available_Capacity Int,
		Recorded_Date Date,
		Foreign Key(Warehouse_Id) References Warehouses(Warehouse_Id)
	);


	-- ==========================================
	-- Table 20 : Users
	-- Purpose : Store User Login Information
	-- ==========================================

	Create Table Users (
		User_Id Int Auto_Increment Primary Key,
		Username Varchar(50) Unique,
		Password_Hash Varchar(255),
		Role Enum('Admin','Manager','Warehouse','Viewer'),
		Employee_Id Int,
		Status Enum('Active','Inactive') Default 'Active',
		Created_At Timestamp Default Current_Timestamp,
		Foreign Key(Employee_Id) References Employees(Employee_Id)
	);




