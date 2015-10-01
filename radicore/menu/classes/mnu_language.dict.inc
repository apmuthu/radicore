<?php
    // file created on September 22, 2015, 10:08 am
    
    // field specifications for table menu.mnu_language
    $fieldspec['language_id']               = array('type' => 'string',
                                                    'size' => 5,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'language_id');
    
    $fieldspec['language_name']             = array('type' => 'string',
                                                    'size' => 40);
    
    $fieldspec['input_date_format']         = array('type' => 'string',
                                                    'size' => 12,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'date_format');
    
    $fieldspec['output_date_format']        = array('type' => 'string',
                                                    'size' => 12,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'date_format');
    
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
    $this->primary_key                      = array('language_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'help_text_alt',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_alt',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user_alt',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'language_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>