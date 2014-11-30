<?php
    // file created on June 14, 2014, 1:39 pm
    
    // field specifications for table xample.test_autoincrement
    $fieldspec['id']                        = array('type' => 'integer',
                                                    'size' => 10,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => -2147483648,
                                                    'maxvalue' => 2147483647,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => 'nextval(\'test_autoincrement_id_seq\'::regclass)');
    
    $fieldspec['field1']                    = array('type' => 'string',
                                                    'size' => 40);
    
    $fieldspec['field2']                    = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['field3']                    = array('type' => 'integer',
                                                    'size' => 20,
                                                    'minvalue' => -9.22337203685478e+018,
                                                    'maxvalue' => 9.22337203685478e+018);
    
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