<?php
    // file created on April 17, 2017, 12:45 pm
    
    // field specifications for table classroom.crs_lesson
    $fieldspec['lesson_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['lesson_name']               = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['lesson_short_name']         = array('type' => 'string',
                                                    'size' => 30,
                                                    'required' => 'y');
    
    $fieldspec['year']                      = array('type' => 'numeric',
                                                    'size' => 2,
                                                    'precision' => 1,
                                                    'scale' => 0,
                                                    'blank_when_zero' => 'y',
                                                    'minvalue' => 1,
                                                    'maxvalue' => 9);
    
    $fieldspec['teacher_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'teacher_id');
    
    $fieldspec['lesson_notes']              = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['subject_id']                = array('type' => 'string',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'subject_id');
    
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
    $this->primary_key                      = array('lesson_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'crs_class_lesson',
                                                    'type' => 'RES',
                                                    'fields' => array('lesson_id' => 'lesson_id'));
    
    $this->child_relations[]                = array('child' => 'crs_conflict',
                                                    'alias' => 'crs_conflict1',
                                                    'type' => 'DEL',
                                                    'fields' => array('lesson_id' => 'lesson_id1'));
    
    $this->child_relations[]                = array('child' => 'crs_conflict',
                                                    'alias' => 'crs_conflict2',
                                                    'type' => 'DEL',
                                                    'fields' => array('lesson_id' => 'lesson_id2'));
    
    $this->child_relations[]                = array('child' => 'crs_schedule',
                                                    'type' => 'RES',
                                                    'fields' => array('lesson_id' => 'lesson_id'));
    
    $this->child_relations[]                = array('child' => 'crs_student_lesson',
                                                    'type' => 'RES',
                                                    'fields' => array('lesson_id' => 'lesson_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'crs_subject',
                                                    'parent_field' => 'subject_name',
                                                    'fields' => array('subject_id' => 'subject_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_teacher',
                                                    'parent_field' => 'CONCAT(title, \' \', first_name, \' \', last_name) AS teacher_name',
                                                    'fields' => array('teacher_id' => 'teacher_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'lesson_name';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>