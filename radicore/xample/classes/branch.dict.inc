<?php
    // file created on May 31, 2009, 3:37 pm

    // field specifications for table xample.x_tree_type
    $fieldspec['branch_id']                 = array('type' => 'string',
                                                    'size' => 8,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');

    $fieldspec['branch_desc']               = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');

    $fieldspec['branch_abbrev']             = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');

    $fieldspec['syllabus_type_id']          = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');

    $fieldspec['student_branch_abbrev']     = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');

    $fieldspec['crf_type_id']               = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');

    $fieldspec['session_type_id']           = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');

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
    $this->primary_key                      = array('branch_id');

    // unique key details
    $this->unique_keys                      = array();

    // child relationship details
    $this->child_relations                  = array();

    // parent relationship details
    $this->parent_relations                 = array();

    // try adding this entry to x_person_addr.dict.inc
//    $this->parent_relations[]               = array('parent' => 'branch',
//                                                    'parent_field' => 'branch_id, branch_desc, branch_abbrev, syllabus_type_id, student_branch_abbrev, crf_type_id, session_type_id as branch_session_type_id',
//                                                    'fields' => array('branch_id' => 'branch_id'));

    // determines if database updates are recorded in an audit log
    $this->audit_logging                    = TRUE;

    // default sort sequence
    $this->default_orderby                  = 'branch_id';

    // alternative language options
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';

    // alias names
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';

    // finished
?>