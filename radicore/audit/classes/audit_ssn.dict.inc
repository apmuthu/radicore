<?php
    // file created on October 20, 2015, 8:39 am
    
    // field specifications for table audit.audit_ssn
    $fieldspec['session_id']                = array('type' => 'integer',
                                                    'type_native' => 'bigint',
                                                    'size' => 20,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 1.84467440737096e19,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'default' => 'UNKNOWN',
                                                    'uppercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['ssn_datetime']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'autoinsert' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('session_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'audit_trn',
                                                    'type' => 'RES',
                                                    'fields' => array('session_id' => 'session_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = 'ssn_date, ssn_time';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>