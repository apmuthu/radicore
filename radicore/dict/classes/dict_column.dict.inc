<?php
    // file created on May 21, 2016, 10:28 am
    
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
                                                    'task_id' => 'dict_table(popup2)',
                                                    'foreign_field' => 'table_id');
    
    $fieldspec['column_id']                 = array('type' => 'string',
                                                    'size' => 64,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['column_seq']                = array('type' => 'integer',
                                                    'type_native' => 'smallint',
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
    
    $fieldspec['col_comment']               = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5,
                                                    'nosearch' => 'y');
    
    $fieldspec['col_type']                  = array('type' => 'string',
                                                    'size' => 20,
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_type');
    
    $fieldspec['col_type_native']           = array('type' => 'string',
                                                    'size' => 32);
    
    $fieldspec['col_array_type']            = array('type' => 'string',
                                                    'size' => 20);
    
    $fieldspec['col_values']                = array('type' => 'string',
                                                    'size' => 65535);
    
    $fieldspec['user_size']                 = array('type' => 'integer',
                                                    'type_native' => 'bigint',
                                                    'size' => 21,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 1.84467440737096e19);
    
    $fieldspec['col_maxsize']               = array('type' => 'integer',
                                                    'type_native' => 'bigint',
                                                    'size' => 21,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 1.84467440737096e19,
                                                    'noedit' => 'y');
    
    $fieldspec['col_null']                  = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_null');
    
    $fieldspec['is_required']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
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
                                                    'size' => 255);
    
    $fieldspec['col_auto_increment']        = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_auto_increment');
    
    $fieldspec['col_unsigned']              = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_unsigned');
    
    $fieldspec['col_zerofill_bwz']          = array('type' => 'string',
                                                    'size' => 3,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_zerofill_bwz');
    
    $fieldspec['col_precision']             = array('type' => 'integer',
                                                    'type_native' => 'tinyint',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255);
    
    $fieldspec['col_scale']                 = array('type' => 'integer',
                                                    'type_native' => 'tinyint',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255);
    
    $fieldspec['col_minvalue']              = array('type' => 'float',
                                                    'size' => 22,
                                                    'noedit' => 'y');
    
    $fieldspec['col_maxvalue']              = array('type' => 'float',
                                                    'size' => 22,
                                                    'noedit' => 'y');
    
    $fieldspec['user_minvalue']             = array('type' => 'float',
                                                    'size' => 22);
    
    $fieldspec['user_maxvalue']             = array('type' => 'float',
                                                    'size' => 22);
    
    $fieldspec['noedit_nodisplay']          = array('type' => 'string',
                                                    'size' => 3,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'noedit_nodisplay');
    
    $fieldspec['no_search']                 = array('type' => 'string',
                                                    'size' => 3,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'no_search');
    
    $fieldspec['no_audit']                  = array('type' => 'string',
                                                    'size' => 3,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'no_audit');
    
    $fieldspec['upper_lowercase']           = array('type' => 'string',
                                                    'size' => 5,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'upper_lowercase');
    
    $fieldspec['is_password']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'is_password');
    
    $fieldspec['auto_insert']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'auto_insert');
    
    $fieldspec['auto_update']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'auto_update');
    
    $fieldspec['infinityisnull']            = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'infinityisnull');
    
    $fieldspec['col_subtype']               = array('type' => 'string',
                                                    'size' => 10,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'col_subtype');
    
    $fieldspec['image_width']               = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['image_height']              = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['is_boolean']                = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean',
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
    
    $fieldspec['checkbox_label']            = array('type' => 'string',
                                                    'size' => 64);
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)a',
                                                    'foreign_field' => 'task_desc');
    
    $fieldspec['foreign_field']             = array('type' => 'string',
                                                    'size' => 64,
                                                    'lowercase' => 'y');
    
    $fieldspec['align_hv']                  = array('type' => 'string',
                                                    'type_native' => 'char',
                                                    'size' => 1,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'align_hv');
    
    $fieldspec['align_lr']                  = array('type' => 'string',
                                                    'type_native' => 'char',
                                                    'size' => 1,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'align_lr');
    
    $fieldspec['multi_cols']                = array('type' => 'integer',
                                                    'type_native' => 'tinyint',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255);
    
    $fieldspec['multi_rows']                = array('type' => 'integer',
                                                    'type_native' => 'tinyint',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255);
    
    $fieldspec['custom_validation']         = array('type' => 'string',
                                                    'size' => 255);
    
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
    
    $this->child_relations[]                = array('child' => 'dict_table_key',
                                                    'type' => 'DEL',
                                                    'fields' => array('database_id' => 'database_id',
                                                                      'table_id' => 'table_id',
                                                                      'column_id' => 'column_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'dict_table',
                                                    'parent_field' => 'table_desc',
                                                    'fields' => array('database_id' => 'database_id',
                                                                      'table_id' => 'table_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'task_desc',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_desc, button_text',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'database_id, table_id, column_seq';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>