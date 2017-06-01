<?php
    // file created on April 17, 2017, 12:45 pm
    
    // field specifications for table classroom.crs_student_lesson
    $fieldspec['student_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['lesson_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    // primary key details 
    $this->primary_key                      = array('student_id',
                                                    'lesson_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'crs_lesson',
                                                    'parent_field' => 'lesson_name',
                                                    'fields' => array('lesson_id' => 'lesson_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_student',
                                                    'parent_field' => 'CONCAT(last_name, \', \', first_name) AS student_name',
                                                    'fields' => array('student_id' => 'student_id'));
    
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