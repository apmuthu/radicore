<?php
    // file created on December 30, 2005, 3:42 pm
    
    // field specifications for table audit.audit_trn
    $fieldspec['session_id']                = array('type' => 'integer',
                                                    'size' => 20,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 9223372036854802000,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['tran_seq_no']               = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 32767,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['date']                      = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01',
                                                    'noedit' => 'y');
    
    $fieldspec['time']                      = array('type' => 'time',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'default' => '00:00:00',
                                                    'noedit' => 'y');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 32,
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('session_id',
                                                    'tran_seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'audit_tbl',
                                                    'type' => 'RES',
                                                    'fields' => array('session_id' => 'session_id',
                                                                      'tran_seq_no' => 'tran_seq_no'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'audit_ssn',
                                                    'fields' => array('session_id' => 'session_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = 'session_id, tran_seq_no';
    
    // finished
?>