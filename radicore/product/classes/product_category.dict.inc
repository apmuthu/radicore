<?php
    // file created on April 24, 2005, 5:06 pm
    
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
                                                    'type' => 'RES',
                                                    'fields' => array('prod_cat_id' => 'prod_cat_id_snr'));
    
    $this->child_relations[]                = array('child' => 'prod_cat_rollup',
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