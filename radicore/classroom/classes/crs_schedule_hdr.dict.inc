<?php
    // file created on July 28, 2005, 12:41 pm
    
    // field specifications for table classroom.crs_schedule_hdr
    $fieldspec['schedule_id']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['schedule_desc']             = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['schedule_notes']            = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);
    
    $fieldspec['is_active']                 = array('type' => 'boolean',
                                                    'true' => 'Y',
                                                    'false' => 'N');
    
    $fieldspec['start_time']                = array('type' => 'time',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'default' => '00:00:00');
    
    $fieldspec['end_time']                  = array('type' => 'time',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'default' => '00:00:00');
    
    $fieldspec['last_day_no']               = array('type' => 'integer',
                                                    'size' => 1,
                                                    'minvalue' => 1,
                                                    'maxvalue' => 7,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'day_no');
    
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
    $this->primary_key                      = array('schedule_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'crs_schedule',
                                                    'type' => 'RES',
                                                    'fields' => array('schedule_id' => 'schedule_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // finished
?>