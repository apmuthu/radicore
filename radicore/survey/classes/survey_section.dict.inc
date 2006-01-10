<?php
    // file created on April 24, 2005, 7:29 pm
    
    // field specifications for table survey.survey_section
    $fieldspec['survey_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['section_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['section_seq']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['section_name']              = array('type' => 'string',
                                                    'size' => 80,
                                                    'required' => 'y');
    
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
    $this->primary_key                      = array('survey_id',
                                                    'section_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'answer_option',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id',
                                                                      'section_id' => 'section_id'));
    
    $this->child_relations[]                = array('child' => 'number_option',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id',
                                                                      'section_id' => 'section_id'));
    
    $this->child_relations[]                = array('child' => 'question_prompt',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id',
                                                                      'section_id' => 'section_id'));
    
    $this->child_relations[]                = array('child' => 'survey_answer_dtl',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id',
                                                                      'section_id' => 'section_id'));
    
    $this->child_relations[]                = array('child' => 'survey_question',
                                                    'type' => 'RES',
                                                    'fields' => array('survey_id' => 'survey_id',
                                                                      'section_id' => 'section_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'survey_hdr',
                                                    'parent_field' => 'survey_name',
                                                    'fields' => array('survey_id' => 'survey_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>