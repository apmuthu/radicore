<?php
    // file created on January 23, 2006, 6:40 pm
    
    // field specifications for table product.unit_of_measure
    $fieldspec['uom_id']                    = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['uom_cat_id']                = array('type' => 'string',
                                                    'size' => 4,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'uom_cat_id');
    
    $fieldspec['uom_abbrev']                = array('type' => 'string',
                                                    'size' => 8,
                                                    'required' => 'y');
    
    $fieldspec['uom_desc']                  = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
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
    $this->primary_key                      = array('uom_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'price_component',
                                                    'type' => 'RES',
                                                    'fields' => array('uom_id' => 'uom_id'));
    
    $this->child_relations[]                = array('child' => 'product',
                                                    'type' => 'RES',
                                                    'fields' => array('uom_id' => 'uom_id'));
    
    $this->child_relations[]                = array('child' => 'product_feature',
                                                    'type' => 'RES',
                                                    'fields' => array('uom_id' => 'uom_id'));
    
    $this->child_relations[]                = array('child' => 'uom_conversion',
                                                    'type' => 'RES',
                                                    'fields' => array('uom_id' => 'uom_id_from'));
    
    $this->child_relations[]                = array('child' => 'uom_conversion',
                                                    'type' => 'RES',
                                                    'fields' => array('uom_id' => 'uom_id_to'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'uom_category',
                                                    'parent_field' => 'uom_cat_desc',
                                                    'fields' => array('uom_cat_id' => 'uom_cat_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>