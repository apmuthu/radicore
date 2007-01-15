<?php
    // file created on October 9, 2006, 10:31 am
    
    // field specifications for table xample.x_person_addr
    $fieldspec['person_id']                 = array('type' => 'string',
                                                    'size' => 8,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['address_no']                = array('type' => 'integer',
                                                    'size' => 4,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['telephone_no']              = array('type' => 'string',
                                                    'size' => 20,
                                                    'subtype' => 'custom',
                                                    'custom_validation' => 'sample.validation.class.inc/sample_validation_class/telephone_no');
    
    $fieldspec['fax_no']                    = array('type' => 'string',
                                                    'size' => 20,
                                                    'subtype' => 'custom',
                                                    'custom_validation' => 'sample.validation.class.inc/sample_validation_class/fax_no');
    
    $fieldspec['addr_line_1']               = array('type' => 'string',
                                                    'size' => 30,
                                                    'required' => 'y');
    
    $fieldspec['addr_line_2']               = array('type' => 'string',
                                                    'size' => 30);
    
    $fieldspec['addr_line_3']               = array('type' => 'string',
                                                    'size' => 30);
    
    $fieldspec['town']                      = array('type' => 'string',
                                                    'size' => 30,
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['county']                    = array('type' => 'string',
                                                    'size' => 30);
    
    $fieldspec['postcode']                  = array('type' => 'string',
                                                    'size' => 10,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'subtype' => 'custom',
                                                    'custom_validation' => 'sample.validation.class.inc/sample_validation_class/postcode');
    
    $fieldspec['start_date']                = array('type' => 'date',
                                                    'size' => 12,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01');
    
    $fieldspec['end_date']                  = array('type' => 'date',
                                                    'size' => 12,
                                                    'default' => '9999-12-31',
                                                    'infinityisnull' => 'y');
    
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
    $this->primary_key                      = array('person_id',
                                                    'address_no');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'x_person',
                                                    'parent_field' => 'CONCAT(first_name, \' \', last_name) AS person_name',
                                                    'fields' => array('person_id' => 'person_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'person_id, address_no';
    
    // finished
?>