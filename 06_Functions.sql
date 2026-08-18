-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 06_Functions.sql
-- Purpose  : Create User Defined Functions
-- ==========================================================

-- ==========================================
-- Function 1 : Get_Product_Stock_Value
-- Purpose : Calculate Total Stock Value of a Product
-- ==========================================

DROP FUNCTION IF EXISTS Get_Product_Stock_Value;

DELIMITER $$

CREATE FUNCTION Get_Product_Stock_Value
(
    p_Product_Id INT
)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE v_Stock_Value DECIMAL(15,2);

    SELECT
        SUM(i.Available_Qty * p.Selling_Price)
    INTO v_Stock_Value
    FROM inventory i
    INNER JOIN products p
        ON i.Product_Id = p.Product_Id
    WHERE i.Product_Id = p_Product_Id;

    RETURN IFNULL(v_Stock_Value,0);

END$$

DELIMITER ;

-- ==========================================
-- Execute Function
-- ==========================================


SELECT Get_Product_Stock_Value(11) AS Stock_Value;

-- ==========================================
-- Function 2 : Get_Warehouse_Utilization
-- Purpose : Calculate Warehouse Utilization (%)
-- ==========================================

DROP FUNCTION IF EXISTS Get_Warehouse_Utilization;

DELIMITER $$

CREATE FUNCTION Get_Warehouse_Utilization
(
    p_Warehouse_Id INT
)
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE v_Utilization DECIMAL(10,2);

    SELECT
        ROUND((Current_Capacity / Storage_Capacity) * 100, 2)
    INTO v_Utilization
    FROM warehouses
    WHERE Warehouse_Id = p_Warehouse_Id;

    RETURN IFNULL(v_Utilization,0);

END$$

DELIMITER ;

-- ==========================================
-- Execute Function
-- ==========================================

SELECT Get_Warehouse_Utilization(1) AS Utilization_Percentage;


-- ==========================================
-- Function 3 : Get_Supplier_Rating
-- Purpose : Return Supplier Rating
-- ==========================================

DROP FUNCTION IF EXISTS Get_Supplier_Rating;

DELIMITER $$

CREATE FUNCTION Get_Supplier_Rating
(
    p_Supplier_Id INT
)
RETURNS DECIMAL(3,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE v_Rating DECIMAL(3,2);

    SELECT
        Supplier_Rating
    INTO v_Rating
    FROM suppliers
    WHERE Supplier_Id = p_Supplier_Id;

    RETURN IFNULL(v_Rating,0);

END$$

DELIMITER ;

-- ==========================================
-- Execute Function
-- ==========================================

SELECT Get_Supplier_Rating(81) AS Supplier_Rating;


-- ==========================================
-- Function 4 : Get_Product_Profit
-- Purpose : Calculate Profit Per Unit of a Product
-- ==========================================

DROP FUNCTION IF EXISTS Get_Product_Profit;

DELIMITER $$

CREATE FUNCTION Get_Product_Profit
(
    p_Product_Id INT
)
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE v_Profit DECIMAL(10,2);

    SELECT
        (Selling_Price - Cost_Price)
    INTO v_Profit
    FROM products
    WHERE Product_Id = p_Product_Id;

    RETURN IFNULL(v_Profit,0);

END$$

DELIMITER ;

-- ==========================================
-- Execute Function
-- ==========================================

SELECT Get_Product_Profit(11) AS Product_Profit;

-- ==========================================
-- Function 5 : Get_Available_Stock
-- Purpose : Return Available Stock of a Product
-- ==========================================

DROP FUNCTION IF EXISTS Get_Available_Stock;

DELIMITER $$

CREATE FUNCTION Get_Available_Stock
(
    p_Product_Id INT
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE v_Available_Stock INT;

    SELECT
        SUM(Available_Qty)
    INTO v_Available_Stock
    FROM inventory
    WHERE Product_Id = p_Product_Id;

    RETURN IFNULL(v_Available_Stock,0);

END$$

DELIMITER ;

-- ==========================================
-- Execute Function
-- ==========================================

SELECT Get_Available_Stock(11) AS Available_Stock;

