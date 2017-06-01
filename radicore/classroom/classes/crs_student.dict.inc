<?php
    // file created on April 17, 2017, 12:45 pm
    
    // field specifications for table classroom.crs_student
    $fieldspec['student_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['first_name']                = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['last_name']                 = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['initials']                  = array('type' => 'string',
                                                    'size' => 4,
                                                    'uppercase' => 'y');
    
    $fieldspec['year']                      = array('type' => 'numeric',
                                                    'size' => 2,
                                                    'precision' => 1,
                                                    'scale' => 0,
                                                    'blank_when_zero' => 'y',
                                                    'minvalue' => 1,
                                                    'maxvalue' => 9);
    
    $fieldspec['class_id']                  = array('type' => 'string',
                                                    'size' => 8,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'class_id');
    
    $fieldspec['student_notes']             = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
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
    $this->primary_key                      = array('student_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'crs_conflict',
                                                    'type' => 'DEL',
                                                    'fields' => array('student_id' => 'student_id'));
    
    $this->child_relations[]                = array('child' => 'crs_student_lesson',
                                                    'type' => 'RES',
                                                    'fields' => array('student_id' => 'student_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'crs_class',
                                                    'parent_field' => 'class_name',
                                                    'fields' => array('class_id' => 'class_id'));
    
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