<?php
    // file created on October 3, 2012, 4:37 pm
    
    // field specifications for table audit.audit_trn
    $fieldspec['session_id']                = array('type' => 'integer',
                                                    'size' => 21,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 1.84467440737096e19,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['tran_seq_no']               = array('type' => 'integer',
                                                    'size' => 7,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['trn_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01',
                                                    'noedit' => 'y');
    
    $fieldspec['trn_time']                  = array('type' => 'time',
                                                    'size' => 10,
                                                    'required' => 'y',
                                                    'default' => '00:00:00',
                                                    'noedit' => 'y');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'noedit' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('session_id',
                                                    'tran_seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'audit_tbl',
                                                    'type' => 'DEL',
                                                    'fields' => array('session_id' => 'session_id',
                                                                      'tran_seq_no' => 'tran_seq_no'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'audit_ssn',
                                                    'fields' => array('session_id' => 'session_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = 'session_id, tran_seq_no';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>