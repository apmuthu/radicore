<?php
    // file created on July 28, 2005, 12:41 pm
    
    // field specifications for table classroom.crs_schedule
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
    
    $fieldspec['schedule_errors']           = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5,
                                                    'noedit' => 'y');
    
    $fieldspec['is_valid']                  = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N',
                                                    'noedit' => 'y');
    
    $fieldspec['lesson_id']                 = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'lesson_id');
    
    $fieldspec['end_time']                  = array('type' => 'time',
                                                    'size' => 5,
                                                    'required' => 'y',
                                                    'default' => '00:00:00');
    
    $fieldspec['start_time']                = array('type' => 'time',
                                                    'size' => 5,
                                                    'required' => 'y',
                                                    'default' => '00:00:00');
    
    $fieldspec['day_no']                    = array('type' => 'integer',
                                                    'size' => 1,
                                                    'minvalue' => 1,
                                                    'maxvalue' => 7,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'day_no');
    
    $fieldspec['room_id']                   = array('type' => 'string',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'room_id');
    
    $fieldspec['seq_no']                    = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['schedule_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    // primary key details 
    $this->primary_key                      = array('schedule_id',
                                                    'seq_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'crs_lesson',
                                                    'parent_field' => 'lesson_name',
                                                    'fields' => array('lesson_id' => 'lesson_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_room',
                                                    'parent_field' => 'room_desc',
                                                    'fields' => array('room_id' => 'room_id'));
    
    $this->parent_relations[]               = array('parent' => 'crs_schedule_hdr',
                                                    'parent_field' => 'schedule_desc',
                                                    'fields' => array('schedule_id' => 'schedule_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>