<?php
    // file created on January 23, 2006, 6:23 pm
    
    // field specifications for table menu.mnu_user
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['user_name']                 = array('type' => 'string',
                                                    'size' => 30,
                                                    'required' => 'y');
    
    $fieldspec['user_password']             = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'password' => 'y',
                                                    'nosearch' => 'y',
                                                    'noaudit' => 'y');
    
    $fieldspec['role_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'role_id');
    
    $fieldspec['pswd_chg_date']             = array('type' => 'date',
                                                    'size' => 12,
                                                    'noedit' => 'y');
    
    $fieldspec['pswd_chg_time']             = array('type' => 'time',
                                                    'size' => 8,
                                                    'noedit' => 'y');
    
    $fieldspec['pswd_count']                = array('type' => 'integer',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'noedit' => 'y');
    
    $fieldspec['in_use']                    = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N');
    
    $fieldspec['is_disabled']               = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N');
    
    $fieldspec['logon_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'noedit' => 'y');
    
    $fieldspec['logon_time']                = array('type' => 'time',
                                                    'size' => 8,
                                                    'noedit' => 'y');
    
    $fieldspec['language_code']             = array('type' => 'string',
                                                    'size' => 6,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'language_code');
    
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
    $this->primary_key                      = array('user_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'mnu_todo',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'survey_answer_hdr',
                                                    'dbname' => 'survey',
                                                    'subsys_dir' => 'survey',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workitem',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_role',
                                                    'parent_field' => 'role_desc',
                                                    'fields' => array('role_id' => 'role_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>