<?php
    // file created on May 31, 2009, 3:37 pm
    
    // field specifications for table xample.x_tree_node
    $fieldspec['node_id']                   = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['tree_type_id']              = array('type' => 'string',
                                                    'size' => 8,
                                                    'required' => 'y',
                                                    'uppercase' => 'y');
    
    $fieldspec['tree_level_id']             = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'required' => 'y',
                                                    'default' => '0');
    
    $fieldspec['node_desc']                 = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['node_id_snr']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'noedit' => 'y');
    
    $fieldspec['external_code']             = array('type' => 'string',
                                                    'size' => 255);
    
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
    $this->primary_key                      = array('node_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'x_person',
                                                    'type' => 'RES',
                                                    'fields' => array('node_id' => 'node_id'));
    
    $this->child_relations[]                = array('child' => 'x_tree_node',
                                                    'alias' => 'x_tree_node_jnr',
                                                    'type' => 'RES',
                                                    'fields' => array('node_id' => 'node_id_snr'));
    
    $this->child_relations[]                = array('child' => 'x_tree_node_alt',
                                                    'type' => 'DEL',
                                                    'fields' => array('node_id' => 'node_id'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'x_tree_level',
                                                    'parent_field' => 'tree_level_seq, tree_level_desc',
                                                    'alt_language_table' => 'x_tree_level_alt',
                                                    'alt_language_cols' => 'tree_level_desc',
                                                    'fields' => array('tree_type_id' => 'tree_type_id',
                                                                      'tree_level_id' => 'tree_level_id'));
    
    $this->parent_relations[]               = array('parent' => 'x_tree_node',
                                                    'alias' => 'x_tree_node_snr',
                                                    'parent_field' => 'node_desc AS node_desc_snr',
                                                    'alt_language_table' => 'x_tree_node_alt',
                                                    'alt_language_cols' => 'node_desc',
                                                    'fields' => array('node_id_snr' => 'node_id'));
    
    $this->parent_relations[]               = array('parent' => 'x_tree_type',
                                                    'parent_field' => 'tree_type_desc',
                                                    'alt_language_table' => 'x_tree_type_alt',
                                                    'alt_language_cols' => 'tree_type_desc',
                                                    'fields' => array('tree_type_id' => 'tree_type_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'tree_level_id, node_id';
    
    // alternative language options 
    $this->alt_language_table               = 'x_tree_node_alt';
    $this->alt_language_cols                = 'node_desc';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>