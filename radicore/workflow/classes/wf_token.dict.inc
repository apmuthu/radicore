<?php
    // file created on February 6, 2006, 3:46 pm
    
    // field specifications for table workflow.wf_token
    $fieldspec['case_id']                   = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['token_id']                  = array('type' => 'integer',
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
    
    $fieldspec['place_id']                  = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'place_id');
    
    $fieldspec['context']                   = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y',
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['token_status']              = array('type' => 'string',
                                                    'size' => 4,
                                                    'required' => 'y',
                                                    'default' => 'FREE',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'token_status');
    
    $fieldspec['enabled_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00',
                                                    'autoinsert' => 'y');
    
    $fieldspec['cancelled_date']            = array('type' => 'datetime',
                                                    'size' => 20);
    
    $fieldspec['consumed_date']             = array('type' => 'datetime',
                                                    'size' => 20);
    
    // primary key details 
    $this->primary_key                      = array('case_id',
                                                    'token_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'wf_case',
                                                    'fields' => array('case_id' => 'case_id'));
    
    $this->parent_relations[]               = array('parent' => 'wf_place',
                                                    'parent_field' => 'place_name',
                                                    'fields' => array('workflow_id' => 'workflow_id',
                                                                      'place_id' => 'place_id'));
    
    $this->parent_relations[]               = array('parent' => 'wf_workflow',
                                                    'parent_field' => 'workflow_name',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'workflow_id, case_id, token_id';
    
    // finished
?>