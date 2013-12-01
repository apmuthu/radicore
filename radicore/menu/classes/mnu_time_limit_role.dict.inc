<?php
    // file created on April 27, 2013, 9:57 pm
    
    // field specifications for table menu.mnu_time_limit_role
    $fieldspec['role_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['seq_no']                    = array('type' => 'integer',
                                                    'type_native' => 'smallint',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['scheduled_start_time']      = array('type' => 'time',
                                                    'size' => 10,
                                                    'required' => 'y',
                                                    'default' => '09:00:00');
    
    $fieldspec['scheduled_end_time']        = array('type' => 'time',
                                                    'size' => 10,
                                                    'required' => 'y',
                                                    'default' => '17:00:00');
    
    $fieldspec['scheduled_monday']          = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Monday');
    
    $fieldspec['scheduled_tuesday']         = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Tuesday',
                                                    'align_lr' => 'R');
    
    $fieldspec['scheduled_wednesday']       = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Wednesday',
                                                    'align_lr' => 'R');
    
    $fieldspec['scheduled_thursday']        = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Thursday',
                                                    'align_lr' => 'R');
    
    $fieldspec['scheduled_friday']          = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '1',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Friday',
                                                    'align_lr' => 'R');
    
    $fieldspec['scheduled_saturday']        = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Saturday',
                                                    'align_lr' => 'R');
    
    $fieldspec['scheduled_sunday']          = array('type' => 'boolean',
                                                    'type_native' => 'tinyint',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'true' => '1',
                                                    'false' => '0',
                                                    'control' => 'checkbox',
                                                    'label' => 'Sunday',
                                                    'align_lr' => 'R');
    
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
                                                    'seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_role',
                                                    'parent_field' => 'role_desc',
                                                    'fields' => array('role_id' => 'role_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'role_id, seq_no';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>