<?php
    // file created on July 28, 2005, 12:41 pm
    
    // field specifications for table classroom.crs_student
    $fieldspec['revised_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['revised_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'autoupdate' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '0000-00-00 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y');
    
    $fieldspec['student_notes']             = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['class_id']                  = array('type' => 'string',
                                                    'size' => 8,
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'class_id');
    
    $fieldspec['year']                      = array('type' => 'numeric',
                                                    'size' => 2,
                                                    'precision' => 1,
                                                    'scale' => 0,
                                                    'minvalue' => 1,
                                                    'maxvalue' => 9);
    
    $fieldspec['initials']                  = array('type' => 'string',
                                                    'size' => 4,
                                                    'uppercase' => 'y');
    
    $fieldspec['last_name']                 = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['first_name']                = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['student_id']                = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
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
    
    // finished
?>