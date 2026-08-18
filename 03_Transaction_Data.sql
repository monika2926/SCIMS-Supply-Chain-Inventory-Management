-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 03_Transaction_Data.sql
-- Purpose  : Insert Transaction Data into Database Tables
-- ==========================================================


-- ==========================================
-- Table 8 : Inventory
-- Purpose : Generate Inventory Records
-- ==========================================

-- ==========================================
-- Procedure : Generate_Inventory
-- Purpose   : Generate Inventory Records
-- ==========================================

DELIMITER $$

CREATE PROCEDURE generate_inventory()
BEGIN

    DECLARE v_product_id INT DEFAULT 11;
    DECLARE v_warehouse_id INT DEFAULT 1;

    WHILE v_warehouse_id <= 25 DO

        SET v_product_id = 11;

        WHILE v_product_id <= 510 DO

            INSERT INTO inventory
            (
                Product_Id,
                Warehouse_Id,
                Available_Qty,
                Reserved_Qty,
                Damaged_Qty,
                Reorder_Level,
                Reorder_Quantity,
                Inventory_Status,
                Last_Stock_Update
            )
            VALUES
            (
                v_product_id,
                v_warehouse_id,
                FLOOR(50 + RAND()*950),
                FLOOR(RAND()*50),
                FLOOR(RAND()*10),
                FLOOR(80 + RAND()*70),
                FLOOR(100 + RAND()*400),
                IF(RAND() < 0.05, 'Out Of Stock',
                   IF(RAND() < 0.20, 'Low Stock', 'In Stock')),
                DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*90) DAY)
            );

            SET v_product_id = v_product_id + 1;

        END WHILE;

        SET v_warehouse_id = v_warehouse_id + 1;

    END WHILE;

END$$

DELIMITER ;

CALL generate_inventory();

DROP PROCEDURE IF EXISTS generate_inventory_v2;

INSERT INTO inventory
(
    Warehouse_Id,
    Product_Id,
    Available_Qty,
    Reserved_Qty,
    Damaged_Qty,
    Reorder_Level,
    Reorder_Quantity,
    Inventory_Status,
    Last_Stock_Update
)

SELECT
    w.Warehouse_Id,
    p.Product_Id,

    FLOOR(50 + RAND()*950),
    FLOOR(RAND()*50),
    FLOOR(RAND()*10),
    FLOOR(80 + RAND()*70),
    FLOOR(100 + RAND()*400),

    IF(RAND()<0.05,'Out Of Stock',
       IF(RAND()<0.20,'Low Stock','In Stock')),

    DATE_SUB(NOW(),INTERVAL FLOOR(RAND()*90) DAY)

FROM warehouses w
CROSS JOIN products p

WHERE p.Product_Id >= 511;


-- ==========================================
-- Execute : Generate_Inventory
-- Purpose : Generate Inventory Records
-- ==========================================

CALL Generate_Inventory_V2();;

-- ==========================================
-- Verification : Inventory
-- Purpose      : Verify Total Inventory Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Inventory_Records
FROM Inventory;


-- ==========================================
-- Table 9 : Purchase_Orders
-- Purpose : Generate Purchase Order Transactions
-- ==========================================

-- ==========================================
-- Procedure : Generate_Purchase_Orders
-- Purpose   : Generate Purchase Order Transactions
-- ==========================================

DROP PROCEDURE IF EXISTS generate_purchase_orders;

DELIMITER $$

CREATE PROCEDURE generate_purchase_orders()
BEGIN

    DECLARE i INT DEFAULT 1;
    DECLARE v_order_date DATE;
    DECLARE v_expected DATE;
    DECLARE v_actual DATE;
    DECLARE v_amount DECIMAL(15,2);

    WHILE i <= 20000 DO

        SET v_order_date = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY);

        SET v_expected = DATE_ADD(v_order_date, INTERVAL (3 + FLOOR(RAND()*13)) DAY);

        SET v_actual = DATE_ADD(v_expected, INTERVAL FLOOR(RAND()*5) DAY);

        SET v_amount = ROUND(5000 + RAND()*195000,2);

        INSERT INTO purchase_orders
        (
            Po_Number,
            Supplier_Id,
            Warehouse_Id,
            Order_Date,
            Expected_Delivery,
            Actual_Delivery,
            Total_Amount,
            Order_Status,
            Payment_Status
        )

        VALUES
        (
            CONCAT('PO2026',LPAD(i,5,'0')),

            22 + FLOOR(RAND()*150),

            1 + FLOOR(RAND()*25),

            v_order_date,

            v_expected,

            IF(RAND()<0.10,NULL,v_actual),

            v_amount,

            ELT(
                1 + FLOOR(RAND()*5),
                'Pending',
                'Approved',
                'Shipped',
                'Delivered',
                'Cancelled'
            ),

            IF(RAND()<0.80,'Paid','Pending')

        );

        SET i = i + 1;

    END WHILE;

END$$

DELIMITER ;

-- ==========================================
-- Execute : Generate_Purchase_Orders
-- Purpose : Generate Purchase Order Transactions
-- ==========================================

CALL Generate_Purchase_Orders();

-- ==========================================
-- Verification : Purchase Orders
-- Purpose      : Verify Total Purchase Order Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Purchase_Orders
FROM Purchase_Orders;


-- ==========================================
-- Table 10 : Purchase_Order_Items
-- Purpose : Generate Purchase Order Item Transactions
-- ==========================================

-- ==========================================
-- Procedure : Generate_Purchase_Order_Items
-- Purpose   : Generate Purchase Order Item Transactions
-- ==========================================

DELIMITER $$

CREATE PROCEDURE generate_purchase_order_items()
BEGIN

    DECLARE v_po INT DEFAULT 1;

    WHILE v_po <= 20000 DO

        INSERT INTO purchase_order_items
        (
            Po_Id,
            Product_Id,
            Quantity,
            Received_Qty,
            Unit_Price,
            Discount_Percent,
            Tax_Percent,
            Line_Total
        )

        SELECT

            v_po,

            p.Product_Id,

            Qty,

            CASE
                WHEN RAND()<0.80 THEN Qty
                WHEN RAND()<0.95 THEN Qty-FLOOR(1+RAND()*5)
                ELSE Qty-FLOOR(6+RAND()*10)
            END,

            p.Cost_Price,

            Discount,

            18,

            ROUND
            (
            (
            Qty*p.Cost_Price
            )*(1-Discount/100)*(1+18/100)
            ,2)

        FROM
        (

            SELECT
            11+FLOOR(RAND()*5000) Product_Id,
            FLOOR(10+RAND()*91) Qty,
            ROUND(RAND()*15,2) Discount

            UNION

            SELECT
            11+FLOOR(RAND()*5000),
            FLOOR(10+RAND()*91),
            ROUND(RAND()*15,2)

            UNION

            SELECT
            11+FLOOR(RAND()*5000),
            FLOOR(10+RAND()*91),
            ROUND(RAND()*15,2)

        ) x

        JOIN products p

        ON x.Product_Id=p.Product_Id;

        SET v_po=v_po+1;

    END WHILE;

END$$

DELIMITER ;

-- ==========================================
-- Execute : Generate_Purchase_Order_Items
-- Purpose : Generate Purchase Order Item Transactions
-- ==========================================

CALL Generate_Purchase_Order_Items();

-- ==========================================
-- Verification : Purchase Order Items
-- Purpose      : Verify Total Purchase Order Item Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Purchase_Order_Items
FROM Purchase_Order_Items;


-- ==========================================
-- Table 11: Shipments
-- Purpose : Insert Shipment Transaction Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Shipments
-- Purpose   : Generate Shipment Transactions
-- ==========================================
INSERT INTO shipments
(Po_Id, Shipment_Number, Dispatch_Date, Expected_Arrival, Arrival_Date, Transport_Mode, Vehicle_Number, Shipment_Status)

SELECT

    po.Po_Id,

    CONCAT('SHP2026', LPAD(po.Po_Id,6,'0')),

    DATE_ADD(po.Order_Date, INTERVAL (1 + FLOOR(RAND()*3)) DAY),

    DATE_ADD(po.Expected_Delivery, INTERVAL FLOOR(RAND()*3) DAY),

    CASE
        WHEN RAND() < 0.10 THEN NULL
        ELSE DATE_ADD(po.Expected_Delivery, INTERVAL FLOOR(RAND()*4) DAY)
    END,

    ELT(
        1 + FLOOR(RAND()*3),
        'Road',
        'Rail',
        'Air'
    ),

    CONCAT(
        UPPER(CHAR(FLOOR(65+RAND()*26))),
        UPPER(CHAR(FLOOR(65+RAND()*26))),
        FLOOR(1000+RAND()*9000),
        UPPER(CHAR(FLOOR(65+RAND()*26))),
        UPPER(CHAR(FLOOR(65+RAND()*26)))
    ),

    CASE
        WHEN RAND()<0.70 THEN 'Delivered'
        WHEN RAND()<0.90 THEN 'In Transit'
        ELSE 'Delayed'
    END

FROM purchase_orders po;

-- ==========================================
-- Execute : Generate_Shipments
-- Purpose : Generate Shipment Transactions
-- ==========================================

CALL Generate_Shipments();

-- ==========================================
-- Verification : Shipments
-- Purpose      : Verify Total Shipment Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Shipments
FROM Shipments;
 

-- ==========================================
-- Table 12 : Shipment_Tracking
-- Purpose : Insert Shipment Tracking Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Shipment_Tracking
-- Purpose   : Generate Shipment Tracking Records
-- ==========================================
 
INSERT INTO shipment_tracking
(
    Shipment_Id,
    Tracking_Datetime,
    Current_Location,
    Remarks,
    Shipment_Status
)

SELECT
    s.Shipment_Id,
    DATE_ADD(s.Dispatch_Date, INTERVAL t.Step_No DAY),

    CASE t.Step_No
        WHEN 1 THEN 'Origin Warehouse'
        WHEN 2 THEN 'Distribution Hub'
        ELSE 'Destination City'
    END,

    CASE
        WHEN t.Step_No = 1 THEN 'Shipment Dispatched'
        WHEN t.Step_No = 2 THEN 'Shipment In Transit'
        ELSE
            CASE
                WHEN s.Shipment_Status='Delivered' THEN 'Shipment Delivered Successfully'
                WHEN s.Shipment_Status='Delayed' THEN 'Shipment Delayed Due To Logistics'
                ELSE 'Shipment Moving Towards Destination'
            END
    END,

    CASE
        WHEN t.Step_No < 3 THEN 'In Transit'
        ELSE s.Shipment_Status
    END

FROM shipments s

CROSS JOIN
(
    SELECT 1 AS Step_No
    UNION ALL
    SELECT 2
    UNION ALL
    SELECT 3
) t;

-- ==========================================
-- Execute : Generate_Shipment_Tracking
-- Purpose : Generate Shipment Tracking Records
-- ==========================================

CALL Generate_Shipment_Tracking();

-- ==========================================
-- Verification : Shipment Tracking
-- Purpose      : Verify Total Shipment Tracking Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Shipment_Tracking
FROM Shipment_Tracking;

-- ==========================================
-- Table 13 : Store_Orders
-- Purpose : Insert Store Order Transaction Data
-- ==========================================

-- ==========================================
-- Procedure : Generate_Store_Orders
-- Purpose   : Generate Store Order Transactions
-- ==========================================

INSERT INTO store_orders
(
    Store_Id,
    Warehouse_Id,
    Order_Date,
    Required_Date,
    Delivered_Date,
    Order_Status
)

SELECT

    1 + FLOOR(RAND()*100),

    1 + FLOOR(RAND()*25),

    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY) AS Order_Date,

    DATE_ADD(
        DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
        INTERVAL (2 + FLOOR(RAND()*10)) DAY
    ) AS Required_Date,

    CASE
        WHEN RAND() < 0.15 THEN NULL
        ELSE DATE_ADD(
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
            INTERVAL (3 + FLOOR(RAND()*15)) DAY
        )
    END AS Delivered_Date,

    CASE
        WHEN RAND() < 0.60 THEN 'Delivered'
        WHEN RAND() < 0.75 THEN 'Dispatched'
        WHEN RAND() < 0.88 THEN 'Approved'
        WHEN RAND() < 0.97 THEN 'Pending'
        ELSE 'Cancelled'
    END AS Order_Status

FROM
(
    SELECT 1 n
    UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
) a
CROSS JOIN
(
    SELECT 1 n
    UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
) b
CROSS JOIN
(
    SELECT 1 n
    UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
) c
CROSS JOIN
(
    SELECT 1 n
    UNION ALL SELECT 2 UNION ALL SELECT 3
) d

LIMIT 30000;

-- 27,000 aur Store Orders

INSERT INTO store_orders
(
    Store_Id,
    Warehouse_Id,
    Order_Date,
    Required_Date,
    Delivered_Date,
    Order_Status
)
SELECT
    1 + FLOOR(RAND()*100),
    1 + FLOOR(RAND()*25),
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
    DATE_ADD(DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY), INTERVAL FLOOR(3+RAND()*5) DAY),
    CASE
        WHEN RAND() < 0.15 THEN NULL
        ELSE DATE_ADD(DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY), INTERVAL FLOOR(5+RAND()*8) DAY)
    END,
    CASE
        WHEN RAND()<0.60 THEN 'Delivered'
        WHEN RAND()<0.75 THEN 'Dispatched'
        WHEN RAND()<0.88 THEN 'Approved'
        WHEN RAND()<0.97 THEN 'Pending'
        ELSE 'Cancelled'
    END
FROM
products p1
CROSS JOIN products p2
LIMIT 27000;

-- ==========================================
-- Execute : Generate_Store_Orders
-- Purpose : Generate Store Order Transactions
-- ==========================================

CALL Generate_Store_Orders();

-- ==========================================
-- Verification : Store Orders
-- Purpose      : Verify Total Store Order Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Store_Orders
FROM Store_Orders;


-- ==========================================
-- Table 14 : Store_Order_Items
-- Purpose : Insert Store Order Item Transactions
-- ==========================================

-- ==========================================
-- Procedure : Generate_Store_Order_Items
-- Purpose   : Generate Store Order Item Transactions
-- ==========================================

INSERT INTO store_order_items
(
    Store_Order_Id,
    Product_Id,
    Quantity,
    Supplied_Quantity
)

SELECT
    so.Store_Order_Id,

    FLOOR(11 + RAND() * 5000),

    qty,

    CASE
        WHEN RAND() < 0.80 THEN qty
        WHEN RAND() < 0.95 THEN qty - FLOOR(1 + RAND()*5)
        ELSE qty - FLOOR(6 + RAND()*10)
    END

FROM
(
    SELECT
        Store_Order_Id,
        FLOOR(10 + RAND()*91) AS qty
    FROM store_orders
) so

CROSS JOIN
(
    SELECT 1
    UNION ALL
    SELECT 2
    UNION ALL
    SELECT 3
) x;

INSERT INTO store_order_items
(
    Store_Order_Id,
    Product_Id,
    Quantity,
    Supplied_Quantity
)
SELECT
    m.Store_Order_Id,
    FLOOR(11 + RAND()*5000),
    FLOOR(10 + RAND()*91),
    FLOOR(10 + RAND()*91)
FROM missing_store_orders m
CROSS JOIN
(
    SELECT 1
    UNION ALL
    SELECT 2
    UNION ALL
    SELECT 3
) x;

-- ==========================================
-- Execute : Generate_Store_Order_Items
-- Purpose : Generate Store Order Item Transactions
-- ==========================================

CALL Generate_Store_Order_Items();

-- ==========================================
-- Verification : Store Order Items
-- Purpose      : Verify Total Store Order Item Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Store_Order_Items
FROM Store_Order_Items;



-- ==========================================
-- Table 15 : Stock_Transfers
-- Purpose : Insert Stock Transfer Transactions
-- ==========================================

-- ==========================================
-- Procedure : Generate_Stock_Transfers
-- Purpose   : Generate Stock Transfer Transactions
-- ==========================================

INSERT INTO stock_transfers
(
    Transfer_Number,
    From_Warehouse_Id,
    To_Warehouse_Id,
    Transfer_Date,
    Expected_Delivery,
    Received_Date,
    Transfer_Status,
    Remarks
)

SELECT
    CONCAT('TR', LPAD(n,6,'0')),

    From_WH,

    CASE
        WHEN To_WH = From_WH THEN
            CASE
                WHEN From_WH = 25 THEN 24
                ELSE From_WH + 1
            END
        ELSE To_WH
    END,

    Transfer_Date,

    DATE_ADD(Transfer_Date, INTERVAL FLOOR(2+RAND()*5) DAY),

    CASE
        WHEN Status='Received'
        THEN DATE_ADD(Transfer_Date, INTERVAL FLOOR(2+RAND()*7) DAY)
        ELSE NULL
    END,

    Status,

    CASE
        WHEN Status='Cancelled' THEN 'Transfer Cancelled'
        WHEN Status='Pending' THEN 'Awaiting Dispatch'
        WHEN Status='In Transit' THEN 'Goods In Transit'
        ELSE 'Transfer Completed'
    END

FROM
(
    SELECT

        (@row:=@row+1) AS n,

        FLOOR(1+RAND()*25) AS From_WH,

        FLOOR(1+RAND()*25) AS To_WH,

        DATE_SUB(CURDATE(),INTERVAL FLOOR(RAND()*365) DAY) AS Transfer_Date,

        CASE
            WHEN RAND()<0.60 THEN 'Received'
            WHEN RAND()<0.80 THEN 'In Transit'
            WHEN RAND()<0.95 THEN 'Pending'
            ELSE 'Cancelled'
        END AS Status

    FROM
    products p1
    CROSS JOIN products p2,
    (SELECT @row:=0) r

    LIMIT 15000

) x;

-- ==========================================
-- Execute : Generate_Stock_Transfers
-- Purpose : Generate Stock Transfer Transactions
-- ==========================================

CALL Generate_Stock_Transfers();

-- ==========================================
-- Verification : Stock Transfers
-- Purpose      : Verify Total Stock Transfer Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Stock_Transfers
FROM Stock_Transfers;


-- ==========================================
-- Table 16 : Transfer_Items
-- Purpose : Insert Stock Transfer Item Transactions
-- ==========================================

-- ==========================================
-- Procedure : Generate_Transfer_Items
-- Purpose   : Generate Stock Transfer Item Transactions
-- ==========================================

INSERT INTO transfer_items
(
    Transfer_Id,
    Product_Id,
    Quantity
)

SELECT
    st.Transfer_Id,
    FLOOR(11 + RAND()*5000),
    FLOOR(10 + RAND()*490)

FROM stock_transfers st

CROSS JOIN
(
    SELECT 1
    UNION ALL
    SELECT 2
    UNION ALL
    SELECT 3
) x;

-- ==========================================
-- Execute : Generate_Transfer_Items
-- Purpose : Generate Stock Transfer Item Transactions
-- ==========================================

CALL Generate_Transfer_Items();

-- ==========================================
-- Verification : Transfer Items
-- Purpose      : Verify Total Transfer Item Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Transfer_Items
FROM Transfer_Items;


-- ==========================================
-- Table 17 : Damaged_Stock
-- Purpose : Insert Damaged Stock Records
-- ==========================================

-- ==========================================
-- Procedure : Generate_Damaged_Stock
-- Purpose   : Generate Damaged Stock Records
-- ==========================================

INSERT INTO damaged_stock
(
Warehouse_Id,
Product_Id,
Damage_Date,
Quantity,
Damage_Reason,
Action_Taken
)

SELECT
FLOOR(1 + RAND()*25),
p.Product_Id,

DATE_ADD(
'2025-01-01',
INTERVAL FLOOR(RAND()*365) DAY
),

FLOOR(1 + RAND()*50),

CASE 
WHEN RAND() < 0.25 THEN 'Broken'
WHEN RAND() < 0.50 THEN 'Expired'
WHEN RAND() < 0.75 THEN 'Packaging Damage'
ELSE 'Quality Issue'
END,

CASE
WHEN RAND() < 0.5 THEN 'Disposed'
WHEN RAND() < 0.8 THEN 'Returned to Supplier'
ELSE 'Repaired'
END

FROM products p
ORDER BY RAND()
LIMIT 5000;

-- ==========================================
-- Execute : Generate_Damaged_Stock
-- Purpose : Generate Damaged Stock Records
-- ==========================================

CALL Generate_Damaged_Stock();

-- ==========================================
-- Verification : Damaged Stock
-- Purpose      : Verify Total Damaged Stock Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Damaged_Stock
FROM Damaged_Stock;


-- ==========================================
-- Table 18 : Inventory_Audit
-- Purpose : Insert Inventory Audit Records
-- ==========================================

-- ==========================================
-- Procedure : Generate_Inventory_Audit
-- Purpose   : Generate Inventory Audit Records
-- ==========================================

INSERT INTO inventory_audit
(
Inventory_Id,
Old_Quantity,
New_Quantity,
Changed_By,
Change_Date,
Remarks
)

SELECT

i.Inventory_Id,

FLOOR(50 + RAND()*500) AS Old_Quantity,

FLOOR(50 + RAND()*500) AS New_Quantity,

FLOOR(1 + RAND()*500) AS Changed_By,

DATE_ADD(
'2025-01-01',
INTERVAL FLOOR(RAND()*365) DAY
),

CASE
WHEN RAND() < 0.25 THEN 'Stock Verification'
WHEN RAND() < 0.50 THEN 'Manual Adjustment'
WHEN RAND() < 0.75 THEN 'Damaged Stock Update'
ELSE 'Cycle Count Update'
END

FROM inventory i

ORDER BY RAND()

LIMIT 50000;

-- ==========================================
-- Execute : Generate_Inventory_Audit
-- Purpose : Generate Inventory Audit Records
-- ==========================================

CALL Generate_Inventory_Audit();

-- ==========================================
-- Verification : Inventory Audit
-- Purpose      : Verify Total Inventory Audit Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Inventory_Audit
FROM Inventory_Audit;

--- ==========================================
-- Table 19 : Supplier_Performance
-- Purpose : Generate Supplier Performance Records
-- ==========================================

-- ==========================================
-- Procedure : Generate_Supplier_Performance
-- Purpose   : Generate Supplier Performance Records
-- ==========================================

INSERT INTO supplier_performance
(
Supplier_Id,
Performance_Month,
Total_Orders,
On_Time_Delivery_Percent,
Average_Delay_Days,
Supplier_Rating
)

SELECT

s.Supplier_Id,

DATE_ADD(
'2025-01-01',
INTERVAL FLOOR(RAND()*12) MONTH
),

FLOOR(20 + RAND()*200),

ROUND(70 + RAND()*30,2),

ROUND(RAND()*10,2),

ROUND(2.5 + RAND()*2.5,2)

FROM suppliers s

CROSS JOIN
(
SELECT 1
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10
UNION ALL SELECT 11
UNION ALL SELECT 12
) m

LIMIT 10000;

-- ==========================================
-- Verification : Supplier Performance
-- Purpose      : Verify Total Supplier Performance Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Supplier_Performance
FROM Supplier_Performance;

-- ==========================================
-- Table 20 : Warehouse_Capacity
-- Purpose : Generate Warehouse Capacity Records
-- ==========================================

INSERT INTO warehouse_capacity
(
Warehouse_Id,
Total_Capacity,
Used_Capacity,
Available_Capacity,
Recorded_Date
)

SELECT

w.Warehouse_Id,

FLOOR(5000 + RAND()*5000) AS Total_Capacity,

FLOOR(1000 + RAND()*3000) AS Used_Capacity,

0 AS Available_Capacity,

DATE_ADD(
'2025-01-01',
INTERVAL m.month_no MONTH
)

FROM warehouses w

CROSS JOIN
(
SELECT 0 AS month_no
UNION ALL SELECT 1
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10
UNION ALL SELECT 11
) m;

-- ==========================================
-- Verification : Warehouse Capacity
-- Purpose      : Verify Total Warehouse Capacity Records
-- ==========================================

SELECT
    COUNT(*) AS Total_Warehouse_Capacity
FROM Warehouse_Capacity;






