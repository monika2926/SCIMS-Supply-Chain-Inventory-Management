-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 09_SQL_Queries.sql
-- Purpose  : Business Analysis and Reporting Queries
-- ==========================================================

-- ==========================================
-- Query 1 : List All Active Products
-- Purpose : Display All Active Products
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Brand, Selling_Price, Status
	FROM products
	WHERE Status = 'Active';

-- ==========================================
-- Query 2 : List All Inactive Products
-- Purpose : Display All Inactive Products
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Brand, Selling_Price, Status
	FROM products
	WHERE Status = 'Inactive';
    
-- ==========================================
-- Query 3 : Products Below Reorder Level
-- Purpose : Display Products Below Reorder Level
-- ==========================================

SELECT
	i.Inventory_Id, p.Product_Code, p.Product_Name, w.Warehouse_Name, i.Available_Qty, i.Reorder_Level, i.Inventory_Status
	FROM inventory i

INNER JOIN products p
    ON i.Product_Id = p.Product_Id

INNER JOIN warehouses w
    ON i.Warehouse_Id = w.Warehouse_Id

WHERE i.Available_Qty <= i.Reorder_Level;

-- ==========================================
-- Query 4 : Products With Highest Selling Price
-- Purpose : Display Most Expensive Products
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Selling_Price
	FROM products
	WHERE Selling_Price =
(SELECT MAX(Selling_Price)
FROM products);


-- ==========================================
-- Query 5 : Products With Lowest Selling Price
-- Purpose : Display Cheapest Products
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Selling_Price
    FROM products
	WHERE Selling_Price =
(SELECT MIN(Selling_Price) FROM products);


-- ==========================================
-- Query 6 : Products Between a Price Range
-- Purpose : Display Products Within a Price Range
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Brand, Cost_Price, Selling_Price
	FROM products
	WHERE Selling_Price BETWEEN 100 AND 500
	ORDER BY Selling_Price;
    
-- ==========================================
-- Query 7 : Suppliers From a Specific State
-- Purpose : Display Suppliers From Rajasthan
-- ==========================================

SELECT
	Supplier_Id, Supplier_Code, Supplier_Name, City, State, Supplier_Rating, Status
	FROM suppliers
WHERE State = 'Rajasthan';

-- ==========================================
-- Query 8 : Warehouses in a Specific City
-- Purpose : Display Warehouses Located in Jaipur
-- ==========================================

SELECT
	Warehouse_Id, Warehouse_Code, Warehouse_Name, City, State, Warehouse_Type, Status
    FROM warehouses
	WHERE City = 'Jaipur';
    

-- ==========================================
-- Query 9 : Stores in a Specific State
-- Purpose : Display Stores Located in Rajasthan
-- ==========================================

SELECT
	Store_Id, Store_Code, Store_Name, City, State, Status
    FROM stores
	WHERE State = 'Rajasthan';
    


-- ==========================================
-- Query 10 : Employees Working in a Warehouse
-- Purpose : Display Employees Working in Warehouse 1
-- ==========================================

SELECT
	Employee_Id, Employee_Code, First_Name, Last_Name, Designation, Warehouse_Id, Status
	FROM employees
	WHERE Warehouse_Id = 1
	ORDER BY First_Name;
    

-- ==========================================
-- Query 11 : Users Created This Month
-- Purpose : Display Users Created In Current Month
-- ==========================================

SELECT
	User_Id, Username, Employee_Id, Created_At, Status
	FROM users
	WHERE MONTH(Created_At) = MONTH(CURRENT_DATE())
	AND YEAR(Created_At) = YEAR(CURRENT_DATE());
    
-- ==========================================
-- Query 12 : Products With NULL Weight
-- Purpose : Display Products Having Missing Weight Information
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Brand, Weight
	FROM products
	WHERE Weight IS NULL;
    
-- ==========================================
-- Query 13 : Active Suppliers
-- Purpose : Display All Active Suppliers
-- ==========================================

SELECT
	Supplier_Id, Supplier_Code, Supplier_Name, City, State, Supplier_Rating, Status
	FROM suppliers
	WHERE Status = 'Active';
    
-- ==========================================
-- Query 14 : Active Warehouses
-- Purpose : Display All Active Warehouses
-- ==========================================

SELECT
	Warehouse_Id, Warehouse_Code, Warehouse_Name, City, State, Warehouse_Type, Status
    FROM warehouses
	WHERE Status = 'Active';
    
-- ==========================================
-- Query 15 : Active Stores
-- Purpose : Display All Active Stores
-- ==========================================

SELECT
	Store_Id, Store_Code, Store_Name, City, State, Status
	FROM stores
	WHERE Status = 'Active';
    
-- ==========================================
-- Query 16 : Total Number of Products
-- Purpose : Count Total Products Available
-- ==========================================

SELECT
COUNT(*) AS Total_Products
FROM products;

-- ==========================================
-- Query 17 : Total Suppliers
-- Purpose : Count Total Suppliers
-- ==========================================

SELECT
COUNT(*) AS Total_Suppliers
FROM suppliers;

-- ==========================================
-- Query 18 : Total Warehouses
-- Purpose : Count Total Warehouses
-- ==========================================

SELECT
COUNT(*) AS Total_Warehouses
FROM warehouses;

-- ==========================================
-- Query 19 : Total Stores
-- Purpose : Count Total Stores
-- ==========================================

SELECT
COUNT(*) AS Total_Stores
FROM stores;

-- ==========================================
-- Query 20 : Total Employees
-- Purpose : Count Total Employees
-- ==========================================

SELECT
COUNT(*) AS Total_Employees
FROM employees;

-- ==========================================
-- Query 21 : Total Inventory Quantity
-- Purpose : Calculate Total Available Inventory
-- ==========================================

SELECT
SUM(Available_Qty) AS Total_Inventory_Quantity
FROM inventory;

-- ==========================================
-- Query 22 : Average Product Price
-- Purpose : Calculate Average Selling Price
-- ==========================================

SELECT
ROUND(AVG(Selling_Price),2) AS Average_Product_Price
FROM products;

-- ==========================================
-- Query 23 : Highest Product Price
-- Purpose : Find Maximum Selling Price Product
-- ==========================================

SELECT
	Product_Id,	Product_Code, Product_Name, Selling_Price
    FROM products
	WHERE Selling_Price =
(SELECT MAX(Selling_Price)FROM products);


-- ==========================================
-- Query 24 : Lowest Product Price
-- Purpose : Find Minimum Selling Price Product
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Selling_Price
	FROM products
	WHERE Selling_Price =(
    SELECT MIN(Selling_Price)
    FROM products); 
    
-- ==========================================
-- Query 25 : Average Supplier Rating
-- Purpose : Calculate Average Supplier Rating
-- ==========================================

SELECT
	ROUND(AVG(Supplier_Rating),2) AS Average_Supplier_Rating
	FROM suppliers;
    
    
-- ==========================================
-- Query 26 : Highest Supplier Rating
-- Purpose : Find Supplier With Highest Rating
-- ==========================================

SELECT
	Supplier_Id, Supplier_Name, Supplier_Rating
	FROM suppliers
	WHERE Supplier_Rating =
(SELECT MAX(Supplier_Rating) FROM suppliers);

-- ==========================================
-- Query 27 : Lowest Supplier Rating
-- Purpose : Find Supplier With Lowest Rating
-- ==========================================

SELECT
	Supplier_Id, Supplier_Name, Supplier_Rating
	FROM suppliers
	WHERE Supplier_Rating =
(SELECT MIN(Supplier_Rating)FROM suppliers);

-- ==========================================
-- Query 28 : Total Warehouse Capacity
-- Purpose : Calculate Total Storage Capacity
-- ==========================================

SELECT
	SUM(Storage_Capacity) AS Total_Warehouse_Capacity
	FROM warehouses;
    
-- ==========================================
-- Query 29 : Total Damaged Stock
-- Purpose : Calculate Total Damaged Inventory
-- ==========================================

SELECT
	SUM(Damaged_Qty) AS Total_Damaged_Stock
	FROM inventory;
    
    
-- ==========================================
-- Query 30 : Average Warehouse Capacity
-- Purpose : Calculate Average Storage Capacity
-- ==========================================

SELECT
	ROUND(AVG(Storage_Capacity),2) AS Average_Warehouse_Capacity
	FROM warehouses;
    
    
-- ==========================================
-- Query 31 : Products Per Category
-- Purpose : Count Products Category Wise
-- ==========================================

SELECT
	c.Category_Name,
    COUNT(p.Product_Id) AS Total_Products
	FROM categories c
	LEFT JOIN products p
    ON c.Category_Id = p.Category_Id
	GROUP BY c.Category_Name;
    
-- ==========================================
-- Query 32 : Products Per Supplier
-- Purpose : Count Products Supplier Wise
-- ==========================================

SELECT
	s.Supplier_Name,
    COUNT(p.Product_Id) AS Total_Products
	FROM suppliers s
	LEFT JOIN products p
    ON s.Supplier_Id = p.Supplier_Id
	GROUP BY s.Supplier_Name;

-- ==========================================
-- Query 33 : Stores Per City
-- Purpose : Count Stores City Wise
-- ==========================================

SELECT
	City,
    COUNT(Store_Id) AS Total_Stores
	FROM stores
	GROUP BY City
	ORDER BY Total_Stores DESC;
    
-- ==========================================
-- Query 34 : Warehouses Per State
-- Purpose : Count Warehouses State Wise
-- ==========================================

SELECT
	State, COUNT(Warehouse_Id) AS Total_Warehouses
	FROM warehouses
	GROUP BY State
	ORDER BY Total_Warehouses DESC;
    
-- ==========================================
-- Query 35 : Employees Per Warehouse
-- Purpose : Count Employees Warehouse Wise
-- ==========================================

SELECT
	w.Warehouse_Name,
    COUNT(e.Employee_Id) AS Total_Employees
	FROM warehouses w
	LEFT JOIN employees e
    ON w.Warehouse_Id = e.Warehouse_Id
	GROUP BY w.Warehouse_Name;
    

-- ==========================================
-- Query 36 : Inventory Per Warehouse
-- Purpose : Calculate Stock Warehouse Wise
-- ==========================================

SELECT
	w.Warehouse_Name,
    SUM(i.Available_Qty) AS Total_Inventory
	FROM warehouses w
	INNER JOIN inventory i
    ON w.Warehouse_Id = i.Warehouse_Id
	GROUP BY w.Warehouse_Name;
    

-- ==========================================
-- Query 37 : Inventory Per Store
-- Purpose : Calculate Store Wise Inventory
-- ==========================================

SELECT
    s.Store_Name,
    SUM(soi.Supplied_Quantity) AS Total_Inventory
	FROM stores s
INNER JOIN store_orders so
ON s.Store_Id = so.Store_Id

INNER JOIN store_order_items soi
ON so.Store_Order_Id = soi.Store_Order_Id

GROUP BY s.Store_Name;

-- ==========================================
-- Query 38 : Damaged Stock Per Warehouse
-- Purpose : Calculate Damaged Stock Warehouse Wise
-- ==========================================

SELECT
	w.Warehouse_Name,
    SUM(i.Damaged_Qty) AS Total_Damaged_Stock
	FROM warehouses w
	INNER JOIN inventory i
	ON w.Warehouse_Id = i.Warehouse_Id
	GROUP BY w.Warehouse_Name;
    
-- ==========================================
-- Query 39 : Purchase Orders Per Supplier
-- Purpose : Count Purchase Orders Supplier Wise
-- ==========================================

SELECT
	s.Supplier_Name,
    COUNT(po.Po_Id) AS Total_Purchase_Orders
	FROM suppliers s
	LEFT JOIN purchase_orders po
    ON s.Supplier_Id = po.Supplier_Id
	GROUP BY s.Supplier_Name;
    
-- ==========================================
-- Query 40 : Store Orders Per Store
-- Purpose : Count Orders Store Wise
-- ==========================================

SELECT
	s.Store_Name,
    COUNT(so.Store_Order_Id) AS Total_Orders
	FROM stores s
	LEFT JOIN store_orders so
    ON s.Store_Id = so.Store_Id
	GROUP BY s.Store_Name;
    
-- ==========================================
-- Query 41 : Shipments Per Warehouse
-- Purpose : Count Shipments Warehouse Wise
-- ==========================================

SELECT
	w.Warehouse_Name,
    COUNT(sh.Shipment_Id) AS Total_Shipments
    FROM warehouses w
	INNER JOIN purchase_orders po
	ON w.Warehouse_Id = po.Warehouse_Id
	INNER JOIN shipments sh
	ON po.Po_Id = sh.Po_Id
	GROUP BY w.Warehouse_Name;
    
-- ==========================================
-- Query 42 : Categories Having More Than 100 Products
-- Purpose : Find High Product Categories
-- ==========================================

SELECT
	c.Category_Name,
    COUNT(p.Product_Id) AS Total_Products
	FROM categories c
	INNER JOIN products p
	ON c.Category_Id = p.Category_Id
	GROUP BY c.Category_Name
	HAVING COUNT(p.Product_Id) > 100;
    

-- ==========================================
-- Query 43 : Suppliers Supplying More Than 20 Products
-- Purpose : Find Major Suppliers
-- ==========================================

SELECT
	s.Supplier_Name,
    COUNT(p.Product_Id) AS Total_Products
	FROM suppliers s
	INNER JOIN products p
	ON s.Supplier_Id = p.Supplier_Id
	GROUP BY s.Supplier_Name
	HAVING COUNT(p.Product_Id) > 20;
    

-- ==========================================
-- Query 44 : Warehouses Having More Than 5000 Inventory
-- Purpose : Find High Stock Warehouses
-- ==========================================

SELECT
	w.Warehouse_Name,
    SUM(i.Available_Qty) AS Total_Inventory
	FROM warehouses w
	INNER JOIN inventory i
	ON w.Warehouse_Id = i.Warehouse_Id
	GROUP BY w.Warehouse_Name
	HAVING SUM(i.Available_Qty) > 5000;
    
    
-- ==========================================
-- Query 45 : Stores Having More Than 1000 Inventory
-- Purpose : Find High Inventory Stores
-- ==========================================

SELECT
	s.Store_Name,
	SUM(soi.Supplied_Quantity) AS Total_Inventory
	FROM stores s
	INNER JOIN store_orders so
	ON s.Store_Id = so.Store_Id
	INNER JOIN store_order_items soi
	ON so.Store_Order_Id = soi.Store_Order_Id
	GROUP BY s.Store_Name
	HAVING SUM(soi.Supplied_Quantity) > 1000;
    
-- ==========================================
-- Query 46 : Product with Category
-- Purpose : Display Products with Category Details
-- ==========================================

SELECT
	p.Product_Code, p.Product_Name, c.Category_Name
	FROM products p
	INNER JOIN categories c
    ON p.Category_Id = c.Category_Id;
    
-- ==========================================
-- Query 47 : Product with Supplier
-- Purpose : Display Products with Supplier Details
-- ==========================================

SELECT
	p.Product_Code, p.Product_Name, s.Supplier_Name, s.Supplier_Rating
	FROM products p
	INNER JOIN suppliers s
    ON p.Supplier_Id = s.Supplier_Id;
    
-- ==========================================
-- Query 48 : Purchase Order Report
-- Purpose : Display Purchase Order Details
-- ==========================================

SELECT
	po.Po_Number, s.Supplier_Name,
    w.Warehouse_Name,
    po.Total_Amount,
    po.Order_Status
	FROM purchase_orders po
	INNER JOIN suppliers s
    ON po.Supplier_Id = s.Supplier_Id
	INNER JOIN warehouses w
    ON po.Warehouse_Id = w.Warehouse_Id;
    

-- ==========================================
-- Query 49 : Inventory Report
-- Purpose : Display Inventory with Product Details
-- ==========================================

SELECT
	p.Product_Name, w.Warehouse_Name, i.Available_Qty, i.Damaged_Qty
	FROM inventory i
	INNER JOIN products p
    ON i.Product_Id = p.Product_Id
	INNER JOIN warehouses w
    ON i.Warehouse_Id = w.Warehouse_Id;
    
-- ==========================================
-- Query 51 : Suppliers with Products
-- Purpose : Display All Suppliers Including Those Without Products
-- ==========================================

SELECT
	s.Supplier_Name, p.Product_Code, p.Product_Name, p.Brand
	FROM suppliers s
	LEFT JOIN products p
    ON s.Supplier_Id = p.Supplier_Id;
    

-- ==========================================
-- Query 52 : Categories with Products
-- Purpose : Display All Categories Including Empty Categories
-- ==========================================

SELECT
	c.Category_Name, p.Product_Code, p.Product_Name
	FROM categories c
	LEFT JOIN products p
    ON c.Category_Id = p.Category_Id;
    
-- ==========================================
-- Query 53 : Warehouses with Inventory
-- Purpose : Display All Warehouses Including Empty Warehouses
-- ==========================================

SELECT
	w.Warehouse_Name, p.Product_Name, i.Available_Qty
    FROM warehouses w
	LEFT JOIN inventory i
    ON w.Warehouse_Id = i.Warehouse_Id
	LEFT JOIN products p
    ON i.Product_Id = p.Product_Id;


-- ==========================================
-- Query 54 : Stores with Orders
-- Purpose : Display All Stores Including Those Without Orders
-- ==========================================

SELECT
	s.Store_Name, so.Store_Order_Id, so.Order_Date, so.Order_Status
	FROM stores s
	LEFT JOIN store_orders so
    ON s.Store_Id = so.Store_Id;
    
-- ==========================================
-- Query 55 : Purchase Orders with Shipments
-- Purpose : Display Purchase Orders Including Pending Shipments
-- ==========================================

SELECT
	po.Po_Number, sh.Shipment_Number, sh.Dispatch_Date, sh.Shipment_Status
	FROM purchase_orders po
	LEFT JOIN shipments sh
	ON po.Po_Id = sh.Po_Id;
    
-- ==========================================
-- Query 56 : Employees with Purchase Orders
-- Purpose : Display Employees Including Those Without Purchase Orders
-- ==========================================

SELECT
	CONCAT(e.First_Name,' ',e.Last_Name) AS Employee_Name, po.Po_Number, po.Total_Amount
	FROM employees e
	LEFT JOIN purchase_orders po
	ON e.Employee_Id = po.Employee_Id;
    

-- ==========================================
-- Query 57 : Warehouses with Transfers
-- Purpose : Display All Warehouses Including Those Without Transfers
-- ==========================================

SELECT
	w.Warehouse_Name, st.Transfer_Number, st.Transfer_Status
	FROM warehouses w
	LEFT JOIN stock_transfers st
    ON w.Warehouse_Id = st.From_Warehouse_Id;
    
-- ==========================================
-- Query 58 : Products with Store Orders
-- Purpose : Display All Products Including Those Never Ordered
-- ==========================================

SELECT
	p.Product_Name, soi.Store_Order_Id, soi.Quantity
	FROM products p
	LEFT JOIN store_order_items soi
    ON p.Product_Id = soi.Product_Id;
    

-- ==========================================
-- Query 59 : Complete Stock Transfer Report
-- Purpose : Display Complete Stock Transfer Details
-- ==========================================

SELECT
	st.Transfer_Number, fw.Warehouse_Name AS From_Warehouse, tw.Warehouse_Name AS To_Warehouse,
    p.Product_Code, p.Product_Name, ti.Quantity, st.Transfer_Date, st.Expected_Delivery, st.Received_Date, st.Transfer_Status
	FROM stock_transfers st
	INNER JOIN warehouses fw
    ON st.From_Warehouse_Id = fw.Warehouse_Id
	INNER JOIN warehouses tw
    ON st.To_Warehouse_Id = tw.Warehouse_Id
	INNER JOIN transfer_items ti
    ON st.Transfer_Id = ti.Transfer_Id
	INNER JOIN products p
    ON ti.Product_Id = p.Product_Id
	ORDER BY st.Transfer_Date DESC;
    
    
-- ==========================================
-- Query 60 : Warehouse and Category Planning
-- Purpose : Display Every Warehouse with Every Product Category
-- ==========================================

SELECT
	w.Warehouse_Name,	c.Category_Name
	FROM warehouses w
	CROSS JOIN categories c
	ORDER BY
    w.Warehouse_Name, c.Category_Name;
    
-- ==========================================
-- Query 61 : Products Above Average Price
-- Purpose : Display Products Costing More Than Average Selling Price
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Selling_Price
	FROM products
	WHERE Selling_Price >(
    SELECT AVG(Selling_Price)
    FROM products)
	ORDER BY Selling_Price DESC;
    
-- ==========================================
-- Query 62 : Products Below Average Price
-- Purpose : Display Products Costing Less Than Average Selling Price
-- ==========================================

SELECT
	Product_Id, Product_Code, Product_Name, Selling_Price
	FROM products
	WHERE Selling_Price <(
    SELECT AVG(Selling_Price)
    FROM products)
	ORDER BY Selling_Price;
    
-- ==========================================
-- Query 63 : Suppliers Having Products
-- Purpose : Display Suppliers Who Supply Products
-- ==========================================

SELECT
	Supplier_Id, Supplier_Name
	FROM suppliers
	WHERE Supplier_Id IN(
    SELECT DISTINCT Supplier_Id
    FROM products);
    
-- ==========================================
-- Query 64 : Suppliers Without Products
-- Purpose : Display Suppliers Who Do Not Supply Any Products
-- ==========================================

SELECT
	Supplier_Id, Supplier_Name
	FROM suppliers
	WHERE Supplier_Id NOT IN(
    SELECT DISTINCT Supplier_Id
    FROM products);
    
-- ==========================================
-- Query 65 : Warehouses Having Inventory
-- Purpose : Display Warehouses That Have Inventory
-- ==========================================

SELECT
	Warehouse_Id, Warehouse_Name
    FROM warehouses
	WHERE Warehouse_Id IN
(SELECT DISTINCT Warehouse_Id FROM inventory);

-- ==========================================
-- Query 66 : Suppliers Having Purchase Orders
-- Purpose : Display Suppliers Who Have Purchase Orders
-- ==========================================

SELECT
	s.Supplier_Id, s.Supplier_Name
	FROM suppliers s
	WHERE EXISTS
	(SELECT 1 FROM purchase_orders po
	WHERE po.Supplier_Id = s.Supplier_Id);
    
-- ==========================================
-- Query 67 : Suppliers Without Purchase Orders
-- Purpose : Display Suppliers Who Have No Purchase Orders
-- ==========================================

SELECT
	s.Supplier_Id, s.Supplier_Name
	FROM suppliers s
	WHERE NOT EXISTS(
    SELECT 1 FROM purchase_orders po
	WHERE po.Supplier_Id = s.Supplier_Id);
    
-- ==========================================
-- Query 68 : Product Having Maximum Stock
-- Purpose : Display Product With Maximum Stock In Each Warehouse
-- ==========================================

SELECT
	w.Warehouse_Name, p.Product_Name, i.Available_Qty
	FROM inventory i

	INNER JOIN products p
    ON i.Product_Id = p.Product_Id

	INNER JOIN warehouses w
    ON i.Warehouse_Id = w.Warehouse_Id

	WHERE i.Available_Qty =
	(SELECT MAX(i2.Available_Qty)
	FROM inventory i2
	WHERE i2.Warehouse_Id = i.Warehouse_Id);
    

-- ==========================================
-- Query 69 : Highest Purchase Order Per Supplier
-- Purpose : Display Highest Purchase Order Of Each Supplier
-- ==========================================

SELECT
	s.Supplier_Name, po.Po_Number, po.Total_Amount
	FROM purchase_orders po

	INNER JOIN suppliers s
    ON po.Supplier_Id = s.Supplier_Id

	WHERE po.Total_Amount =
	(SELECT MAX(po2.Total_Amount)
	FROM purchase_orders po2
	WHERE po2.Supplier_Id = po.Supplier_Id);
    
-- ==========================================
-- Query 70 : Products Above Category Average
-- Purpose : Display Products Costing More Than Category Average
-- ==========================================

SELECT
	p.Product_Name, c.Category_Name, p.Selling_Price
	FROM products p

	INNER JOIN categories c
    ON p.Category_Id = c.Category_Id

	WHERE p.Selling_Price >
	(SELECT AVG(p2.Selling_Price)
	FROM products p2
	WHERE p2.Category_Id = p.Category_Id)
	ORDER BY
    c.Category_Name, p.Selling_Price DESC;
    
    
-- ==========================================
-- Query 71 : Product Price Category
-- Purpose : Categorize Products Based on Selling Price
-- ==========================================

SELECT
	Product_Code, Product_Name, Selling_Price,
	CASE
	WHEN Selling_Price < 100 THEN 'Low Price'
	WHEN Selling_Price BETWEEN 100 AND 500 THEN 'Medium Price'
	ELSE 'High Price'
	END AS Price_Category
    FROM products;
    

-- ==========================================
-- Query 72 : Inventory Status Category
-- Purpose : Display Inventory Level Category
-- ==========================================

SELECT
	Product_Id, Available_Qty,
	CASE
	WHEN Available_Qty = 0 THEN 'Out Of Stock'
	WHEN Available_Qty <= Reorder_Level THEN 'Low Stock'
	ELSE 'In Stock'
	END AS Stock_Level
	FROM inventory;
    
    -- ==========================================
-- Query 73 : Employee Salary Grade
-- Purpose : Categorize Employees Based on Salary
-- ==========================================

SELECT
	Employee_Code, First_Name, Last_Name, Salary,
	CASE
	WHEN Salary < 25000 THEN 'Grade C'
	WHEN Salary BETWEEN 25000 AND 50000 THEN 'Grade B'
	ELSE 'Grade A'
	END AS Salary_Grade
	FROM employees;
    

-- ==========================================
-- Query 74 : Warehouse Inventory Ranking
-- Purpose : Rank Warehouses By Available Inventory
-- ==========================================

SELECT
	Warehouse_Id, SUM(Available_Qty) AS Total_Stock,
	ROW_NUMBER() OVER(ORDER BY SUM(Available_Qty) DESC) AS Warehouse_Rank
	FROM inventory
	GROUP BY Warehouse_Id;
    

-- ==========================================
-- Query 75 : Product Price Ranking
-- Purpose : Rank Products By Selling Price
-- ==========================================

SELECT
	Product_Name, Selling_Price,
	RANK() OVER(ORDER BY Selling_Price DESC) AS Price_Rank
	FROM products;
    
-- ==========================================
-- Query 77 : Running Total Inventory
-- Purpose : Display Running Total Of Inventory
-- ==========================================

SELECT
	Inventory_Id, Available_Qty,
	SUM(Available_Qty) OVER(ORDER BY Inventory_Id) AS Running_Total
	FROM inventory;
    

-- ==========================================
-- Query 78 : Product Stock Report Using CTE
-- Purpose : Display Product Inventory Using CTE
-- ==========================================

WITH Product_Stock AS
     (SELECT
		Product_Id, SUM(Available_Qty) AS Total_Stock FROM inventory GROUP BY Product_Id)
	  SELECT
		p.Product_Name, ps.Total_Stock
		FROM Product_Stock ps
		INNER JOIN products p
		ON ps.Product_Id = p.Product_Id;
        

-- ==========================================
-- Query 79 : Warehouse Inventory Report Using CTE
-- Purpose : Display Warehouse Inventory Summary
-- ==========================================

WITH Warehouse_Stock AS
	(SELECT
		Warehouse_Id, SUM(Available_Qty) AS Total_Stock
		FROM inventory
		GROUP BY Warehouse_Id)
	 SELECT
		w.Warehouse_Name, ws.Total_Stock
		FROM Warehouse_Stock ws
		INNER JOIN warehouses w
		ON ws.Warehouse_Id = w.Warehouse_Id;
        
        
-- ==========================================
-- Query 80 : Top 10 Expensive Products
-- Purpose : Display Top 10 Highest Selling Price Products
-- ==========================================

SELECT
	Product_Code, Product_Name, Selling_Price
	FROM products
	ORDER BY Selling_Price DESC
	LIMIT 10;
    
    
-- ==========================================
-- Query 81 : Top 10 Products by Available Stock
-- Purpose : Display Top 10 Products Having Highest Available Stock
-- ==========================================

SELECT
	p.Product_Code, p.Product_Name, SUM(i.Available_Qty) AS Total_Available_Stock
	FROM products p
	INNER JOIN inventory i
    ON p.Product_Id = i.Product_Id
	GROUP BY
	p.Product_Id, p.Product_Code, p.Product_Name
	ORDER BY Total_Available_Stock DESC
	LIMIT 10;
    

-- ==========================================
-- Query 82 : Top 10 Products by Damaged Stock
-- Purpose : Display Products Having Highest Damaged Stock
-- ==========================================

SELECT
	p.Product_Code, p.Product_Name, SUM(i.Damaged_Qty) AS Total_Damaged_Stock
	FROM products p
	INNER JOIN inventory i
    ON p.Product_Id = i.Product_Id
	GROUP BY
	p.Product_Id, p.Product_Code, p.Product_Name
	ORDER BY Total_Damaged_Stock DESC
	LIMIT 10;
    
-- ==========================================
-- Query 83 : Top 10 Suppliers by Purchase Amount
-- Purpose : Display Suppliers Based on Total Purchase Amount
-- ==========================================

SELECT
	s.Supplier_Name, SUM(po.Total_Amount) AS Total_Purchase
	FROM suppliers s

	INNER JOIN purchase_orders po
    ON s.Supplier_Id = po.Supplier_Id
	GROUP BY
	s.Supplier_Id, s.Supplier_Name
	ORDER BY Total_Purchase DESC
    LIMIT 10;
    

-- ==========================================
-- Query 84 : Warehouse Inventory Summary
-- Purpose : Display Warehouse Wise Inventory Summary
-- ==========================================

SELECT
	w.Warehouse_Name, SUM(i.Available_Qty) AS Available_Stock, SUM(i.Reserved_Qty) AS Reserved_Stock, SUM(i.Damaged_Qty) AS Damaged_Stock
	FROM warehouses w

	INNER JOIN inventory i
    ON w.Warehouse_Id = i.Warehouse_Id
	GROUP BY
	w.Warehouse_Id, w.Warehouse_Name
	ORDER BY Available_Stock DESC;
    
-- ==========================================
-- Query 85 : Category Wise Stock Value
-- Purpose : Display Category Wise Inventory Value
-- ==========================================

SELECT
	c.Category_Name,
	ROUND(SUM(i.Available_Qty * p.Cost_Price),2) AS Stock_Value
	FROM inventory i

	INNER JOIN products p
    ON i.Product_Id = p.Product_Id

	INNER JOIN categories c
    ON p.Category_Id = c.Category_Id

	GROUP BY
	c.Category_Id, c.Category_Name
	ORDER BY Stock_Value DESC;
    

-- ==========================================
-- Query 86 : Top 10 Warehouses by Stock Value
-- Purpose : Display Warehouses Based on Total Stock Value
-- ==========================================

SELECT
	w.Warehouse_Name,
	ROUND(SUM(i.Available_Qty * p.Cost_Price),2) AS Stock_Value
	FROM warehouses w

	INNER JOIN inventory i
    ON w.Warehouse_Id = i.Warehouse_Id

	INNER JOIN products p
    ON i.Product_Id = p.Product_Id

	GROUP BY
	w.Warehouse_Id, w.Warehouse_Name
	ORDER BY Stock_Value DESC
	LIMIT 10;
    
-- ==========================================
-- Query 87 : Top 10 Stores by Ordered Quantity
-- Purpose : Display Stores Based on Total Ordered Quantity
-- ==========================================

SELECT
	s.Store_Name,
	SUM(soi.Quantity) AS Total_Ordered_Qty
	FROM stores s

	INNER JOIN store_orders so
    ON s.Store_Id = so.Store_Id

	INNER JOIN store_order_items soi
    ON so.Store_Order_Id = soi.Store_Order_Id

	GROUP BY
	s.Store_Id, s.Store_Name
	ORDER BY Total_Ordered_Qty DESC
	LIMIT 10;
    
    
-- ==========================================
-- Query 88 : Monthly Purchase Summary
-- Purpose : Display Month Wise Purchase Amount
-- ==========================================

SELECT
	YEAR(Order_Date) AS Purchase_Year,
	MONTH(Order_Date) AS Purchase_Month,
	COUNT(Po_Id) AS Total_Purchase_Orders,
	ROUND(SUM(Total_Amount),2) AS Total_Purchase_Amount
	FROM purchase_orders
	
    GROUP BY
	YEAR(Order_Date), MONTH(Order_Date)

	ORDER BY
	Purchase_Year, Purchase_Month;
    

-- ==========================================
-- Query 89 : Monthly Stock Transfer Summary
-- Purpose : Display Month Wise Stock Transfers
-- ==========================================

SELECT
	YEAR(Transfer_Date) AS Transfer_Year,
	MONTH(Transfer_Date) AS Transfer_Month,
	COUNT(Transfer_Id) AS Total_Transfers
	FROM stock_transfers
	
    GROUP BY
	YEAR(Transfer_Date),
    MONTH(Transfer_Date)

ORDER BY
	Transfer_Year, Transfer_Month;
    

-- ==========================================
-- Query 90 : Executive Inventory Summary
-- Purpose : Display Overall Inventory KPI Summary
-- ==========================================

SELECT
	COUNT(*) AS Total_Inventory_Records,
	SUM(Available_Qty) AS Total_Available_Stock,
	SUM(Reserved_Qty) AS Total_Reserved_Stock,
	SUM(Damaged_Qty) AS Total_Damaged_Stock,
	ROUND(AVG(Available_Qty),2) AS Average_Available_Stock
	FROM inventory;
    
    
-- ==========================================
-- Query 91 : Top 10 Best Selling Products
-- Purpose : Display Products Supplied Most to Stores
-- ==========================================

SELECT
	p.Product_Code, p.Product_Name,
	SUM(soi.Supplied_Quantity) AS Total_Supplied
	FROM products p

	INNER JOIN store_order_items soi
    ON p.Product_Id = soi.Product_Id

	GROUP BY
	p.Product_Id, p.Product_Code, p.Product_Name
	ORDER BY Total_Supplied DESC
	LIMIT 10;
    
-- ==========================================
-- Query 92 : Top 10 Low Stock Products
-- Purpose : Display Products Near Reorder Level
-- ==========================================

SELECT
	p.Product_Code,	p.Product_Name, i.Available_Qty, i.Reorder_Level
	FROM inventory i

	INNER JOIN products p
    ON i.Product_Id = p.Product_Id
    WHERE i.Available_Qty <= i.Reorder_Level
	ORDER BY i.Available_Qty
    LIMIT 10;
    
-- ==========================================
-- Query 93 : Supplier Performance Report
-- Purpose : Display Supplier Purchase Summary
-- ==========================================

SELECT
	s.Supplier_Name,
	COUNT(po.Po_Id) AS Total_Purchase_Orders,
	ROUND(SUM(po.Total_Amount),2) AS Total_Purchase_Amount
	FROM suppliers s
	INNER JOIN purchase_orders po
    ON s.Supplier_Id = po.Supplier_Id

	GROUP BY
	s.Supplier_Id, s.Supplier_Name
	ORDER BY Total_Purchase_Amount DESC;
    

-- ==========================================
-- Query 94 : Warehouse Performance Report
-- Purpose : Display Warehouse Stock Summary
-- ==========================================

SELECT
	w.Warehouse_Name,
	COUNT(i.Inventory_Id) AS Total_Products,
	SUM(i.Available_Qty) AS Available_Stock
	FROM warehouses w

	INNER JOIN inventory i
    ON w.Warehouse_Id = i.Warehouse_Id

	GROUP BY
	w.Warehouse_Id, w.Warehouse_Name
	ORDER BY Available_Stock DESC;
    
    
-- ==========================================
-- Query 95 : Store Performance Report
-- Purpose : Display Store Order Summary
-- ==========================================

SELECT
	s.Store_Name,
	COUNT(so.Store_Order_Id) AS Total_Orders,
	SUM(soi.Supplied_Quantity) AS Total_Supplied
	FROM stores s

	INNER JOIN store_orders so
    ON s.Store_Id = so.Store_Id

	INNER JOIN store_order_items soi
    ON so.Store_Order_Id = soi.Store_Order_Id

	GROUP BY
	s.Store_Id, s.Store_Name
	ORDER BY Total_Supplied DESC;
    
-- ==========================================
-- Query 96 : Category Performance Report
-- Purpose : Display Category Wise Stock Value
-- ==========================================

SELECT
	c.Category_Name,
	ROUND(SUM(i.Available_Qty * p.Cost_Price),2) AS Stock_Value
	FROM categories c

	INNER JOIN products p
    ON c.Category_Id = p.Category_Id

	INNER JOIN inventory i
    ON p.Product_Id = i.Product_Id

	GROUP BY
	c.Category_Id, c.Category_Name
	ORDER BY Stock_Value DESC;
    
    
-- ==========================================
-- Query 97 : Purchase Status Summary
-- Purpose : Display Purchase Orders Status Wise
-- ==========================================

SELECT
	Order_Status,
	COUNT(*) AS Total_Orders,
	ROUND(SUM(Total_Amount),2) AS Total_Amount
	FROM purchase_orders
	GROUP BY Order_Status;
    
    
-- ==========================================
-- Query 98 : Transfer Status Summary
-- Purpose : Display Stock Transfer Status Wise
-- ==========================================

SELECT
	Transfer_Status,
	COUNT(*) AS Total_Transfers
	FROM stock_transfers
    GROUP BY Transfer_Status;
    
    
-- ==========================================
-- Query 99 : Shipment Status Summary
-- Purpose : Display Shipment Status Wise
-- ==========================================

SELECT
	Shipment_Status,
	COUNT(*) AS Total_Shipments
	FROM shipments
	GROUP BY Shipment_Status;
    

-- ==========================================
-- Query 100 : Executive Business Dashboard
-- Purpose : Display Overall Business Summary
-- ==========================================

SELECT
	(SELECT COUNT(*) FROM products) AS Total_Products,
	(SELECT COUNT(*) FROM suppliers) AS Total_Suppliers,
	(SELECT COUNT(*) FROM warehouses) AS Total_Warehouses,
	(SELECT COUNT(*) FROM stores) AS Total_Stores,
	(SELECT SUM(Available_Qty) FROM inventory) AS Total_Available_Stock,
	(SELECT ROUND(SUM(Available_Qty * Cost_Price),2)
	FROM inventory i
	INNER JOIN products p
	ON i.Product_Id = p.Product_Id
    ) AS Total_Inventory_Value;
    
    

    
    

