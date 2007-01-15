<?php
    // file created on November 3, 2006, 11:34 am
    
    // field specifications for table workflow.wf_arc
    $fieldspec['workflow_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['transition_id']             = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'transition_id');
    
    $fieldspec['place_id']                  = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'place_id');
    
    $fieldspec['direction']                 = array('type' => 'string',
                                                    'size' => 3,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => 'IN',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'direction');
    
    $fieldspec['arc_type']                  = array('type' => 'string',
                                                    'size' => 10,
                                                    'required' => 'y',
                                                    'default' => 'SEQ',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'arc_type');
    
    $fieldspec['pre_condition']             = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
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
    $this->primary_key                      = array('workflow_id',
                                                    'transition_id',
                                                    'place_id',
                                                    'direction');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'wf_place',
                                                    'parent_field' => 'place_name',
                                                    'fields' => array('workflow_id' => 'workflow_id',
                                                                      'place_id' => 'place_id'));
    
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
    $this->default_orderby                  = 'workflow_id, transition_id, place_id, direction';
    
    // finished
?>