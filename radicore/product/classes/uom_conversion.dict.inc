<?php
    // file created on April 24, 2005, 5:07 pm
    
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
                                                    'unsigned' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
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
    $this->primary_key                      = array('uom_id_from',
                                                    'uom_id_to');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'parent_field' => 'uom_desc as uom_desc_from',
                                                    'fields' => array('uom_id_from' => 'uom_id'));
    
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'parent_field' => 'uom_desc as uom_desc_to',
                                                    'fields' => array('uom_id_to' => 'uom_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>