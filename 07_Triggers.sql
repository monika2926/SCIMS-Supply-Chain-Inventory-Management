-- ==========================================================
-- Project  : Supply Chain & Inventory Management System
-- Code     : SCIMS
-- Database : SCIMS
-- File     : 07_Triggers.sql
-- Purpose  : Create Database Triggers
-- ==========================================================


-- ==========================================
-- Trigger 1 : TRG_Update_Inventory_After_Purchase
-- Purpose   : Update Inventory After Purchase Receipt
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Update_Inventory_After_Purchase;

DELIMITER $$

CREATE TRIGGER TRG_Update_Inventory_After_Purchase
AFTER INSERT
ON purchase_order_items
FOR EACH ROW
BEGIN

    UPDATE inventory
    SET
        Available_Qty = Available_Qty + NEW.Received_Qty,
        Last_Stock_Update = CURRENT_TIMESTAMP
    WHERE Product_Id = NEW.Product_Id;

END$$

DELIMITER ;


-- ==========================================
-- Trigger 2 : TRG_Prevent_Negative_Stock
-- Purpose   : Prevent Negative Inventory Quantity
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Prevent_Negative_Stock;

DELIMITER $$

CREATE TRIGGER TRG_Prevent_Negative_Stock
BEFORE UPDATE
ON inventory
FOR EACH ROW
BEGIN

    IF NEW.Available_Qty < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Available Stock Cannot Be Negative';
    END IF;

END$$

DELIMITER ;

-- ==========================================
-- Trigger 3 : TRG_Update_Inventory_After_Transfer
-- Purpose   : Reduce Inventory After Stock Transfer
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Update_Inventory_After_Transfer;

DELIMITER $$

CREATE TRIGGER TRG_Update_Inventory_After_Transfer
AFTER INSERT
ON transfer_items
FOR EACH ROW
BEGIN

    UPDATE inventory
    SET
        Available_Qty = Available_Qty - NEW.Quantity,
        Last_Stock_Update = CURRENT_TIMESTAMP
    WHERE Product_Id = NEW.Product_Id;

END$$

DELIMITER ;

-- ==========================================
-- Trigger 4 : TRG_Update_Inventory_After_Store_Order
-- Purpose   : Reduce Inventory After Store Order Dispatch
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Update_Inventory_After_Store_Order;

DELIMITER $$

CREATE TRIGGER TRG_Update_Inventory_After_Store_Order
AFTER INSERT
ON store_order_items
FOR EACH ROW
BEGIN

    UPDATE inventory
    SET
        Available_Qty = Available_Qty - NEW.Supplied_Quantity,
        Last_Stock_Update = CURRENT_TIMESTAMP
    WHERE Product_Id = NEW.Product_Id;

END$$

DELIMITER ;


-- ==========================================
-- Trigger 5 : TRG_Update_Inventory_After_Shipment
-- Purpose   : Update Inventory After Shipment Delivery
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Update_Inventory_After_Shipment;

DELIMITER $$

CREATE TRIGGER TRG_Update_Inventory_After_Shipment
AFTER UPDATE
ON shipments
FOR EACH ROW
BEGIN

    IF NEW.Shipment_Status = 'Delivered'
       AND OLD.Shipment_Status <> 'Delivered' THEN

        UPDATE inventory i
        INNER JOIN purchase_order_items poi
            ON i.Product_Id = poi.Product_Id
        SET
            i.Available_Qty = i.Available_Qty + poi.Received_Qty,
            i.Last_Stock_Update = CURRENT_TIMESTAMP
        WHERE
            poi.Po_Id = NEW.Po_Id;

    END IF;

END$$

DELIMITER ;


-- ==========================================
-- Trigger 6 : TRG_Audit_Inventory_Update
-- Purpose   : Record Inventory Update History
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Audit_Inventory_Update;

DELIMITER $$

CREATE TRIGGER TRG_Audit_Inventory_Update
AFTER UPDATE
ON inventory
FOR EACH ROW
BEGIN

    INSERT INTO inventory_audit
    (
        Inventory_Id,
        Product_Id,
        Warehouse_Id,
        Old_Available_Qty,
        New_Available_Qty,
        Updated_At
    )
    VALUES
    (
        OLD.Inventory_Id,
        OLD.Product_Id,
        OLD.Warehouse_Id,
        OLD.Available_Qty,
        NEW.Available_Qty,
        CURRENT_TIMESTAMP
    );

END$$

DELIMITER ;

-- ==========================================
-- Trigger 7 : TRG_Product_Price_Update
-- Purpose   : Update Product Modified Timestamp
-- ==========================================
DROP TRIGGER IF EXISTS TRG_Product_Price_Update;

DELIMITER $$

CREATE TRIGGER TRG_Product_Price_Update
BEFORE UPDATE
ON products
FOR EACH ROW
BEGIN

    IF NEW.Cost_Price <> OLD.Cost_Price
       OR NEW.Selling_Price <> OLD.Selling_Price THEN

        SET NEW.Updated_At = CURRENT_TIMESTAMP;

    END IF;

END$$

DELIMITER ;

-- ==========================================
-- Trigger 8 : TRG_Supplier_Status_Update
-- Purpose   : Update Supplier Modified Timestamp
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Supplier_Status_Update;

DELIMITER $$

CREATE TRIGGER TRG_Supplier_Status_Update
BEFORE UPDATE
ON suppliers
FOR EACH ROW
BEGIN

    IF NEW.Status <> OLD.Status THEN

        SET NEW.Updated_At = CURRENT_TIMESTAMP;

    END IF;

END$$

DELIMITER ;

-- ==========================================
-- Trigger 9 : TRG_Warehouse_Capacity_Check
-- Purpose   : Prevent Warehouse Capacity Overflow
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Warehouse_Capacity_Check;

DELIMITER $$

CREATE TRIGGER TRG_Warehouse_Capacity_Check
BEFORE UPDATE
ON warehouses
FOR EACH ROW
BEGIN

    IF NEW.Current_Capacity > NEW.Storage_Capacity THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Current Capacity Cannot Exceed Storage Capacity';

    END IF;

END$$

DELIMITER ;

-- ==========================================
-- Trigger 10 : TRG_Update_Last_Stock_Modified
-- Purpose    : Update Inventory Modification Timestamp
-- ==========================================

DROP TRIGGER IF EXISTS TRG_Update_Last_Stock_Modified;

DELIMITER $$

CREATE TRIGGER TRG_Update_Last_Stock_Modified
BEFORE UPDATE
ON inventory
FOR EACH ROW
BEGIN

    SET NEW.Last_Stock_Update = CURRENT_TIMESTAMP;

END$$

DELIMITER ;