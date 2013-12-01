<?php
    // file created on January 1, 2013, 1:32 pm
    
    // field specifications for table menu.help_text
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['help_text']                 = array('type' => 'string',
                                                    'size' => 65535,
                                                    'required' => 'y',
                                                    'control' => 'multiline',
                                                    'cols' => 80,
                                                    'rows' => 15);
    
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
    $this->primary_key                      = array('task_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'help_text_alt',
                                                    'type' => 'DEL',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'parent_field' => 'task_desc',
                                                    'alt_language_table' => 'mnu_task_alt',
                                                    'alt_language_cols' => 'task_desc, button_text',
                                                    'fields' => array('task_id' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'task_id';
    
    // alternative language options 
    $this->alt_language_table               = 'help_text_alt';
    $this->alt_language_cols                = 'help_text';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>