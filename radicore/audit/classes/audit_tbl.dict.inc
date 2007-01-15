<?php
    // file created on October 9, 2006, 10:30 am
    
    // field specifications for table audit.audit_tbl
    $fieldspec['session_id']                = array('type' => 'integer',
                                                    'size' => 20,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 9.2233720368548e+018,
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
    
    $fieldspec['table_seq_no']              = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 32767,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['base_name']                 = array('type' => 'string',
                                                    'size' => 64,
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['table_name']                = array('type' => 'string',
                                                    'size' => 64,
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['pkey']                      = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('session_id',
                                                    'tran_seq_no',
                                                    'table_seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'audit_fld',
                                                    'type' => 'DEL',
                                                    'fields' => array('session_id' => 'session_id',
                                                                      'tran_seq_no' => 'tran_seq_no',
                                                                      'table_seq_no' => 'table_seq_no'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'audit_trn',
                                                    'fields' => array('session_id' => 'session_id',
                                                                      'tran_seq_no' => 'tran_seq_no'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = 'session_id, tran_seq_no, table_seq_no';
    
    // finished
?>