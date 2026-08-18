-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 05_Stored_Procedures.sql
-- Purpose  : Create Stored Procedures
-- ==========================================================

-- =====================================================
-- Procedure 1 : Get_Low_Stock_Products
-- Purpose : Display products below reorder level
-- =====================================================

DROP PROCEDURE IF EXISTS Get_Low_Stock_Products;

DELIMITER $$

CREATE PROCEDURE Get_Low_Stock_Products()
BEGIN

    SELECT
        i.Inventory_Id,
        p.Product_Code,
        p.Product_Name,
        c.Category_Name,
        w.warehouse_name AS Warehouse_Name,
        i.Available_Qty,
        i.Reorder_Level,
        i.Inventory_Status
    FROM inventory i
        INNER JOIN products p
            ON i.Product_Id = p.Product_Id
        INNER JOIN categories c
            ON p.Category_Id = c.Category_Id
        INNER JOIN warehouses w
            ON i.Warehouse_Id = w.Warehouse_Id
    WHERE i.Available_Qty <= i.Reorder_Level
    ORDER BY i.Available_Qty ASC,
             p.Product_Name;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Low_Stock_Products();


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Low_Stock_Products
FROM inventory
WHERE Available_Qty <= Reorder_Level;


-- =====================================================
-- Procedure 2 : Get_Products_By_Category
-- Purpose : Display all products of a selected category
-- =====================================================

-- =====================================================
-- Procedure 2 : Get_Products_By_Category
-- Purpose : Display all products of a selected category
-- =====================================================
DROP PROCEDURE IF EXISTS Get_Products_By_Category;

DELIMITER $$

CREATE PROCEDURE Get_Products_By_Category
(
    IN p_Category_Id INT
)
BEGIN

    SELECT
        p.Product_Code,
        p.Product_Name,
        c.Category_Name,
        s.Supplier_Name,
        p.Brand,
        p.Unit,
        p.Cost_Price,
        p.Selling_Price,
        p.Status
    FROM products p
    INNER JOIN categories c
        ON p.Category_Id = c.Category_Id
    INNER JOIN suppliers s
        ON p.Supplier_Id = s.Supplier_Id
    WHERE p.Category_Id = p_Category_Id
    ORDER BY p.Product_Name;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Products_By_Category(5);


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Products
FROM products
WHERE Category_Id = 5;


-- =====================================================
-- Procedure 3 : Get_Supplier_Performance
-- Purpose : Display Supplier Performance Report
-- =====================================================

DROP PROCEDURE IF EXISTS Get_Supplier_Performance;

DELIMITER $$

CREATE PROCEDURE Get_Supplier_Performance()
BEGIN

    SELECT
        s.Supplier_Code,
        s.Supplier_Name,
        sp.Performance_Month,
        sp.Total_Orders,
        sp.On_Time_Delivery_Percent,
        sp.Average_Delay_Days,
        sp.Supplier_Rating
    FROM supplier_performance sp
    INNER JOIN suppliers s
        ON sp.Supplier_Id = s.Supplier_Id
    ORDER BY
        sp.Supplier_Rating DESC,
        sp.Total_Orders DESC;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Supplier_Performance();


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Records
FROM supplier_performance;

-- =====================================================
-- Procedure 4 : Get_Warehouse_Inventory
-- Purpose : Display Inventory of Selected Warehouse
-- =====================================================

DROP PROCEDURE IF EXISTS Get_Warehouse_Inventory;

DELIMITER $$

CREATE PROCEDURE Get_Warehouse_Inventory
(
    IN p_Warehouse_Id INT
)
BEGIN

    SELECT
        w.Warehouse_Code,
        w.Warehouse_Name,
        p.Product_Code,
        p.Product_Name,
        c.Category_Name,
        i.Available_Qty,
        i.Reserved_Qty,
        i.Damaged_Qty,
        i.Inventory_Status
    FROM inventory i
    INNER JOIN warehouses w
        ON i.Warehouse_Id = w.Warehouse_Id
    INNER JOIN products p
        ON i.Product_Id = p.Product_Id
    INNER JOIN categories c
        ON p.Category_Id = c.Category_Id
    WHERE i.Warehouse_Id = p_Warehouse_Id
    ORDER BY p.Product_Name;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Warehouse_Inventory(1);


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Products
FROM inventory
WHERE Warehouse_Id = 1;

-- ==========================================
-- Procedure 5 : Get_Store_Orders
-- Purpose : Display Orders of Selected Store
-- ==========================================

DROP PROCEDURE IF EXISTS Get_Store_Orders;

DELIMITER $$

CREATE PROCEDURE Get_Store_Orders
(
    IN p_Store_Id INT
)
BEGIN

    SELECT
        s.Store_Code,
        s.Store_Name,
        so.Store_Order_Id,
        so.Order_Date,
        so.Required_Date,
        so.Delivered_Date,
        so.Order_Status
    FROM store_orders so
    INNER JOIN stores s
        ON so.Store_Id = s.Store_Id
    WHERE so.Store_Id = p_Store_Id
    ORDER BY so.Order_Date DESC;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Store_Orders(1);


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Orders
FROM store_orders
WHERE Store_Id = 1;

-- ==========================================
-- Procedure 6 : Get_Purchase_Orders_By_Supplier
-- Purpose : Display Purchase Orders of Selected Supplier
-- ==========================================

DROP PROCEDURE IF EXISTS Get_Purchase_Orders_By_Supplier;

DELIMITER $$

CREATE PROCEDURE Get_Purchase_Orders_By_Supplier
(
    IN p_Supplier_Id INT
)
BEGIN

    SELECT
        s.Supplier_Code,
        s.Supplier_Name,
        po.Po_Number,
        po.Order_Date,
        po.Expected_Delivery,
        po.Actual_Delivery,
        po.Total_Amount,
        po.Order_Status,
        po.Payment_Status
    FROM purchase_orders po
    INNER JOIN suppliers s
        ON po.Supplier_Id = s.Supplier_Id
    WHERE po.Supplier_Id = p_Supplier_Id
    ORDER BY po.Order_Date DESC;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Purchase_Orders_By_Supplier(81);


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Purchase_Orders
FROM purchase_orders
WHERE Supplier_Id = 81;

-- ==========================================
-- Procedure 7 : Get_Damaged_Stock
-- Purpose : Display Damaged Stock Report
-- ==========================================

DROP PROCEDURE IF EXISTS Get_Damaged_Stock;

DELIMITER $$

CREATE PROCEDURE Get_Damaged_Stock()
BEGIN

    SELECT
        w.Warehouse_Code,
        w.Warehouse_Name,
        p.Product_Code,
        p.Product_Name,
        c.Category_Name,
        i.Damaged_Qty,
        i.Available_Qty,
        i.Inventory_Status
    FROM inventory i
    INNER JOIN products p
        ON i.Product_Id = p.Product_Id
    INNER JOIN categories c
        ON p.Category_Id = c.Category_Id
    INNER JOIN warehouses w
        ON i.Warehouse_Id = w.Warehouse_Id
    WHERE i.Damaged_Qty > 0
    ORDER BY i.Damaged_Qty DESC, p.Product_Name;

END$$

DELIMITER 

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Damaged_Stock();


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Damaged_Products
FROM inventory
WHERE Damaged_Qty > 0;


-- ==========================================
-- Procedure 8 : Get_Transfer_Report
-- Purpose : Display Stock Transfer Report
-- ==========================================

DROP PROCEDURE IF EXISTS Get_Transfer_Report;

DELIMITER $$

CREATE PROCEDURE Get_Transfer_Report()
BEGIN

    SELECT
        st.Transfer_Number,
        fw.Warehouse_Name AS From_Warehouse,
        tw.Warehouse_Name AS To_Warehouse,
        st.Transfer_Date,
        st.Expected_Delivery,
        st.Received_Date,
        st.Transfer_Status,
        st.Remarks
    FROM stock_transfers st
    INNER JOIN warehouses fw
        ON st.From_Warehouse_Id = fw.Warehouse_Id
    INNER JOIN warehouses tw
        ON st.To_Warehouse_Id = tw.Warehouse_Id
    ORDER BY st.Transfer_Date DESC;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Transfer_Report();


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Transfers
	FROM stock_transfers;



-- ==========================================
-- Procedure 9 : Get_Warehouse_Capacity
-- Purpose : Display Warehouse Capacity Report
-- ==========================================

DROP PROCEDURE IF EXISTS Get_Warehouse_Capacity;

DELIMITER $$

CREATE PROCEDURE Get_Warehouse_Capacity()
BEGIN

    SELECT
        Warehouse_Code,
        Warehouse_Name,
        City,
        State,
        Storage_Capacity,
        Current_Capacity,
        (Storage_Capacity - Current_Capacity) AS Available_Capacity,
        ROUND((Current_Capacity / Storage_Capacity) * 100, 2) AS Utilization_Percentage,
        Status
    FROM warehouses
    ORDER BY Utilization_Percentage DESC;

END$$

DELIMITER ;


-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Warehouse_Capacity();


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Warehouses
	FROM warehouses;


-- ==========================================
-- Procedure 10 : Get_Inventory_Summary
-- Purpose : Display Overall Inventory Summary
-- ==========================================

DROP PROCEDURE IF EXISTS Get_Inventory_Summary;

DELIMITER $$

CREATE PROCEDURE Get_Inventory_Summary()
BEGIN

    SELECT
        COUNT(*) AS Total_Inventory_Records,
        SUM(Available_Qty) AS Total_Available_Stock,
        SUM(Reserved_Qty) AS Total_Reserved_Stock,
        SUM(Damaged_Qty) AS Total_Damaged_Stock,
        ROUND(AVG(Available_Qty),2) AS Average_Available_Stock
    FROM inventory;

END$$

DELIMITER ;

-- ==========================================
-- Execute Procedure
-- ==========================================

CALL Get_Inventory_Summary();


-- ==========================================
-- Verify Result
-- ==========================================

SELECT
    COUNT(*) AS Total_Inventory_Records,
    SUM(Available_Qty) AS Total_Available_Stock,
    SUM(Reserved_Qty) AS Total_Reserved_Stock,
    SUM(Damaged_Qty) AS Total_Damaged_Stock,
    ROUND(AVG(Available_Qty),2) AS Average_Available_Stock
	FROM inventory;























     


