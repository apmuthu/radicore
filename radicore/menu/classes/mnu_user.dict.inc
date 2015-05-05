<?php
    // file created on May 2, 2015, 3:01 pm
    
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
    
    $fieldspec['rdcaccount_id']             = array('type' => 'integer',
                                                    'type_native' => 'int',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'rdcaccount_id');
    
    $fieldspec['pswd_chg_date']             = array('type' => 'date',
                                                    'size' => 12,
                                                    'noedit' => 'y');
    
    $fieldspec['pswd_chg_time']             = array('type' => 'time',
                                                    'size' => 10,
                                                    'noedit' => 'y');
    
    $fieldspec['pswd_count']                = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 6,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'noedit' => 'y');
    
    $fieldspec['in_use']                    = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['is_disabled']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['logon_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'noedit' => 'y');
    
    $fieldspec['logon_time']                = array('type' => 'time',
                                                    'size' => 10,
                                                    'noedit' => 'y');
    
    $fieldspec['language_code']             = array('type' => 'string',
                                                    'size' => 6,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'language_code');
    
    $fieldspec['start_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01');
    
    $fieldspec['end_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'default' => '9999-12-31',
                                                    'infinityisnull' => 'y');
    
    $fieldspec['ip_address']                = array('type' => 'string',
                                                    'size' => 40,
                                                    'noedit' => 'y');
    
    $fieldspec['email_addr']                = array('type' => 'string',
                                                    'size' => 50,
                                                    'lowercase' => 'y',
                                                    'subtype' => 'email');
    
    $fieldspec['external_id']               = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['is_external_auth_off']      = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['party_id']                  = array('type' => 'integer',
                                                    'type_native' => 'int',
                                                    'size' => 11,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295);
    
    $fieldspec['user_timezone']             = array('type' => 'string',
                                                    'size' => 40,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'user_timezone');
    
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
    $this->primary_key                      = array('user_id');
    
    // unique key details 
    $this->unique_keys[]                    = array('email_addr');
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'mnu_favourite',
                                                    'type' => 'DEL',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_initial_value_user',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_time_limit_user',
                                                    'type' => 'DEL',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_todo',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user_alt',
                                                    'type' => 'DEL',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user_ip_address',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user_role',
                                                    'type' => 'DEL',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'email_signature',
                                                    'dbname' => 'party',
                                                    'subsys_dir' => 'party',
                                                    'type' => 'DEL',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workitem',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('user_id' => 'user_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_account',
                                                    'parent_field' => 'account_name',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_language',
                                                    'fields' => array('language_code' => 'language_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'user_name';
    
    // alternative language options 
    $this->alt_language_table               = 'mnu_user_alt';
    $this->alt_language_cols                = 'user_name';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>