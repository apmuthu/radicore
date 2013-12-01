<?php
    // file created on January 1, 2013, 1:32 pm
    
    // field specifications for table menu.mnu_language
    $fieldspec['language_id']               = array('type' => 'string',
                                                    'size' => 5,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'default' => 'EN',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'language_id');
    
    $fieldspec['language_name']             = array('type' => 'string',
                                                    'size' => 40,
                                                    'required' => 'y',
                                                    'default' => 'English');
    
    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2000-01-01 00:00:00',
                                                    'autoinsert' => 'y',
                                                    'noedit' => 'y',
                                                    'nosearch' => 'y');
    
    $fieldspec['created_user']              = array('type' => 'string',
                                                    'size' => 16,
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
    $this->primary_key                      = array('language_id');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations[]                = array('child' => 'content_alt',
                                                    'dbname' => 'content',
                                                    'subsys_dir' => 'content',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'email_text_alt',
                                                    'dbname' => 'invoice',
                                                    'subsys_dir' => 'invoice',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'help_text_alt',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_task_alt',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'mnu_user',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_code'));
    
    $this->child_relations[]                = array('child' => 'item_adjustment_type_alt',
                                                    'dbname' => 'order',
                                                    'subsys_dir' => 'order',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'order_adjustment_type_alt',
                                                    'dbname' => 'order',
                                                    'subsys_dir' => 'order',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'order_item_status_type_alt',
                                                    'dbname' => 'order',
                                                    'subsys_dir' => 'order',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'order_status_type_alt',
                                                    'dbname' => 'order',
                                                    'subsys_dir' => 'order',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'sale_type',
                                                    'dbname' => 'order',
                                                    'subsys_dir' => 'order',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_code'));
    
    $this->child_relations[]                = array('child' => 'geographic_area_alt',
                                                    'dbname' => 'party',
                                                    'subsys_dir' => 'party',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'party',
                                                    'dbname' => 'party',
                                                    'subsys_dir' => 'party',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_code'));
    
    $this->child_relations[]                = array('child' => 'product_alt',
                                                    'dbname' => 'product',
                                                    'subsys_dir' => 'product',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'product_category_alt',
                                                    'dbname' => 'product',
                                                    'subsys_dir' => 'product',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'product_feature_alt',
                                                    'dbname' => 'product',
                                                    'subsys_dir' => 'product',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    $this->child_relations[]                = array('child' => 'product_feature_category_alt',
                                                    'dbname' => 'product',
                                                    'subsys_dir' => 'product',
                                                    'type' => 'RES',
                                                    'fields' => array('language_id' => 'language_id'));
    
    // parent relationship details 
    $this->parent_relations                 = array();
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'language_id';
    
    // alternative language options 
    $this->alt_language_table               = '';
    $this->alt_language_cols                = '';
    
    // alias names 
    $this->nameof_start_date                = '';
    $this->nameof_end_date                  = '';
    
    // finished
?>