<?php
    // file created on February 27, 2008, 6:31 pm
    
    // field specifications for table menu.mnu_task_field
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['field_id']                  = array('type' => 'string',
                                                    'size' => 40,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['field_desc']                = array('type' => 'string',
                                                    'size' => 255,
                                                    'control' => 'multiline',
                                                    'cols' => 75,
                                                    'rows' => 3);
    
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
    $this->primary_key                      = array('task_id',
                                                    'field_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'mnu_initial_value_role',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id',
                                                                      'field_id' => 'field_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_initial_value_user',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id',
                                                                      'field_id' => 'field_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_role_taskfield',
                                                    'type' => 'RES',
                                                    'fields' => array('task_id' => 'task_id',
                                                                      'field_id' => 'field_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'parent_field' => 'task_desc',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // finished
?>