<?php
    // file created on November 3, 2006, 11:29 am
    
    // field specifications for table product.uom_conversion
    $fieldspec['uom_id_from']               = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['uom_id_to']                 = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_uom(popup)',
                                                    'foreign_field' => 'uom_desc');
    
    $fieldspec['conversion_factor']         = array('type' => 'float',
                                                    'size' => 21,
                                                    'required' => 'y',
                                                    'default' => '0');
    
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
    $this->primary_key                      = array('uom_id_from',
                                                    'uom_id_to');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'alias' => 'unit_of_measure_from',
                                                    'parent_field' => 'uom_desc AS uom_desc_from',
                                                    'fields' => array('uom_id_from' => 'uom_id'));
    
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'alias' => 'unit_of_measure_to',
                                                    'parent_field' => 'uom_desc AS uom_desc_to',
                                                    'fields' => array('uom_id_to' => 'uom_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>