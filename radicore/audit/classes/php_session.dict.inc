<?php
    // file created on October 9, 2006, 10:30 am
    
    // field specifications for table audit.php_session
    $fieldspec['session_id']                = array('type' => 'string',
                                                    'size' => 32,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['date_created']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00');
    
    $fieldspec['last_updated']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00');
    
    $fieldspec['session_data']              = array('type' => 'string',
                                                    'size' => 4294967295);
    
    // primary key details 
    $this->primary_key                      = array('session_id');
    
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