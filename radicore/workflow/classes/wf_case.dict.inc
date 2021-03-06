<?php
    // file created on September 23, 2015, 3:43 pm
    
    // field specifications for table workflow.wf_case
    $fieldspec['rdcaccount_id']             = array('type' => 'integer',
                                                    'size' => 11,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'nodisplay' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['case_id']                   = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['workflow_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'workflow_id');
    
    $fieldspec['context']                   = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['case_status']               = array('type' => 'string',
                                                    'size' => 2,
                                                    'required' => 'y',
                                                    'default' => 'OP',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'case_status');
    
    $fieldspec['start_date']                = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00');
    
    $fieldspec['end_date']                  = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'infinityisnull' => 'y');
    
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
    $this->primary_key                      = array('case_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'wf_token',
                                                    'type' => 'RES',
                                                    'fields' => array('case_id' => 'case_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workitem',
                                                    'type' => 'RES',
                                                    'fields' => array('case_id' => 'case_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_account',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'fields' => array('rdcaccount_id' => 'rdcaccount_id'));
    
    $this->parent_relations[]               = array('parent' => 'wf_workflow',
                                                    'parent_field' => 'workflow_name',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'workflow_id, case_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>