<?php
    // file created on January 5, 2006, 11:51 pm
    
    // field specifications for table xample.test_autoincrement
    $fieldspec['id']                        = array('type' => 'integer',
                                                    'size' => 10,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['field1']                    = array('type' => 'string',
                                                    'size' => 40);
    
    $fieldspec['field2']                    = array('type' => 'string',
                                                    'size' => 255);
    
    // primary key details 
    $this->primary_key                      = array('id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>