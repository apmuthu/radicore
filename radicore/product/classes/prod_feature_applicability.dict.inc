<?php
    // file created on April 24, 2005, 5:06 pm
    
    // field specifications for table product.prod_feature_applicability
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['prod_feature_id']           = array('type' => 'integer',
                                                    'size' => 9,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 16777215,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_prod_feature(popup)',
                                                    'foreign_field' => 'prod_feature_desc');
    
    $fieldspec['seq_no']                    = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'noedit' => 'y');
    
    $fieldspec['feature_type']              = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'feature_type');
    
    $fieldspec['start_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00');
    
    $fieldspec['end_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'infinityisnull' => 'y');
    
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
                                                    'prod_feature_id',
                                                    'seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'product',
                                                    'parent_field' => 'product_name',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->parent_relations[]               = array('parent' => 'product_feature',
                                                    'parent_field' => 'prod_feature_desc',
                                                    'fields' => array('prod_feature_id' => 'prod_feature_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>