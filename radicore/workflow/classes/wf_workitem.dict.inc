<?php
    // file created on October 30, 2005, 12:25 pm
    
    // field specifications for table workflow.wf_workitem
    $fieldspec['case_id']                   = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['workitem_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['workflow_id']               = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'workflow_id');
    
    $fieldspec['transition_id']             = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'transition_id');
    
    $fieldspec['transition_trigger']        = array('type' => 'string',
                                                    'size' => 4,
                                                    'required' => 'y',
                                                    'default' => 'USER',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'transition_trigger');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup)a',
                                                    'foreign_field' => 'task_desc');
    
    $fieldspec['context']                   = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['workitem_status']           = array('type' => 'string',
                                                    'size' => 2,
                                                    'required' => 'y',
                                                    'default' => 'EN',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'workitem_status');
    
    $fieldspec['enabled_date']              = array('type' => 'datetime',
                                                    'size' => 20);
    
    $fieldspec['cancelled_date']            = array('type' => 'datetime',
                                                    'size' => 20);
    
    $fieldspec['finished_date']             = array('type' => 'datetime',
                                                    'size' => 20);
    
    $fieldspec['deadline']                  = array('type' => 'datetime',
                                                    'size' => 20);
    
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
    $this->parent_relations[]               = array('parent' => 'mnu_role',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'role_desc',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'task_desc',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_user',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'user_name',
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
    $this->default_orderby                  = '';
    
    // finished
?>