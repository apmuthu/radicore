<?php
    // file created on November 3, 2006, 11:07 am
    
    // field specifications for table classroom.crs_conflict
    $fieldspec['conflict_id']               = array('type' => 'integer',
                                                    'size' => 10,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 4294967295,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['conflict_type']             = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'conflict_type');
    
    $fieldspec['teacher_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'teacher_id');
    
    $fieldspec['student_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'control' => 'popup',
                                                    'task_id' => 'crs_student(popup)',
                                                    'foreign_field' => 'student_name');
    
    $fieldspec['class_id']                  = array('type' => 'string',
                                                    'size' => 8,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'class_id');
    
    $fieldspec['lesson_id1']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'lesson_id');
    
    $fieldspec['lesson_id2']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'lesson_id');
    
    // primary key details 
    $this->primary_key                      = array('conflict_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'crs_class',
                                                    'parent_field' => 'class_name',
                                                    'fields' => array('class_id' => 'class_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_lesson',
                                                    'alias' => 'crs_lesson1',
                                                    'parent_field' => 'lesson_name AS lesson_name1',
                                                    'fields' => array('lesson_id1' => 'lesson_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_lesson',
                                                    'alias' => 'crs_lesson2',
                                                    'parent_field' => 'lesson_name AS lesson_name2',
                                                    'fields' => array('lesson_id2' => 'lesson_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_student',
                                                    'parent_field' => 'CONCAT(last_name, \', \', first_name) AS student_name',
                                                    'fields' => array('student_id' => 'student_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_teacher',
                                                    'parent_field' => 'CONCAT(title, \' \', first_name, \' \', last_name) AS teacher_name',
                                                    'fields' => array('teacher_id' => 'teacher_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = FALSE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>