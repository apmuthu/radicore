<?php
    // file created on January 18, 2006, 6:35 pm
    
    // field specifications for table menu.mnu_dialog_type
    $fieldspec['dialog_type_id']            = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['dialog_type_desc']          = array('type' => 'string',
                                                    'size' => 60,
                                                    'required' => 'y');
    
    $fieldspec['dialog_type_long_desc']     = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 50,
                                                    'rows' => 5);
    
    $fieldspec['visible_screen']            = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N');
    
    $fieldspec['context_preselect']         = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N');
    
    $fieldspec['keep_data']                 = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N');
    
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
    $this->primary_key                      = array('dialog_type_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'mnu_task',
                                                    'type' => 'RES',
                                                    'fields' => array('dialog_type_id' => 'dialog_type_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'dialog_type_id';
    
    // finished
?>