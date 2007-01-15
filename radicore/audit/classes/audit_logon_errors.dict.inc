<?php
    // file created on December 12, 2006, 6:01 pm
    
    // field specifications for table audit.audit_logon_errors
    $fieldspec['id']                        = array('type' => 'integer',
                                                    'size' => 11,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 2147483647,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['err_timestamp']             = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00 00:00:00',
                                                    'autoinsert' => 'y');
    
    $fieldspec['ip_address']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'default' => '0.0.0.0');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['user_password']             = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y');
    
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
    
    // finished
?>