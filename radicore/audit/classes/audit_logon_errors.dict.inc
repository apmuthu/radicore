<?php
    // file created on October 3, 2012, 4:37 pm
    
    // field specifications for table audit.audit_logon_errors
    $fieldspec['id']                        = array('type' => 'integer',
                                                    'size' => 12,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => -2147483648,
                                                    'maxvalue' => 2147483647,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['err_timestamp']             = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00 00:00:00',
                                                    'autoinsert' => 'y');
    
    $fieldspec['ip_address']                = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y',
                                                    'default' => '0.0.0.0');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y');
    
    $fieldspec['user_password']             = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y');
    
    $fieldspec['email_addr']                = array('type' => 'string',
                                                    'size' => 50,
                                                    'lowercase' => 'y');
    
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
    $this->default_orderby                  = 'err_timestamp desc';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>