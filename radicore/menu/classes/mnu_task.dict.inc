<?php
    // file created on July 7, 2017, 2:28 pm
    
    // field specifications for table menu.mnu_task
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['task_name']                 = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
    $fieldspec['task_desc']                 = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 80,
                                                    'rows' => 5);
    
    $fieldspec['button_text']               = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['task_type']                 = array('type' => 'string',
                                                    'size' => 4,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'task_type');
    
    $fieldspec['script_id']                 = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['is_disabled']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['pattern_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'pattern_id');
    
    $fieldspec['subsys_id']                 = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'subsys_id');
    
    $fieldspec['initial_passthru']          = array('type' => 'string',
                                                    'size' => 80,
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)a',
                                                    'foreign_field' => 'task_name_passthru');
    
    $fieldspec['selection_fixed']           = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['selection_temp']            = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['settings']                  = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['order_by']                  = array('type' => 'string',
                                                    'size' => 255,
                                                    'lowercase' => 'y');
    
    $fieldspec['keep_data']                 = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['log_sql_query']             = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['screen_refresh']            = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['use_https']                 = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['max_execution_time']        = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['task_id_run_at_end']        = array('type' => 'string',
                                                    'size' => 80,
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)a1',
                                                    'foreign_field' => 'task_name_run_at_end');
    
    $fieldspec['task_id_run_at_cancel']     = array('type' => 'string',
                                                    'size' => 80,
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)a2',
                                                    'foreign_field' => 'task_name_run_at_cancel');
    
    $fieldspec['allow_responsive_gui']      = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'boolean');
    
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
    $this->primary_key                      = array('task_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'dict_column',
                                                    'dbname' => 'dict',
                                                    'subsys_dir' => 'dict',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'help_text',
                                                    'type' => 'DEL',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_favourite',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_initial_value_role',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_initial_value_user',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_menu',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'menu_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_menu',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id_jnr'));
    
    $this->child_relations[]                = array('child' => 'mnu_nav_button',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id_snr'));
    
    $this->child_relations[]                = array('child' => 'mnu_nav_button',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id_jnr'));
    
    $this->child_relations[]                = array('child' => 'mnu_role',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'start_task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_role_task',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_role_taskfield',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_saved_selection',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'initial_passthru'));
    
    $this->child_relations[]                = array('child' => 'mnu_task',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id_run_at_end'));
    
    $this->child_relations[]                = array('child' => 'mnu_task',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id_run_at_cancel'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_alt',
                                                    'type' => 'DEL',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_field',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_ip_address',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_quicksearch',
                                                    'type' => 'DEL',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_quicksearch_alt',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_todo',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_pattern',
                                                    'parent_field' => 'pattern_name',
                                                    'fields' => array('pattern_id' => 'pattern_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_subsystem',
                                                    'parent_field' => 'subsys_name',
                                                    'fields' => array('subsys_id' => 'subsys_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'alias' => 'mnu_task_passthru',
                                                    'parent_field' => 'task_name AS task_name_passthru',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_name, task_desc, button_text',
                                                    'fields' => array('initial_passthru' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'alias' => 'mnu_task_run_at_end',
                                                    'parent_field' => 'task_name AS task_name_run_at_end',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_name, task_desc, button_text',
                                                    'fields' => array('task_id_run_at_end' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'alias' => 'mnu_task_run_at_cancel',
                                                    'parent_field' => 'task_name AS task_name_run_at_cancel',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_name, task_desc, button_text',
                                                    'fields' => array('task_id_run_at_cancel' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'task_id';
    
    // alternative language options 
    $this->alt_language_table               = 'mnu_task_alt';
    $this->alt_language_cols                = 'task_name, task_desc, button_text';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>