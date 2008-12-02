<?php
    // file created on July 7, 2008, 4:43 pm
    
    // field specifications for table xample.x_tree_level_alt
    $fieldspec['tree_type_id']              = array('type' => 'string',
                                                    'size' => 8,
                                                    'pkey' => 'y',
                                                    'required' => 'y');
    
    $fieldspec['tree_level_id']             = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['language_id']               = array('type' => 'string',
                                                    'size' => 5,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'language_id');
    
    $fieldspec['tree_level_desc']           = array('type' => 'string',
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
                                                    'default' => 'UKNOWN',
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
    $this->primary_key                      = array('tree_type_id',
                                                    'tree_level_id',
                                                    'language_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'x_tree_level',
                                                    'alt_language_table' => 'x_tree_level_alt',
                                                    'alt_language_cols' => 'tree_level_desc',
                                                    'fields' => array('tree_type_id' => 'tree_type_id',
                                                                      'tree_level_id' => 'tree_level_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = '';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // finished
?>