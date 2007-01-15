<?php
    // file created on November 3, 2006, 11:23 am
    
    // field specifications for table menu.mnu_menu
    $fieldspec['menu_id']                   = array('type' => 'string',
                                                    'size' => 40,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['task_id_jnr']               = array('type' => 'string',
                                                    'size' => 40,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'lowercase' => 'y');
    
    $fieldspec['sort_seq']                  = array('type' => 'integer',
                                                    'size' => 3,
                                                    'zerofill' => 'y',
                                                    'minvalue' => 0,
                                                    'maxvalue' => 255,
                                                    'required' => 'y',
                                                    'default' => '000');
    
    $fieldspec['button_text']               = array('type' => 'string',
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
    $this->primary_key                      = array('menu_id',
                                                    'task_id_jnr');
    
    // unique key details 
    $this->unique_keys                      = array();
    
    // child relationship details 
    $this->child_relations                  = array();
    
    // parent relationship details 
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'alias' => 'mnu_task_snr',
                                                    'parent_field' => 'task_desc AS task_desc_snr',
                                                    'fields' => array('menu_id' => 'task_id'));
    
    $this->parent_relations[]               = array('parent' => 'mnu_task',
                                                    'alias' => 'mnu_task_jnr',
                                                    'parent_field' => 'task_desc AS task_desc_jnr',
                                                    'fields' => array('task_id_jnr' => 'task_id'));
    
    // determines if database updates are recorded in an audit log 
    $this->audit_logging                    = TRUE;
    
    // default sort sequence 
    $this->default_orderby                  = 'sort_seq';
    
    // finished
?>