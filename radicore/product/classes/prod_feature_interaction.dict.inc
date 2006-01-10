<?php
    // file created on April 24, 2005, 5:06 pm
    
    // field specifications for table product.prod_feature_interaction
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['prod_feature_id_snr']       = array('type' => 'integer',
                                                    'size' => 9,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 16777215,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_prod_feature(popup)snr',
                                                    'foreign_field' => 'prod_feature_desc_snr');
    
    $fieldspec['prod_feature_id_jnr']       = array('type' => 'integer',
                                                    'size' => 9,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 16777215,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_prod_feature(popup)jnr',
                                                    'foreign_field' => 'prod_feature_desc_jnr');
    
    $fieldspec['feature_interaction']       = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'feature_interaction');
    
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
    $this->primary_key                      = array('product_id',
                                                    'prod_feature_id_snr',
                                                    'prod_feature_id_jnr');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'product',
                                                    'parent_field' => 'product_name',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->parent_relations[]               = array('parent' => 'product_feature',
                                                    'parent_field' => 'prod_feature_desc as prod_feature_desc_snr',
                                                    'fields' => array('prod_feature_id_snr' => 'prod_feature_id'));
    
    $this->parent_relations[]               = array('parent' => 'product_feature',
                                                    'parent_field' => 'prod_feature_desc as prod_feature_desc_jnr',
                                                    'fields' => array('prod_feature_id_jnr' => 'prod_feature_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>