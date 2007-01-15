<?php
    // file created on December 12, 2006, 6:01 pm
    
    // field specifications for table audit.audit_ssn
    $fieldspec['session_id']                = array('type' => 'integer',
                                                    'size' => 20,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 9.2233720368548e+018,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'default' => 'UNKNOWN',
                                                    'uppercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['ssn_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01',
                                                    'noedit' => 'y');
    
    $fieldspec['ssn_time']                  = array('type' => 'time',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'default' => '00:00:00',
                                                    'noedit' => 'y');
    
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
    
    // finished
?>