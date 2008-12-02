<?php
    // file created on June 24, 2008, 5:35 pm
    
    // field specifications for table menu.mnu_initial_value_role
    $fieldspec['role_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['field_id']                  = array('type' => 'string',
                                                    'size' => 40,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['initial_value']             = array('type' => 'string',
                                                    'size' => 255);
    
    $fieldspec['is_noedit']                 = array('type' => 'boolean',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'boolean');
    
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
    $this->primary_key                      = array('role_id',
                                                    'task_id',
                                                    'field_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_role',
                                                    'parent_field' => 'role_desc',
                                                    'fields' => array('role_id' => 'role_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task_field',
                                                    'parent_field' => 'field_desc',
                                                    'fields' => array('task_id' => 'task_id',
                                                                      'field_id' => 'field_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'role_id, task_id, field_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // finished
?>