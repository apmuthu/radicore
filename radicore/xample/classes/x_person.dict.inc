<?php
    // file created on April 8, 2007, 2:29 pm
    
    // field specifications for table xample.x_person
    $fieldspec['person_id']                 = array('type' => 'string',
                                                    'size' => 8,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['pers_type_id']              = array('type' => 'string',
                                                    'size' => 6,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'pers_type_id');
    
    $fieldspec['node_id']                   = array('type' => 'integer',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'control' => 'popup',
                                                    'task_id' => 'x_tree_structure(popup)',
                                                    'foreign_field' => 'node_desc');
    
    $fieldspec['nat_ins_no']                = array('type' => 'string',
                                                    'size' => 10,
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['first_name']                = array('type' => 'string',
                                                    'size' => 20,
                                                    'required' => 'y');
    
    $fieldspec['last_name']                 = array('type' => 'string',
                                                    'size' => 30,
                                                    'required' => 'y');
    
    $fieldspec['initials']                  = array('type' => 'string',
                                                    'size' => 6,
                                                    'uppercase' => 'y');
    
    $fieldspec['star_sign']                 = array('type' => 'string',
                                                    'size' => 3,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'star_sign');
    
    $fieldspec['email_addr']                = array('type' => 'string',
                                                    'size' => 50,
                                                    'subtype' => 'email');
    
    $fieldspec['value1']                    = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535);
    
    $fieldspec['value2']                    = array('type' => 'numeric',
                                                    'size' => 12,
                                                    'precision' => 10,
                                                    'scale' => 2,
                                                    'blank_when_zero' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 99999999.99);
    
    $fieldspec['last_addr_no']              = array('type' => 'integer',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['start_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01');
    
    $fieldspec['end_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'default' => '9999-12-31',
                                                    'infinityisnull' => 'y');
    
    $fieldspec['picture']                   = array('type' => 'string',
                                                    'size' => 40,
                                                    'subtype' => 'image',
                                                    'imagewidth' => 75,
                                                    'imageheight' => 95,
                                                    'control' => 'filepicker',
                                                    'task_id' => 'x_person(filepicker)');
    
    $fieldspec['favourite_food']            = array('type' => 'array',
                                                    'size' => 255,
                                                    'values' => array(1 => '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'),
                                                    'control' => 'multidrop',
                                                    'optionlist' => 'favourite_food',
                                                    'rows' => 5);
    
    $fieldspec['fckeditor_test']            = array('type' => 'string',
                                                    'size' => 65535,
                                                    'control' => 'multiline',
                                                    'cols' => 60,
                                                    'rows' => 10);
    
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
    $this->primary_key                      = array('person_id');
    
    // unique key details 
    $this->unique_keys[]                    = array('nat_ins_no');
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'x_pers_opt_xref',
                                                    'type' => 'RES',
                                                    'fields' => array('person_id' => 'person_id'));
    
    $this->child_relations[]                = array('child' => 'x_person_addr',
                                                    'type' => 'DEL',
                                                    'orderby' => 'address_no desc',
                                                    'fields' => array('person_id' => 'person_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'x_pers_type',
                                                    'parent_field' => 'pers_type_desc',
                                                    'fields' => array('pers_type_id' => 'pers_type_id'));
    
    $this->parent_relations[]               = array('parent' => 'x_tree_node',
                                                    'parent_field' => 'node_desc',
                                                    'fields' => array('node_id' => 'node_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'person_id';
    
    // finished
?>