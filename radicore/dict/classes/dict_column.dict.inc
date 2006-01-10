<?php
    // file created on December 26, 2005, 9:10 pm
    
    // field specifications for table dict.dict_column
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
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'dict_table(popup)',
                                                    'foreign_field' => 'table_desc');
    
    $fieldspec['column_id']                 = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['column_seq']                = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['column_desc']               = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['comment']                   = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 65,
                                                    'rows' => 5,
                                                    'nosearch' => 'y');
    
    $fieldspec['col_type']                  = array('type' => 'string',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_type');
    
    $fieldspec['col_values']                = array('type' => 'string',
                                                    'size' => 65535);
    
    $fieldspec['user_size']                 = array('type' => 'integer',
                                                    'size' => 20,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 18446744073710000000,
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['col_maxsize']               = array('type' => 'integer',
                                                    'size' => 20,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 18446744073710000000,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['col_null']                  = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'Y',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_null');
    
    $fieldspec['is_required']               = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'is_required');
    
    $fieldspec['col_key']                   = array('type' => 'string',
                                                    'size' => 3,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_key');
    
    $fieldspec['col_default']               = array('type' => 'string',
                                                    'size' => 40);
    
    $fieldspec['col_auto_increment']        = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_auto_increment');
    
    $fieldspec['col_unsigned']              = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_unsigned');
    
    $fieldspec['col_zerofill_bwz']          = array('type' => 'string',
                                                    'size' => 3,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_zerofill_bwz');
    
    $fieldspec['col_precision']             = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 32);
    
    $fieldspec['col_scale']                 = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 32);
    
    $fieldspec['col_minvalue']              = array('type' => 'float',
                                                    'size' => 21,
                                                    'noedit' => 'y');
    
    $fieldspec['col_maxvalue']              = array('type' => 'float',
                                                    'size' => 20,
                                                    'noedit' => 'y');
    
    $fieldspec['user_minvalue']             = array('type' => 'float',
                                                    'size' => 21);
    
    $fieldspec['user_maxvalue']             = array('type' => 'float',
                                                    'size' => 20);
    
    $fieldspec['noedit_nodisplay']          = array('type' => 'string',
                                                    'size' => 3,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'noedit_nodisplay');
    
    $fieldspec['nosearch']                  = array('type' => 'string',
                                                    'size' => 3,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'nosearch');
    
    $fieldspec['noaudit']                   = array('type' => 'string',
                                                    'size' => 3,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'noaudit');
    
    $fieldspec['upper_lowercase']           = array('type' => 'string',
                                                    'size' => 5,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'upper_lowercase');
    
    $fieldspec['is_password']               = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'is_password');
    
    $fieldspec['auto_insert']               = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'auto_insert');
    
    $fieldspec['auto_update']               = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'auto_update');
    
    $fieldspec['infinityisnull']            = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'infinityisnull');
    
    $fieldspec['subtype']                   = array('type' => 'string',
                                                    'size' => 10,
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'subtype');
    
    $fieldspec['image_width']               = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['image_height']              = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['is_boolean']                = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'noedit' => 'y');
    
    $fieldspec['boolean_true']              = array('type' => 'string',
                                                    'size' => 4,
                                                    'uppercase' => 'y');
    
    $fieldspec['boolean_false']             = array('type' => 'string',
                                                    'size' => 4,
                                                    'uppercase' => 'y');
    
    $fieldspec['control']                   = array('type' => 'string',
                                                    'size' => 10,
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'control');
    
    $fieldspec['optionlist']                = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup)a',
                                                    'foreign_field' => 'task_desc');
    
    $fieldspec['foreign_field']             = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y');
    
    $fieldspec['align_hv']                  = array('type' => 'string',
                                                    'size' => 1,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'align_hv');
    
    $fieldspec['multi_cols']                = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 127);
    
    $fieldspec['multi_rows']                = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 127);
    
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
                                                    'table_id',
                                                    'column_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'dict_related_column',
                                                    'alias' => 'dict_related_column_snr',
                                                    'type' => 'RES',
                                                    'fields' => array('database_id' => 'database_id_snr',
                                                                      'table_id' => 'table_id_snr',
                                                                      'column_id' => 'column_id_snr'));
    
    $this->child_relations[]                = array('child' => 'dict_related_column',
                                                    'alias' => 'dict_related_column_jnr',
                                                    'type' => 'RES',
                                                    'fields' => array('database_id' => 'database_id_jnr',
                                                                      'table_id' => 'table_id_jnr',
                                                                      'column_id' => 'column_id_jnr'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'dict_table',
                                                    'parent_field' => 'table_desc',
                                                    'fields' => array('database_id' => 'database_id',
                                                                      'table_id' => 'table_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'task_desc',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'database_id, table_id, column_seq';
    
    // finished
?>