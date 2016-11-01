<?php
    // file created on October 3, 2016, 9:36 am
    
    // field specifications for table workflow.wf_workitem
    $fieldspec['rdcaccount_id']             = array('type' => 'integer',
                                                    'type_native' => 'int',
                                                    'size' => 11,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'nodisplay' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['case_id']                   = array('type' => 'integer',
                                                    'type_native' => 'int',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['workitem_id']               = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['workflow_id']               = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'workflow_id',
                                                    'noedit' => 'y');
    
    $fieldspec['transition_id']             = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'transition_id',
                                                    'noedit' => 'y');
    
    $fieldspec['transition_trigger']        = array('type' => 'string',
                                                    'size' => 4,
                                                    'required' => 'y',
                                                    'default' => 'USER',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'transition_trigger',
                                                    'noedit' => 'y');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)a',
                                                    'foreign_field' => 'task_desc',
                                                    'noedit' => 'y');
    
    $fieldspec['context']                   = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5,
                                                    'noedit' => 'y');
    
    $fieldspec['workitem_status']           = array('type' => 'string',
                                                    'size' => 2,
                                                    'required' => 'y',
                                                    'default' => 'EN',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'workitem_status',
                                                    'noedit' => 'y');
    
    $fieldspec['enabled_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'noedit' => 'y');
    
    $fieldspec['cancelled_date']            = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'noedit' => 'y');
    
    $fieldspec['finished_date']             = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'noedit' => 'y');
    
    $fieldspec['deadline']                  = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'noedit' => 'y');
    
    $fieldspec['role_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'role_id');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'user_id');
    
    // primary key details 
    $this->primary_key                      = array('case_id',
                                                    'workitem_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_account',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_role',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'role_desc',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'task_desc',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_desc, button_text',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_user',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'user_name',
                                                    'alt_language_table' => 'mnu_user_alt',
                                                    'alt_language_cols' => 'user_name',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->parent_relations[]               = array('parent' => 'wf_case',
                                                    'fields' => array('case_id' => 'case_id'));
    
    $this->parent_relations[]               = array('parent' => 'wf_transition',
                                                    'parent_field' => 'transition_name',
                                                    'fields' => array('workflow_id' => 'workflow_id',
                                                                      'transition_id' => 'transition_id'));
    
    $this->parent_relations[]               = array('parent' => 'wf_workflow',
                                                    'parent_field' => 'workflow_name',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'workflow_id, case_id, workitem_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>