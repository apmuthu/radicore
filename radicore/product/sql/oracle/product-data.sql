ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SET SCAN OFF;

ALTER SESSION SET CURRENT_SCHEMA = "PRODUCT";

-- 
-- Dumping data for table container
-- 

INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 'Room 101', 5, '2006-07-03 14:00:26', 'AJM', NULL, NULL);
INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 'Room 102', 5, '2006-07-03 14:03:19', 'AJM', NULL, NULL);
INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 'Drawer 27a, General office', 2, '2006-07-03 14:03:53', 'AJM', NULL, NULL);
INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 'Bin 100', 3, '2006-07-03 14:04:17', 'AJM', NULL, NULL);
INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 'Bin 200', 3, '2006-07-03 14:04:26', 'AJM', NULL, NULL);
INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 'Bin 300', 3, '2006-07-03 14:04:34', 'AJM', NULL, NULL);
INSERT INTO container (facility_id, container_id, container_desc, container_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 'Bin 400', 3, '2006-07-03 14:04:45', 'AJM', NULL, NULL);

-- 
-- Dumping data for table container_type
-- 

INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 'Shelf', '2006-06-30 17:44:48', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 'File Drawer', '2006-06-30 17:45:09', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 'Bin', '2006-06-30 17:45:14', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (4, 'Barrel', '2006-06-30 17:45:21', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (5, 'Room', '2006-06-30 17:45:25', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (6, '*unspecified*', '2006-06-30 18:35:19', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (7, 'Box', '2006-06-30 18:36:08', 'AJM', NULL, NULL);
INSERT INTO container_type (container_type_id, container_type_desc, created_date, created_user, revised_date, revised_user) VALUES (8, 'Cupboard', '2006-06-30 18:36:31', 'AJM', NULL, NULL);

-- 
-- Dumping data for table facility
-- 

INSERT INTO facility (facility_id, facility_desc, facility_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 'ABC Corporation, 100 Main Street', 1, '2006-06-30 17:24:26', 'AJM', NULL, NULL);
INSERT INTO facility (facility_id, facility_desc, facility_type_id, created_date, created_user, revised_date, revised_user) VALUES (2, 'XYZ Corporation, 101 Main Street', 2, '2006-06-30 17:24:47', 'AJM', NULL, NULL);

-- 
-- Dumping data for table facility_type
-- 

INSERT INTO facility_type (facility_type_id, facility_type_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 'Warehouse', '2006-06-30 16:57:28', 'AJM', NULL, NULL);
INSERT INTO facility_type (facility_type_id, facility_type_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 'Office', '2006-06-30 16:57:34', 'AJM', NULL, NULL);
INSERT INTO facility_type (facility_type_id, facility_type_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 'Depot', '2006-07-09 14:14:59', 'AJM', NULL, NULL);

-- 
-- Dumping data for table good_identification
-- 

INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'MANUF', 'MAN001', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'SKU', 'SKU001', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'MANUF', 'MAN002', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'SKU', 'SKU002', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'MANUF', 'MAN003', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'SKU', 'SKU003', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'MANUF', 'MAN004', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'SKU', 'SKU004', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'MANUF', 'MAN005', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'SKU', 'SKU005', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'MANUF', 'MAN006', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'SKU', 'SKU006', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table good_identity_type
-- 

INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('MANUF', 'Manufacturer''s ID number', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('UPCA', 'Universal Product Code - America', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('UPCE', 'Universal Product Code - Europe', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('SKU', 'Stock Keeping Unit', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ISBN', 'International Standard Book Number', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table inventory_item
-- 

INSERT INTO inventory_item (product_id, inventory_item_id, inv_type, serial_no, qty_on_hand, total_qty, facility_id, container_id, lot_id, inv_item_status_id, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 1, 'N', NULL, 100, 100, 1, 1, NULL, 1, '2006-07-03 16:14:28', 'AJM', '2006-07-08 20:44:20', 'AJM');
INSERT INTO inventory_item (product_id, inventory_item_id, inv_type, serial_no, qty_on_hand, total_qty, facility_id, container_id, lot_id, inv_item_status_id, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 1, 'S', 'QBY00001LC', 1, 1, 2, 2, NULL, 2, '2006-07-03 16:21:15', 'AJM', '2006-07-09 11:50:05', 'AJM');
INSERT INTO inventory_item (product_id, inventory_item_id, inv_type, serial_no, qty_on_hand, total_qty, facility_id, container_id, lot_id, inv_item_status_id, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 1, 'N', NULL, 185, 200, 1, 2, NULL, 1, '2006-07-09 11:33:45', 'AJM', '2006-07-10 10:35:09', 'AJM');
INSERT INTO inventory_item (product_id, inventory_item_id, inv_type, serial_no, qty_on_hand, total_qty, facility_id, container_id, lot_id, inv_item_status_id, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 1, 'N', NULL, 100, 100, 1, 3, NULL, 1, '2006-07-09 11:34:19', 'AJM', NULL, NULL);
INSERT INTO inventory_item (product_id, inventory_item_id, inv_type, serial_no, qty_on_hand, total_qty, facility_id, container_id, lot_id, inv_item_status_id, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 1, 'S', 'FUBAR001', 1, 1, 2, 1, NULL, 1, '2006-07-09 11:42:34', 'AJM', '2006-07-09 11:49:43', 'AJM');

-- 
-- Dumping data for table inventory_item_status
-- 

INSERT INTO inventory_item_status (inv_item_status_id, inv_item_status_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 'OK', '2006-07-02 14:51:24', 'AJM', NULL, NULL);
INSERT INTO inventory_item_status (inv_item_status_id, inv_item_status_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 'Being Repaired', '2006-07-02 14:51:47', 'AJM', NULL, NULL);
INSERT INTO inventory_item_status (inv_item_status_id, inv_item_status_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 'Damaged', '2006-07-02 14:51:59', 'AJM', NULL, NULL);
INSERT INTO inventory_item_status (inv_item_status_id, inv_item_status_desc, created_date, created_user, revised_date, revised_user) VALUES (4, 'Defective', '2006-07-02 14:52:06', 'AJM', NULL, NULL);
INSERT INTO inventory_item_status (inv_item_status_id, inv_item_status_desc, created_date, created_user, revised_date, revised_user) VALUES (5, 'Scrap', '2006-07-02 14:52:11', 'AJM', NULL, NULL);

-- 
-- Dumping data for table inventory_item_status_hist
-- 

INSERT INTO inventory_item_status_hist (product_id, inventory_item_id, seq_no, inv_item_status_id, status_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 1, 1, 3, '2006-07-01', '2006-07-06 16:42:13', 'AJM', NULL, NULL);
INSERT INTO inventory_item_status_hist (product_id, inventory_item_id, seq_no, inv_item_status_id, status_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 1, 2, 2, '2006-07-02', '2006-07-06 16:42:24', 'AJM', NULL, NULL);

-- 
-- Dumping data for table inventory_item_variance
-- 

INSERT INTO inventory_item_variance (product_id, inventory_item_id, seq_no, inv_var_reason_id, inventory_date, variance_qty, var_comment, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 1, 1, 4, '2006-07-09', -15, 'Fell of shelf into a bucket of water', '2006-07-09 20:50:31', 'AJM', '2006-07-10 10:33:19', 'AJM');

-- 
-- Dumping data for table inventory_variance_reason
-- 

INSERT INTO inventory_variance_reason (inv_var_reason_id, inv_var_reason_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 'Unknown variance', '2006-07-02 13:52:55', 'AJM', NULL, NULL);
INSERT INTO inventory_variance_reason (inv_var_reason_id, inv_var_reason_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 'Theft', '2006-07-02 13:53:03', 'AJM', NULL, NULL);
INSERT INTO inventory_variance_reason (inv_var_reason_id, inv_var_reason_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 'Shrinkage', '2006-07-02 13:53:17', 'AJM', NULL, NULL);
INSERT INTO inventory_variance_reason (inv_var_reason_id, inv_var_reason_desc, created_date, created_user, revised_date, revised_user) VALUES (4, 'Damaged', '2006-07-02 13:53:23', 'AJM', NULL, NULL);

-- 
-- Dumping data for table lot
-- 

INSERT INTO lot (lot_id, quantity, manuf_date, expiry_date, created_date, created_user, revised_date, revised_user) VALUES (101, 1000, '2006-07-01', '9999-12-31', '2006-07-02 15:48:46', 'AJM', '2006-07-02 18:40:14', 'AJM');
INSERT INTO lot (lot_id, quantity, manuf_date, expiry_date, created_date, created_user, revised_date, revised_user) VALUES (102, 1000, '2006-07-02', '9999-12-31', '2006-07-02 15:49:15', 'AJM', '2006-07-02 18:40:17', 'AJM');

-- 
-- Dumping data for table price_component
-- 

INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (1, '2000-01-01', '2000-12-31', 2.00, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (2, '2001-01-01', '2001-12-31', 2.50, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (3, '2002-01-01', '2002-12-31', 2.99, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (4, '2003-01-01', '2003-12-31', 3.50, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (5, '2004-01-01', '9999-12-31', 3.99, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (6, '2000-01-01', '2000-12-31', 50.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (7, '2001-01-01', '2001-12-31', 45.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (8, '2002-01-01', '9999-12-31', 40.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (9, '2000-01-01', '2000-12-31', 150.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (10, '2001-01-01', '2001-12-31', 140.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (11, '2002-01-01', '9999-12-31', 130.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (12, '2002-01-01', '2003-12-31', 5.99, NULL, 'B', '1', NULL, NULL, 'PEN202', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (13, '2004-01-01', '9999-12-31', 6.99, NULL, 'B', '1', NULL, NULL, 'PEN202', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (14, '2004-01-01', '9999-12-31', 0.50, NULL, 'S', '1', NULL, NULL, 'PAP192', 7, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (15, '2002-01-01', '2002-12-31', 1000.00, NULL, 'B', '1', NULL, NULL, 'PC101', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (16, '2003-01-01', '9999-12-31', 1100.00, NULL, 'B', '1', NULL, NULL, 'PC101', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (17, '2002-01-01', '9999-12-31', 500.00, NULL, 'B', 'R', 'DAY', NULL, NULL, NULL, 'CONSULT', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (18, '2004-01-01', '9999-12-31', 400.00, NULL, 'D', 'R', 'DAY', NULL, NULL, 19, 'CONSULT', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (19, '2000-01-01', '2000-12-31', 90.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (20, '2001-01-01', '2001-12-31', 91.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (21, '2002-01-01', '2002-12-31', 92.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (22, '2003-01-01', '2003-12-31', 94.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (23, '2004-01-01', '9999-12-31', 95.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table prod_cat_class
-- 

INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'PAPER', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'PC1', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'PEN', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'STUFF', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'COMPUTER', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 'CONSULT', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'OFFICE', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'STUFF1', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'PC1', 1, 'Y', NULL, '2004-03-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'STUFF2', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1A', 'STUFF1A', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1B', 'STUFF1B', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2A', 'STUFF2A', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'STUFF2B', 1, 'Y', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', '2006-06-27 17:50:53', 'AJM');
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'OFFICE', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2006-06-27 14:26:28', 'AJM', '2006-06-27 14:26:42', 'AJM');
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, pcc_comment, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'PAPER', 1, 'N', NULL, '2006-06-27', '9999-12-31', '2006-06-27 17:48:38', 'AJM', '2006-06-27 17:50:53', 'AJM');

-- 
-- Dumping data for table prod_cat_rollup
-- 

INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('OFFICE', 'PEN', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('OFFICE', 'PAPER', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('COMPUTER', 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('COMPUTER', 'PC2', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'STUFF1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'STUFF2', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'STUFF1A', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'STUFF1B', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'STUFF2A', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'STUFF2B', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table prod_feature_applicability
-- 

INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 20, 1, 'S', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 21, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 20, 1, 'S', '2000-01-01', '2001-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 21, 1, 'S', '2002-01-01', '2003-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 22, 1, 'S', '2004-01-01', '2004-03-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 22, 2, 'S', '2004-04-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 5, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 4, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 14, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 6, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 7, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 2, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 10, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 11, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 12, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 8, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 13, 1, 'S', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 2, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 15, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 1, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 18, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 16, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 9, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 17, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table prod_feature_interaction
-- 

INSERT INTO prod_feature_interaction (product_id, prod_feature_id_snr, prod_feature_id_jnr, feature_interaction, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 20, 21, 'I', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_interaction (product_id, prod_feature_id_snr, prod_feature_id_jnr, feature_interaction, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 21, 22, 'I', '2006-06-27 15:04:58', 'AJM', NULL, NULL);

-- 
-- Dumping data for table product
-- 

INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'Johnson fine grade 8.5 by 11 inch bond paper', NULL, NULL, NULL, NULL, 'G', 'REAM', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'Goldstein Elite pen', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'Jerry''s box of 3.5-inch diskettes', NULL, NULL, NULL, NULL, 'G', 'BOX', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'Preprinted forms for insurance claims', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 'Office supply inventory management consulting service', NULL, NULL, NULL, NULL, 'S', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'Laptop Computer', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'Desktop Computer', '2004-03-01', NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'Stuff', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'Stuff 1', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'Stuff 2', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1A', 'Stuff 1a', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1B', 'Stuff 1b', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2A', 'Stuff 2a', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, prod_comment, product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'Stuff 2b', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table product_category
-- 

INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('OFFICE', 'Office Supplies', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PEN', 'Pens', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PAPER', 'Paper', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('COMPUTER', 'Computer Supplies', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('CONSULT', 'Consultancy Services', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('FORMS', 'Forms', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('INS', 'Insurance', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PC1', 'Computer Hardware', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PC2', 'Computer Software', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'Stuff', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'Stuff 1', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'Stuff 2', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1A', 'Stuff 1a', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1B', 'Stuff 1b', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2A', 'Stuff 2a', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'Stuff 2b', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table product_feature
-- 

INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (1, 'Red', 'COLOUR', NULL, 1.23458, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (2, 'Blue', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (3, 'Green', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (4, '8.5in Wide', 'DIM', 'INCH', 8.5, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (5, '11in Long', 'DIM', 'INCH', 11, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (6, 'Fine Grade', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (7, 'Extra Glossy Finish', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (8, 'Fine Point', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (9, 'Expert', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (10, 'Grey', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (11, 'Cream', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (12, 'White', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (13, 'Black', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (14, 'Johnson', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (15, 'Goldstein', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (16, 'Jerry''s', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (17, 'ABC Corporation', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (18, '3.5in Diameter', 'DIM', 'INCH', 3.5, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (19, 'Junior', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (20, 'CD-ROM drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (21, 'DVD-ROM drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (22, 'DVD-RW drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (23, 'Small', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (24, 'Medium', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (25, 'Large', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (26, 'Extra Large', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (27, 'Post & Package', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (28, 'Delivery - Standard', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (29, 'Delivery - Express', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table product_feature_category
-- 

INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('BILL', 'Billing Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('BRAND', 'Brand', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('COLOUR', 'Colour', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('DIM', 'Dimension', 'Y', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('HARD', 'Hardware Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('QUAL', 'Quality', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('SIZE', 'Size', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('SOFT', 'Software Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('STYLE', 'Style', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table unit_of_measure
-- 

INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('AMP', 'ELEC', 'amp', 'Ampere', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('BOX', 'VOL', 'BOX', 'Box', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CENTILITRE', 'VOL', 'cl', 'Centilitre', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'LEN', 'cm', 'Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_CC', 'VOL', 'cc', 'Cubic Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_FT', 'VOL', 'Cu. Ft.', 'Cubic Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_INCH', 'VOL', 'Cu. In.', 'Cubic Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_M', 'VOL', 'Cu. M', 'Cubic Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_YD', 'VOL', 'Cu. Yd.', 'Cubic Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('DAY', 'TIME', 'day', 'per Day', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'LEN', 'dm', 'Decimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('EACH', 'MISC', 'Each', 'Each', '2004-03-01 12:00:00', 'AJM', '2006-07-09 11:31:35', 'AJM');
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('FLUIDOUNCE', 'VOL', 'Floz', 'Fluid Ounce', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('FOOT', 'LEN', 'Ft', 'Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'VOL', 'Gal', 'Gallon (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'VOL', 'Gal', 'Gallon (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('GRAM', 'WEIG', 'gm', 'Gram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('HOUR', 'TIME', 'Hour', 'per Hour', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWEIGHT', 'WEIG', 'cwt', 'Hundredweight', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWT(US)', 'WEIG', 'cwt', 'Hundredweight (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('INCH', 'LEN', 'in', 'Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('KILOGRAM', 'WEIG', 'kg', 'Kilogram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('KILOWATT', 'ELEC', 'Kw', 'Kilowatt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('LITRE', 'VOL', 'lt', 'Litre', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'LEN', 'm', 'Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('MILLIGRAM', 'WEIG', 'mg', 'Milligram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'LEN', 'mm', 'Millimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('MONTH', 'TIME', 'month', 'per Month', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('OHM', 'ELEC', 'ohm', 'Ohm', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('OUNCE', 'WEIG', 'oz', 'Ounce Avoirdupois', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('PINT', 'VOL', 'pt', 'Pint (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('PINT(US)', 'VOL', 'pt', 'Pint (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('POUND', 'WEIG', 'lb', 'Pound Avoirdupois', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('QUART', 'VOL', 'Qt', 'Quart (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('QUART(US)', 'VOL', 'Qt', 'Quart (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('REAM', 'VOL', 'Ream', 'Ream', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SHEET', 'VOL', 'Sheet', 'Sheet', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_CM', 'AREA', 'Sq. Cm.', 'Square Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_FOOT', 'AREA', 'Sq. Ft.', 'Square Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_INCH', 'AREA', 'Sq. In.', 'Square Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_M', 'AREA', 'Sq. M.', 'Square Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_YARD', 'AREA', 'Sq. Yd.', 'Square Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('STONE', 'WEIG', 'st', 'Stone', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('TON', 'WEIG', 'ton', 'Short Ton (UK)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('TON(L)', 'WEIG', 'ton', 'Long Ton (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('TONNE', 'WEIG', 'tonne', 'Metric Tonne', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('VOLT', 'ELEC', 'V', 'Volt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('WATT', 'ELEC', 'watt', 'Watt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('YARD', 'LEN', 'yd', 'Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table uom_category
-- 

INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('VOL', 'Volume/Capacity', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('WEIG', 'Weight', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('LEN', 'Length', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('AREA', 'Area', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('TIME', 'Time', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('ELEC', 'Electrical', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('MISC', 'Miscellaneous', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('SPEE', 'Speed', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- 
-- Dumping data for table uom_conversion
-- 

INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'METER', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'CENTIMETER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'METER', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'DECIMETER', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'DECIMETER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'METER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'CENTIMETER', 0.100000001490116, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'MILLIMETER', 0.00999999977648258, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'DECIMETER', 0.100000001490116, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'CENTIMETER', 0.00999999977648258, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'MILLIMETER', 0.00100000004749745, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'MILLIMETER', 0.100000001490116, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('FOOT', 'INCH', 12, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('YARD', 'FOOT', 3, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('YARD', 'INCH', 36, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('FOOT', 'YARD', 0.33333333333333, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('INCH', 'FOOT', 0.083333333333333, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('INCH', 'YARD', 0.027777777777777, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('PINT', 'FLUIDOUNCE', 20, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('PINT(US)', 'FLUIDOUNCE', 16, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'QUART', 4, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'PINT', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'FLUIDOUNCE', 160, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'QUART(US)', 4, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'PINT(US)', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'FLUIDOUNCE', 128, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('KILOGRAM', 'GRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GRAM', 'MILLIGRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TONNE', 'KILOGRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TONNE', 'MILLIGRAM', 1000000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TON', 'HUNDREDWEIGHT', 20, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TON', 'POUND', 2240, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('POUND', 'OUNCE', 16, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('STONE', 'POUND', 14, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TON(L)', 'POUND', 2000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWEIGHT', 'STONE', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWEIGHT', 'POUND', 112, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWT(US)', 'POUND', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWT(US)', 'STONE', 7.1428571428571, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('REAM', 'SHEET', 500, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
