<?php
    // file created on September 26, 2017, 2:32 pm
    
    // field specifications for table audit.audit_fld
    $fieldspec['session_id']                = array('type' => 'integer',
                                                    'type_native' => 'bigint',
                                                    'size' => 20,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 1.84467440737096e19,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['tran_seq_no']               = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['table_seq_no']              = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['field_id']                  = array('type' => 'string',
                                                    'size' => 255,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['old_value']                 = array('type' => 'string',
                                                    'size' => 65535,
                                                    'noedit' => 'y');
    
    $fieldspec['new_value']                 = array('type' => 'string',
                                                    'size' => 65535,
                                                    'noedit' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('session_id',
                                                    'tran_seq_no',
                                                    'table_seq_no',
                                                    'field_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'audit_tbl',
                                                    'fields' => array('session_id' => 'session_id',
                                                                      'tran_seq_no' => 'tran_seq_no',
                                                                      'table_seq_no' => 'table_seq_no'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = 'session_id, tran_seq_no, table_seq_no, field_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>