<?php
    // file created on January 30, 2008, 2:35 pm
    
    // field specifications for table menu.mnu_account
    $fieldspec['rdcaccount_id']             = array('type' => 'integer',
                                                    'size' => 10,
                                                    'auto_increment' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['account_name']              = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');
    
    $fieldspec['rdcversion']                = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'autoupdate' => 'y',
                                                    'nodisplay' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
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
    $this->primary_key                      = array('rdcaccount_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'mnu_user',
                                                    'type' => 'RES',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    $this->child_relations[]                = array('child' => 'wf_case',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    $this->child_relations[]                = array('child' => 'wf_token',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workitem',
                                                    'dbname' => 'workflow',
                                                    'subsys_dir' => 'workflow',
                                                    'type' => 'RES',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'rdcaccount_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // finished
?>