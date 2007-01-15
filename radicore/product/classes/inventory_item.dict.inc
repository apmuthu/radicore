<?php
    // file created on November 3, 2006, 11:29 am
    
    // field specifications for table product.inventory_item
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_product(popup)',
                                                    'foreign_field' => 'product_name');
    
    $fieldspec['inventory_item_id']         = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 32767,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['inv_type']                  = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'inv_type');
    
    $fieldspec['serial_no']                 = array('type' => 'string',
                                                    'size' => 40,
                                                    'uppercase' => 'y');
    
    $fieldspec['qty_on_hand']               = array('type' => 'integer',
                                                    'size' => 11,
                                                    'minvalue' => -2147483648,
                                                    'maxvalue' => 2147483647);
    
    $fieldspec['total_qty']                 = array('type' => 'integer',
                                                    'size' => 11,
                                                    'minvalue' => -2147483648,
                                                    'maxvalue' => 2147483647,
                                                    'noedit' => 'y');
    
    $fieldspec['facility_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_facility(popup)',
                                                    'foreign_field' => 'facility_desc');
    
    $fieldspec['container_id']              = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_container(popup)',
                                                    'foreign_field' => 'container_desc');
    
    $fieldspec['lot_id']                    = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_lot(popup)',
                                                    'foreign_field' => 'lot_desc');
    
    $fieldspec['inv_item_status_id']        = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'inv_item_status_id',
                                                    'noedit' => 'y');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2001-01-01 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'default' => 'UNKNOWN',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['revised_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['revised_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('product_id',
                                                    'inventory_item_id');
    
    // unique key details 
    $this->unique_keys[]                    = array('product_id',
                                                    'serial_no');
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'inventory_item_status_hist',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id',
                                                                      'inventory_item_id' => 'inventory_item_id'));
    
    $this->child_relations[]                = array('child' => 'inventory_item_variance',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id',
                                                                      'inventory_item_id' => 'inventory_item_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'container',
                                                    'parent_field' => 'container_desc',
                                                    'fields' => array('facility_id' => 'facility_id',
                                                                      'container_id' => 'container_id'));
    
    $this->parent_relations[]               = array('parent' => 'facility',
                                                    'parent_field' => 'facility_desc',
                                                    'fields' => array('facility_id' => 'facility_id'));
    
    $this->parent_relations[]               = array('parent' => 'lot',
                                                    'parent_field' => 'lot_id AS lot_desc',
                                                    'fields' => array('lot_id' => 'lot_id'));
    
    $this->parent_relations[]               = array('parent' => 'product',
                                                    'parent_field' => 'product_name',
                                                    'fields' => array('product_id' => 'product_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>