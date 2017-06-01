<?php
    // file created on May 12, 2017, 2:58 pm
    
    // field specifications for table dict.dict_relationship
    $fieldspec['database_id_snr']           = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'database_id');
    
    $fieldspec['table_id_snr']              = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'dict_table(popup2)snr',
                                                    'foreign_field' => 'table_id_snr',
                                                    'noedit' => 'y');
    
    $fieldspec['database_id_jnr']           = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'database_id');
    
    $fieldspec['table_id_jnr']              = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'dict_table(popup2)',
                                                    'foreign_field' => 'table_id_jnr',
                                                    'noedit' => 'y');
    
    $fieldspec['seq_no']                    = array('type' => 'integer',
                                                    'type_native' => 'tinyint',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['table_alias_snr']           = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y');
    
    $fieldspec['table_alias_jnr']           = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y');
    
    $fieldspec['relation_name']             = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
    $fieldspec['relation_desc']             = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5,
                                                    'nosearch' => 'y');
    
    $fieldspec['relation_type']             = array('type' => 'string',
                                                    'size' => 3,
                                                    'required' => 'y',
                                                    'default' => 'RES',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'relation_type');
    
    $fieldspec['orderby']                   = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y');
    
    $fieldspec['parent_field']              = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'parent_field');
    
    $fieldspec['calc_field']                = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['key_name']                  = array('type' => 'string',
                                                    'size' => 64,
                                                    'required' => 'y',
                                                    'default' => 'PRIMARY',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'key_name');
    
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
                                                    'database_id_jnr',
                                                    'table_id_jnr',
                                                    'seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'dict_related_column',
                                                    'type' => 'DEL',
                                                    'fields' => array('database_id_snr' => 'database_id_snr',
                                                                      'table_id_snr' => 'table_id_snr',
                                                                      'database_id_jnr' => 'database_id_jnr',
                                                                      'table_id_jnr' => 'table_id_jnr',
                                                                      'seq_no' => 'seq_no'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'dict_database',
                                                    'alias' => 'dict_database_snr',
                                                    'fields' => array('database_id_snr' => 'database_id'));
    
    $this->parent_relations[]               = array('parent' => 'dict_database',
                                                    'alias' => 'dict_database_jnr',
                                                    'fields' => array('database_id_jnr' => 'database_id'));
    
    $this->parent_relations[]               = array('parent' => 'dict_table',
                                                    'alias' => 'dict_table_snr',
                                                    'parent_field' => 'table_name as table_name_snr',
                                                    'fields' => array('database_id_snr' => 'database_id',
                                                                      'table_id_snr' => 'table_id'));
    
    $this->parent_relations[]               = array('parent' => 'dict_table',
                                                    'alias' => 'dict_table_jnr',
                                                    'parent_field' => 'table_name as table_name_jnr',
                                                    'fields' => array('database_id_jnr' => 'database_id',
                                                                      'table_id_jnr' => 'table_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'database_id_snr, table_id_snr, database_id_jnr, table_id_jnr';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>