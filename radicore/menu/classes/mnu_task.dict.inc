<?php
    // file created on February 3, 2006, 2:56 pm
    
    // field specifications for table menu.mnu_task
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 40,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['task_desc']                 = array('type' => 'string',
                                                    'size' => 50,
                                                    'required' => 'y');
    
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
                                                    'size' => 40,
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['is_disabled']               = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown');
    
    $fieldspec['dialog_type_id']            = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'dialog_type_id');
    
    $fieldspec['subsys_id']                 = array('type' => 'string',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'subsys_id');
    
    $fieldspec['initial_passthru']          = array('type' => 'string',
                                                    'size' => 40,
                                                    'lowercase' => 'y');
    
    $fieldspec['selection_fixed']           = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['selection_temp']            = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['settings']                  = array('type' => 'string',
                                                    'size' => 40);
    
    $fieldspec['order_by']                  = array('type' => 'string',
                                                    'size' => 255,
                                                    'lowercase' => 'y');
    
    $fieldspec['keep_data']                 = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown');
    
    $fieldspec['log_sql_query']             = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown');
    
    $fieldspec['screen_refresh']            = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 3600);
    
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
    
    $this->child_relations[]                = array('child' => 'mnu_task',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'initial_passthru'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_field',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'wf_transition',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workflow',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'start_task_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workitem',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_dialog_type',
                                                    'parent_field' => 'dialog_type_desc',
                                                    'fields' => array('dialog_type_id' => 'dialog_type_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_subsystem',
                                                    'parent_field' => 'subsys_desc',
                                                    'fields' => array('subsys_id' => 'subsys_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'fields' => array('initial_passthru' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'task_id';
    
    // finished
?>