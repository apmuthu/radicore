<?php
    // file created on April 17, 2017, 12:45 pm
    
    // field specifications for table classroom.crs_class_lesson
    $fieldspec['class_id']                  = array('type' => 'string',
                                                    'size' => 8,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['lesson_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    // primary key details 
    $this->primary_key                      = array('class_id',
                                                    'lesson_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'crs_class',
                                                    'parent_field' => 'class_name',
                                                    'fields' => array('class_id' => 'class_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_lesson',
                                                    'parent_field' => 'lesson_name',
                                                    'fields' => array('lesson_id' => 'lesson_id'));
    
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