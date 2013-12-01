SELECT SQL_CALC_FOUND_ROWS 
       inventory_item.*, 
       container.container_desc, 
       facility.facility_desc, 
       lot.lot_id AS lot_desc, 
       product.product_name 
FROM inventory_item 
LEFT JOIN container ON (container.facility_id=inventory_item.facility_id AND container.container_id=inventory_item.container_id) 
LEFT JOIN facility ON (facility.facility_id=inventory_item.facility_id) 
LEFT JOIN lot ON (lot.lot_id=inventory_item.lot_id) 
LEFT JOIN product ON (product.product_id=inventory_item.product_id)    
ORDER BY inventory_item.product_id, inventory_item.inventory_item_id asc LIMIT 10 OFFSET 0 