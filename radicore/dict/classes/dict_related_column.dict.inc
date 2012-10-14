<?php
    // file created on June 24, 2012, 8:50 pm
    
    // field specifications for table dict.dict_related_column
    $fieldspec['database_id_snr']           = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['table_id_snr']              = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['column_id_snr']             = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['database_id_jnr']           = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['table_id_jnr']              = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['seq_no']                    = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['column_id_jnr']             = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['seq_in_index']              = array('type' => 'integer',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'default' => 'UNKNOWN',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['revised_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['revised_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('database_id_snr',
                                                    'table_id_snr',
                                                    'column_id_snr',
                                                    'database_id_jnr',
                                                    'table_id_jnr',
                                                    'seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'dict_column',
                                                    'alias' => 'dict_column_snr',
                                                    'parent_field' => 'column_desc AS column_desc_snr',
                                                    'fields' => array('database_id_snr' => 'database_id',
                                                                      'table_id_snr' => 'table_id',
                                                                      'column_id_snr' => 'column_id'));
    
    $this->parent_relations[]               = array('parent' => 'dict_column',
                                                    'alias' => 'dict_column_jnr',
                                                    'parent_field' => 'column_desc AS column_desc_jnr',
                                                    'fields' => array('database_id_jnr' => 'database_id',
                                                                      'table_id_jnr' => 'table_id',
                                                                      'column_id_jnr' => 'column_id'));
    
    $this->parent_relations[]               = array('parent' => 'dict_relationship',
                                                    'fields' => array('database_id_snr' => 'database_id_snr',
                                                                      'table_id_snr' => 'table_id_snr',
                                                                      'database_id_jnr' => 'database_id_jnr',
                                                                      'table_id_jnr' => 'table_id_jnr',
                                                                      'seq_no' => 'seq_no'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'seq_in_index';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>