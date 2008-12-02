<?php
    // file created on January 30, 2008, 3:01 pm
    
    // field specifications for table menu.mnu_todo
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'user_id');
    
    $fieldspec['seq_no']                    = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['item_desc']                 = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
    $fieldspec['item_notes']                = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['due_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00');
    
    $fieldspec['visibility']                = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 1,
                                                    'maxvalue' => 99,
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['is_complete']               = array('type' => 'boolean',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean');
    
    $fieldspec['repeat_interval']           = array('type' => 'integer',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 999);
    
    $fieldspec['repeat_unit']               = array('type' => 'string',
                                                    'size' => 1,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'repeat_unit');
    
    $fieldspec['task_id']                   = array('type' => 'string',
                                                    'size' => 80,
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_task(popup1)a',
                                                    'foreign_field' => 'task_desc');
    
    $fieldspec['task_context']              = array('type' => 'string',
                                                    'size' => 255);
    
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
    $this->primary_key                      = array('user_id',
                                                    'seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'parent_field' => 'task_desc',
                                                    'fields' => array('task_id' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_user',
                                                    'parent_field' => 'user_name',
                                                    'fields' => array('user_id' => 'user_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'user_id, due_date, seq_no';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // finished
?>