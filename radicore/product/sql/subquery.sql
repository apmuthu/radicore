SELECT inventory_item.*, product.product_name, unit_of_measure.uom_abbrev, 
       CASE WHEN inventory_item_status_hist.inv_item_status_id IS NULL THEN '1' ELSE inventory_item_status_hist.inv_item_status_id END AS inv_item_status_id,
       inventory_item_status_hist.status_date
FROM inventory_item 
LEFT JOIN product ON (product.product_id=inventory_item.product_id) 
LEFT JOIN unit_of_measure ON (unit_of_measure.uom_id=product.uom_id) 
LEFT JOIN inventory_item_status_hist ON (inventory_item_status_hist.product_id=inventory_item.product_id 
                                    AND inventory_item_status_hist.inventory_item_id=inventory_item.inventory_item_id
                                    AND inventory_item_status_hist.status_date = (select max(status_date) FROM inventory_item_status_hist WHERE inventory_item_status_hist.product_id=inventory_item.product_id AND inventory_item_status_hist.inventory_item_id=inventory_item.inventory_item_id)) 
ORDER BY inventory_item.product_id, inventory_item.inventory_item_id asc LIMIT 10 OFFSET 0