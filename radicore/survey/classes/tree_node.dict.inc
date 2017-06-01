<?php
    // file created on April 17, 2017, 1:01 pm
    
    // field specifications for table survey.tree_node
    $fieldspec['node_id']                   = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['node_desc']                 = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y');
    
    $fieldspec['node_type']                 = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'node_type');
    
    $fieldspec['node_depth']                = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'required' => 'y',
                                                    'default' => '0',
                                                    'noedit' => 'y');
    
    $fieldspec['node_id_snr']               = array('type' => 'integer',
                                                    'size' => 5,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 65535,
                                                    'noedit' => 'y');
    
    $fieldspec['org_type_id']               = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'org_type_id');
    
    $fieldspec['location_type_id']          = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'location_type_id');
    
    $fieldspec['asset_type_id']             = array('type' => 'integer',
                                                    'size' => 3,
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'asset_type_id');
    
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
    $this->child_relations[]                = array('child' => 'location_address',
                                                    'type' => 'DEL',
                                                    'fields' => array('node_id' => 'node_id'));
    
    $this->child_relations[]                = array('child' => 'survey_answer_hdr',
                                                    'type' => 'DEL',
                                                    'fields' => array('node_id' => 'node_id'));
    
    $this->child_relations[]                = array('child' => 'tree_node',
                                                    'alias' => 'tree_node_jnr',
                                                    'type' => 'RES',
                                                    'fields' => array('node_id' => 'node_id_snr'));
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'asset_type',
                                                    'parent_field' => 'asset_type_desc',
                                                    'fields' => array('asset_type_id' => 'asset_type_id'));
    
    $this->parent_relations[]               = array('parent' => 'location_type',
                                                    'parent_field' => 'location_type_desc',
                                                    'fields' => array('location_type_id' => 'location_type_id'));
    
    $this->parent_relations[]               = array('parent' => 'org_type',
                                                    'parent_field' => 'org_type_desc',
                                                    'fields' => array('org_type_id' => 'org_type_id'));
    
    $this->parent_relations[]               = array('parent' => 'tree_node',
                                                    'alias' => 'tree_node_snr',
                                                    'parent_field' => 'node_desc AS node_desc_snr',
                                                    'fields' => array('node_id_snr' => 'node_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'node_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>