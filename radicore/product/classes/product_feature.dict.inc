<?php
    // file created on November 3, 2006, 11:29 am
    
    // field specifications for table product.product_feature
    $fieldspec['prod_feature_id']           = array('type' => 'integer',
                                                    'size' => 9,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 16777215,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['prod_feature_desc']         = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['prod_feature_cat_id']       = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'prod_feature_cat_id');
    
    $fieldspec['uom_id']                    = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'uom_id');
    
    $fieldspec['measurement']               = array('type' => 'float',
                                                    'size' => 21);
    
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
    $this->primary_key                      = array('prod_feature_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'price_component',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_feature_id' => 'prod_feature_id'));
    
    $this->child_relations[]                = array('child' => 'prod_feature_applicability',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_feature_id' => 'prod_feature_id'));
    
    $this->child_relations[]                = array('child' => 'prod_feature_interaction',
                                                    'alias' => 'prod_feature_interaction_snr',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_feature_id' => 'prod_feature_id_snr'));
    
    $this->child_relations[]                = array('child' => 'prod_feature_interaction',
                                                    'alias' => 'prod_feature_interaction_jnr',
                                                    'type' => 'RES',
                                                    'fields' => array('prod_feature_id' => 'prod_feature_id_jnr'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'product_feature_category',
                                                    'parent_field' => 'prod_feature_cat_desc, measurement_reqd',
                                                    'fields' => array('prod_feature_cat_id' => 'prod_feature_cat_id'));
    
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'parent_field' => 'uom_desc, uom_abbrev',
                                                    'fields' => array('uom_id' => 'uom_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>