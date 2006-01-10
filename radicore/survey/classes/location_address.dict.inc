<?php
    // file created on April 24, 2005, 7:29 pm
    
    // field specifications for table survey.location_address
    $fieldspec['node_id']                   = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 1,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['address_line1']             = array('type' => 'string',
                                                    'size' => 80);
    
    $fieldspec['address_line2']             = array('type' => 'string',
                                                    'size' => 80);
    
    $fieldspec['town']                      = array('type' => 'string',
                                                    'size' => 80,
                                                    'uppercase' => 'y');
    
    $fieldspec['county']                    = array('type' => 'string',
                                                    'size' => 80);
    
    $fieldspec['postcode']                  = array('type' => 'string',
                                                    'size' => 10,
                                                    'uppercase' => 'y');
    
    $fieldspec['country']                   = array('type' => 'string',
                                                    'size' => 80);
    
    $fieldspec['telephone']                 = array('type' => 'string',
                                                    'size' => 20);
    
    $fieldspec['fax']                       = array('type' => 'string',
                                                    'size' => 20);
    
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
    $this->primary_key                      = array('node_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'tree_node',
                                                    'parent_field' => 'node_desc',
                                                    'fields' => array('node_id' => 'node_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'node_id';
    
    // finished
?>