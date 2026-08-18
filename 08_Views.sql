-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 08_Views.sql
-- Purpose  : Create Database Views
-- ==========================================================

-- ==========================================
-- View 1 : VW_Product_Details
-- Purpose : Display Complete Product Details
-- ==========================================

DROP VIEW IF EXISTS VW_Product_Details;

CREATE VIEW VW_Product_Details AS

SELECT

    p.Product_Id,
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
    ON p.Supplier_Id = s.Supplier_Id;
    
-- ==========================================
-- Verification : VW_Product_Details
-- ==========================================

SELECT *
FROM VW_Product_Details
LIMIT 10;
    

-- ==========================================
-- View 2 : VW_Inventory_Summary
-- Purpose : Display Inventory Summary
-- ==========================================

DROP VIEW IF EXISTS VW_Inventory_Summary;

CREATE VIEW VW_Inventory_Summary AS

SELECT

    i.Inventory_Id,
    p.Product_Code,
    p.Product_Name,
    w.Warehouse_Code,
    w.Warehouse_Name,
    i.Available_Qty,
    i.Reserved_Qty,
    i.Damaged_Qty,
    i.Reorder_Level,
    i.Inventory_Status

FROM inventory i

INNER JOIN products p
    ON i.Product_Id = p.Product_Id

INNER JOIN warehouses w
    ON i.Warehouse_Id = w.Warehouse_Id;
    
-- ==========================================
-- Verification : VW_Inventory_Summary
-- ==========================================

SELECT *
FROM VW_Inventory_Summary
LIMIT 10;
    

-- ==========================================
-- View 3 : VW_Warehouse_Inventory
-- Purpose : Display Warehouse Inventory Details
-- ==========================================

DROP VIEW IF EXISTS VW_Warehouse_Inventory;

CREATE VIEW VW_Warehouse_Inventory AS

SELECT

    w.Warehouse_Id,
    w.Warehouse_Code,
    w.Warehouse_Name,
    w.City,
    w.State,
    p.Product_Code,
    p.Product_Name,
    c.Category_Name,
    i.Available_Qty,
    i.Reserved_Qty,
    i.Damaged_Qty,
    i.Inventory_Status

FROM warehouses w

INNER JOIN inventory i
    ON w.Warehouse_Id = i.Warehouse_Id

INNER JOIN products p
    ON i.Product_Id = p.Product_Id

INNER JOIN categories c
    ON p.Category_Id = c.Category_Id;
    
-- ==========================================
-- Verification : VW_Warehouse_Inventory
-- ==========================================

SELECT *
FROM VW_Warehouse_Inventory
LIMIT 10;
    

-- ==========================================
-- View 4 : VW_Supplier_Products
-- Purpose : Display Suppliers with Their Products
-- ==========================================

DROP VIEW IF EXISTS VW_Supplier_Products;

CREATE VIEW VW_Supplier_Products AS

SELECT

    s.Supplier_Id,
    s.Supplier_Code,
    s.Supplier_Name,
    s.State,
    s.Supplier_Rating,
    p.Product_Id,
    p.Product_Code,
    p.Product_Name,
    p.Brand,
    p.Selling_Price,
    p.Status

FROM suppliers s

LEFT JOIN products p
    ON s.Supplier_Id = p.Supplier_Id;
    
-- ==========================================
-- Verification : VW_Supplier_Products
-- ==========================================

SELECT *
FROM VW_Supplier_Products
LIMIT 10;
    

-- ==========================================
-- View 5 : VW_Purchase_Order_Report
-- Purpose : Display Complete Purchase Order Report
-- ==========================================

DROP VIEW IF EXISTS VW_Purchase_Order_Report;

CREATE VIEW VW_Purchase_Order_Report AS

SELECT

    po.Po_Id,
    po.Po_Number,
    po.Order_Date,
    s.Supplier_Name,
    w.Warehouse_Name,
    e.First_Name,
    e.Last_Name,
    po.Total_Amount,
    po.Order_Status,
    po.Payment_Status

FROM purchase_orders po

INNER JOIN suppliers s
    ON po.Supplier_Id = s.Supplier_Id

INNER JOIN warehouses w
    ON po.Warehouse_Id = w.Warehouse_Id

INNER JOIN employees e
    ON po.Employee_Id = e.Employee_Id;
    
-- ==========================================
-- Verification : VW_Purchase_Order_Report
-- ==========================================

SELECT *
FROM VW_Purchase_Order_Report
LIMIT 10;
    
    
-- ==========================================
-- View 6 : VW_Store_Order_Report
-- Purpose : Display Complete Store Order Report
-- ==========================================

DROP VIEW IF EXISTS VW_Store_Order_Report;

CREATE VIEW VW_Store_Order_Report AS

SELECT

    so.Store_Order_Id,
    so.Order_Date,
    so.Required_Date,
    so.Delivered_Date,
    st.Store_Name,
    w.Warehouse_Name,
    so.Order_Status,
    p.Product_Name,
    soi.Quantity,
    soi.Supplied_Quantity

FROM store_orders so

INNER JOIN stores st
    ON so.Store_Id = st.Store_Id

INNER JOIN warehouses w
    ON so.Warehouse_Id = w.Warehouse_Id

INNER JOIN store_order_items soi
    ON so.Store_Order_Id = soi.Store_Order_Id

INNER JOIN products p
    ON soi.Product_Id = p.Product_Id;
    
-- ==========================================
-- Verification : VW_Store_Order_Report
-- ==========================================

SELECT *
FROM VW_Store_Order_Report
LIMIT 10;
    
    
-- ==========================================
-- View 7 : VW_Shipment_Report
-- Purpose : Display Complete Shipment Report
-- ==========================================

DROP VIEW IF EXISTS VW_Shipment_Report;

CREATE VIEW VW_Shipment_Report AS

SELECT

    sh.Shipment_Id,
    sh.Shipment_Number,
    sh.Dispatch_Date,
    sh.Expected_Arrival,
    sh.Arrival_Date,
    sh.Transport_Mode,
    sh.Vehicle_Number,
    sh.Shipment_Status,
    po.Po_Number,
    s.Supplier_Name,
    w.Warehouse_Name

FROM shipments sh

INNER JOIN purchase_orders po
    ON sh.Po_Id = po.Po_Id

LEFT JOIN suppliers s
    ON po.Supplier_Id = s.Supplier_Id

LEFT JOIN warehouses w
    ON po.Warehouse_Id = w.Warehouse_Id;
    
-- ==========================================
-- Verification : VW_Shipment_Report
-- ==========================================

SELECT *
FROM VW_Shipment_Report
LIMIT 10;
    
    
-- ==========================================
-- View 8 : VW_Transfer_Report
-- Purpose : Display Complete Stock Transfer Report
-- ==========================================

DROP VIEW IF EXISTS VW_Transfer_Report;

CREATE VIEW VW_Transfer_Report AS

SELECT

    st.Transfer_Id,
    st.Transfer_Number,
    st.Transfer_Date,
    st.Expected_Delivery,
    st.Received_Date,
    st.Transfer_Status,

    fw.Warehouse_Name AS From_Warehouse,
    tw.Warehouse_Name AS To_Warehouse,

    p.Product_Code,
    p.Product_Name,
    ti.Quantity

FROM stock_transfers st

INNER JOIN warehouses fw
    ON st.From_Warehouse_Id = fw.Warehouse_Id

INNER JOIN warehouses tw
    ON st.To_Warehouse_Id = tw.Warehouse_Id

INNER JOIN transfer_items ti
    ON st.Transfer_Id = ti.Transfer_Id

INNER JOIN products p
    ON ti.Product_Id = p.Product_Id;
    
-- ==========================================
-- Verification : VW_Transfer_Report
-- ==========================================

SELECT *
FROM VW_Transfer_Report
LIMIT 10;
    

-- ==========================================
-- View 9 : VW_Low_Stock
-- Purpose : Display Low Stock Products
-- ==========================================

DROP VIEW IF EXISTS VW_Low_Stock;

CREATE VIEW VW_Low_Stock AS

SELECT

    i.Inventory_Id,
    p.Product_Code,
    p.Product_Name,
    c.Category_Name,
    w.Warehouse_Name,
    i.Available_Qty,
    i.Reorder_Level,
    i.Reorder_Quantity,
    i.Inventory_Status

FROM inventory i

INNER JOIN products p
    ON i.Product_Id = p.Product_Id

INNER JOIN categories c
    ON p.Category_Id = c.Category_Id

INNER JOIN warehouses w
    ON i.Warehouse_Id = w.Warehouse_Id

WHERE i.Available_Qty <= i.Reorder_Level;

-- ==========================================
-- Verification : VW_Low_Stock
-- ==========================================

SELECT *
FROM VW_Low_Stock
LIMIT 10;


-- ==========================================
-- View 10 : VW_Dashboard_Summary
-- Purpose : Display Overall Supply Chain Dashboard Summary
-- ==========================================

DROP VIEW IF EXISTS VW_Dashboard_Summary;

CREATE VIEW VW_Dashboard_Summary AS

SELECT

    COUNT(DISTINCT p.Product_Id) AS Total_Products,
    COUNT(DISTINCT s.Supplier_Id) AS Total_Suppliers,
    COUNT(DISTINCT w.Warehouse_Id) AS Total_Warehouses,
    COUNT(DISTINCT st.Store_Id) AS Total_Stores,

    SUM(i.Available_Qty) AS Total_Available_Stock,
    SUM(i.Reserved_Qty) AS Total_Reserved_Stock,
    SUM(i.Damaged_Qty) AS Total_Damaged_Stock,

    ROUND(AVG(p.Selling_Price),2) AS Average_Product_Price

FROM inventory i

INNER JOIN products p
    ON i.Product_Id = p.Product_Id

LEFT JOIN suppliers s
    ON p.Supplier_Id = s.Supplier_Id

LEFT JOIN warehouses w
    ON i.Warehouse_Id = w.Warehouse_Id

LEFT JOIN stores st
    ON st.Warehouse_Id = w.Warehouse_Id;
    
-- ==========================================
-- Verification : VW_Dashboard_Summary
-- ==========================================

SELECT *
FROM VW_Dashboard_Summary;