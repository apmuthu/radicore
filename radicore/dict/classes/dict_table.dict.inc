<?php
    // file created on January 18, 2006, 6:34 pm
    
    // field specifications for table dict.dict_table
    $fieldspec['database_id']               = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'database_id');
    
    $fieldspec['table_id']                  = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['table_desc']                = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['comment']                   = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 65,
                                                    'rows' => 5,
                                                    'nosearch' => 'y');
    
    $fieldspec['audit_logging']             = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'Y',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'audit_logging');
    
    $fieldspec['default_orderby']           = array('type' => 'string',
                                                    'size' => 64);
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'default' => 'UNKNOWN',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['revised_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['revised_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y');
    
    // primary key details 
    $this->primary_key                      = array('database_id',
                                                    'table_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'dict_column',
                                                    'type' => 'DEL',
                                                    'fields' => array('database_id' => 'database_id',
                                                                      'table_id' => 'table_id'));
    
    $this->child_relations[]                = array('child' => 'dict_relationship',
                                                    'alias' => 'dict_relationship_snr',
                                                    'type' => 'DEL',
                                                    'fields' => array('database_id' => 'database_id_snr',
                                                                      'table_id' => 'table_id_snr'));
    
    $this->child_relations[]                = array('child' => 'dict_relationship',
                                                    'alias' => 'dict_relationship_jnr',
                                                    'type' => 'DEL',
                                                    'fields' => array('database_id' => 'database_id_jnr',
                                                                      'table_id' => 'table_id_jnr'));
    
    $this->child_relations[]                = array('child' => 'dict_table_key',
                                                    'type' => 'DEL',
                                                    'fields' => array('database_id' => 'database_id',
                                                                      'table_id' => 'table_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'dict_database',
                                                    'parent_field' => 'database_desc',
                                                    'fields' => array('database_id' => 'database_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>