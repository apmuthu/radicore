<?php
    // file created on May 21, 2017, 3:24 pm
    
    // field specifications for table menu.mnu_role
    $fieldspec['role_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['role_name']                 = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
    $fieldspec['role_desc']                 = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 80,
                                                    'rows' => 5);
    
    $fieldspec['start_task_id']             = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)b',
                                                    'foreign_field' => 'start_task_name');
    
    $fieldspec['global_access']             = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['is_external_auth_off']      = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['allow_responsive_gui']      = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
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
    $this->primary_key                      = array('role_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'mnu_initial_value_role',
                                                    'type' => 'RES',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_motd',
                                                    'type' => 'RES',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_role_task',
                                                    'type' => 'RES',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_role_taskfield',
                                                    'type' => 'RES',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_time_limit_role',
                                                    'type' => 'DEL',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user_role',
                                                    'type' => 'RES',
                                                    'fields' => array('role_id' => 'role_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'parent_field' => 'task_name AS start_task_name',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_name, task_desc, button_text',
                                                    'fields' => array('start_task_id' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'role_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>