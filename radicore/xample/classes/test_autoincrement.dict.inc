<?php
    // file created on June 23, 2009, 6:54 pm
    
    // field specifications for table xample.test_autoincrement
    $fieldspec['id']                        = array('type' => 'integer',
                                                    'size' => 11,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => -9999999999,
                                                    'maxvalue' => 9999999999,
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
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>