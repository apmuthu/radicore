<?php
    // file created on April 24, 2005, 7:29 pm
    
    // field specifications for table survey.survey_hdr
    $fieldspec['survey_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['survey_name']               = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
    $fieldspec['survey_desc']               = array('type' => 'string',
                                                    'size' => 255,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['survey_type_id']            = array('type' => 'string',
                                                    'size' => 4,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'survey_type_id');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
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
    $this->primary_key                      = array('survey_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'answer_option',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'default_prompt',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'number_option',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'question_prompt',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'survey_answer_dtl',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'survey_answer_hdr',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'survey_question',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    $this->child_relations[]                = array('child' => 'survey_section',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'survey_type',
                                                    'parent_field' => 'survey_type_desc',
                                                    'fields' => array('survey_type_id' => 'survey_type_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>