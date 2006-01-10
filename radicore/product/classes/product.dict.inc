<?php
    // file created on April 24, 2005, 5:06 pm
    
    // field specifications for table product.product
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['product_name']              = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['date_intro']                = array('type' => 'date',
                                                    'size' => 12);
    
    $fieldspec['end_date_sales']            = array('type' => 'date',
                                                    'size' => 12);
    
    $fieldspec['end_date_support']          = array('type' => 'date',
                                                    'size' => 12);
    
    $fieldspec['comment']                   = array('type' => 'string',
                                                    'size' => 255,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['product_subtype']           = array('type' => 'string',
                                                    'size' => 1,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'product_subtype');
    
    $fieldspec['uom_id']                    = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_uom(popup)',
                                                    'foreign_field' => 'uom_desc');
    
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
    $this->primary_key                      = array('product_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'good_identification',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->child_relations[]                = array('child' => 'price_component',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->child_relations[]                = array('child' => 'prod_cat_class',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->child_relations[]                = array('child' => 'prod_feature_applicability',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));
    
    $this->child_relations[]                = array('child' => 'prod_feature_interaction',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'parent_field' => 'uom_desc',
                                                    'fields' => array('uom_id' => 'uom_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>