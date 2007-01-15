<?php
    // file created on November 3, 2006, 11:29 am
    
    // field specifications for table product.product_category
    $fieldspec['prod_cat_id']               = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['prod_cat_desc']             = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['product_usage']             = array('type' => 'string',
                                                    'size' => 16);
    
    $fieldspec['product_industry']          = array('type' => 'string',
                                                    'size' => 16);
    
    $fieldspec['product_materials']         = array('type' => 'string',
                                                    'size' => 16);
    
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
    $this->primary_key                      = array('prod_cat_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'price_component',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_cat_id' => 'prod_cat_id'));
    
    $this->child_relations[]                = array('child' => 'prod_cat_class',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_cat_id' => 'prod_cat_id'));
    
    $this->child_relations[]                = array('child' => 'prod_cat_rollup',
                                                    'alias' => 'prod_cat_rollup_snr',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_cat_id' => 'prod_cat_id_snr'));
    
    $this->child_relations[]                = array('child' => 'prod_cat_rollup',
                                                    'alias' => 'prod_cat_rollup_jnr',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_cat_id' => 'prod_cat_id_jnr'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>