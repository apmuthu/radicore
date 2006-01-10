<?php
    // file created on July 24, 2005, 8:56 pm
    
    // field specifications for table product.price_component
    $fieldspec['price_component_id']        = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['start_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00');
    
    $fieldspec['end_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'infinityisnull' => 'y');
    
    $fieldspec['price']                     = array('type' => 'numeric',
                                                    'size' => 13,
                                                    'precision' => 11,
                                                    'scale' => 2,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 999999999.99);
    
    $fieldspec['percent']                   = array('type' => 'numeric',
                                                    'size' => 8,
                                                    'precision' => 6,
                                                    'scale' => 3,
                                                    'blank_when_zero' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 100);
    
    $fieldspec['price_type']                = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'price_type');
    
    $fieldspec['price_frequency']           = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'price_frequency');
    
    $fieldspec['uom_id']                    = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_uom(popup)',
                                                    'foreign_field' => 'uom_desc');
    
    $fieldspec['quantity']                  = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_product(popup)',
                                                    'foreign_field' => 'product_name');
    
    $fieldspec['prod_feature_id']           = array('type' => 'integer',
                                                    'size' => 8,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 16777215,
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_prod_feature(popup)',
                                                    'foreign_field' => 'prod_feature_desc');
    
    $fieldspec['prod_cat_id']               = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'prod_cat_id');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['revised_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['revised_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('price_component_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'product',
                                                    'parent_field' => 'product_name',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->parent_relations[]               = array('parent' => 'product_category',
                                                    'parent_field' => 'prod_cat_desc',
                                                    'fields' => array('prod_cat_id' => 'prod_cat_id'));
    
    $this->parent_relations[]               = array('parent' => 'product_feature',
                                                    'parent_field' => 'prod_feature_desc',
                                                    'fields' => array('prod_feature_id' => 'prod_feature_id'));
    
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'parent_field' => 'uom_desc',
                                                    'fields' => array('uom_id' => 'uom_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>