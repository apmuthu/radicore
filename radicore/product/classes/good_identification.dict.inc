<?php
    // file created on November 3, 2006, 11:29 am
    
    // field specifications for table product.good_identification
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['identity_type_id']          = array('type' => 'string',
                                                    'size' => 6,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'identity_type_id');
    
    $fieldspec['id_value']                  = array('type' => 'string',
                                                    'size' => 32,
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
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
                                                    'identity_type_id');
    
    // unique key details 
    $this->unique_keys[]                    = array('identity_type_id',
                                                    'id_value');
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'good_identity_type',
                                                    'parent_field' => 'identity_type_desc',
                                                    'fields' => array('identity_type_id' => 'identity_type_id'));
    
    $this->parent_relations[]               = array('parent' => 'product',
                                                    'parent_field' => 'product_name',
                                                    'fields' => array('product_id' => 'product_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>