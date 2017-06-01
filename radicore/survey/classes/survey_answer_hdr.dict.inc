<?php
    // file created on April 17, 2017, 1:01 pm
    
    // field specifications for table survey.survey_answer_hdr
    $fieldspec['survey_answer_id']          = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['user_id']                   = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'mnu_user(popup1)',
                                                    'foreign_field' => 'user_name');
    
    $fieldspec['answer_date']               = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00');
    
    $fieldspec['survey_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'srv_survey_hdr(popup)',
                                                    'foreign_field' => 'survey_name');
    
    $fieldspec['node_id']                   = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'srv_tree_node(popup)',
                                                    'foreign_field' => 'node_desc');
    
    $fieldspec['is_complete']               = array('type' => 'boolean',
                                                    'type_native' => 'char',
                                                    'required' => 'y',
                                                    'default' => 'N',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'control' => 'radio',
                                                    'optionlist' => 'boolean',
                                                    'noedit' => 'y');
    
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
    $this->primary_key                      = array('survey_answer_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'survey_answer_dtl',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_answer_id' => 'survey_answer_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_user',
                                                    'dbname' => 'menu',
                                                    'subsys_dir' => 'menu',
                                                    'parent_field' => 'user_name',
                                                    'alt_language_table' => 'mnu_user_alt',
                                                    'alt_language_cols' => 'user_name',
                                                    'fields' => array('user_id' => 'user_id'));
    
    $this->parent_relations[]               = array('parent' => 'survey_hdr',
                                                    'parent_field' => 'survey_name',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->parent_relations[]               = array('parent' => 'tree_node',
                                                    'parent_field' => 'node_desc',
                                                    'fields' => array('node_id' => 'node_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>