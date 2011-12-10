<?php
    // file created on January 10, 2008, 5:34 pm
    
    // field specifications for table xample.x_tree_type
    $fieldspec['tree_type_id']              = array('type' => 'string',
                                                    'size' => 8,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['tree_type_desc']            = array('type' => 'string',
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
    $this->primary_key                      = array('tree_type_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'x_tree_level',
                                                    'type' => 'RES',
                                                    'fields' => array('tree_type_id' => 'tree_type_id'));
    
    $this->child_relations[]                = array('child' => 'x_tree_node',
                                                    'type' => 'RES',
                                                    'fields' => array('tree_type_id' => 'tree_type_id'));
    
    $this->child_relations[]                = array('child' => 'x_tree_type_alt',
                                                    'type' => 'DEL',
                                                    'fields' => array('tree_type_id' => 'tree_type_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'x_tree_type.tree_type_id';
    
    // alternative language options 
    $this->alt_language_table               = 'x_tree_type_alt';
    $this->alt_language_cols                = 'tree_type_desc';
    
    // finished
?>