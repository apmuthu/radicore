<?php
    // file created on October 30, 2005, 12:25 pm
    
    // field specifications for table workflow.wf_workflow
    $fieldspec['workflow_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['workflow_name']             = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
    $fieldspec['workflow_desc']             = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['start_task_id']             = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup)a',
                                                    'foreign_field' => 'task_desc');
    
    $fieldspec['is_valid']                  = array('type' => 'string',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'noedit' => 'y');
    
    $fieldspec['workflow_errors']           = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5,
                                                    'noedit' => 'y');
    
    $fieldspec['start_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y');
    
    $fieldspec['end_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'infinityisnull' => 'y');
    
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
    $this->primary_key                      = array('workflow_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'wf_arc',
                                                    'type' => 'RES',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    $this->child_relations[]                = array('child' => 'wf_case',
                                                    'type' => 'RES',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    $this->child_relations[]                = array('child' => 'wf_place',
                                                    'type' => 'DEL',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    $this->child_relations[]                = array('child' => 'wf_token',
                                                    'type' => 'RES',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    $this->child_relations[]                = array('child' => 'wf_transition',
                                                    'type' => 'RES',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    $this->child_relations[]                = array('child' => 'wf_workitem',
                                                    'type' => 'RES',
                                                    'fields' => array('workflow_id' => 'workflow_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'task_desc',
                                                    'fields' => array('start_task_id' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>