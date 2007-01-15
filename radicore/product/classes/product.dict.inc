<?php
    // file created on November 3, 2006, 11:29 am

    // field specifications for table product.product
    $fieldspec['product_id']                = array('type' => 'string',
                                                    'size' => 16,
                                                    'pkey' => 'y',
                                                    'required' => 'y',
                                                    'uppercase' => 'y');

    $fieldspec['product_name']              = array('type' => 'string',
                                                    'size' => 255,
                                                    'required' => 'y');

    $fieldspec['date_intro']                = array('type' => 'date',
                                                    'size' => 12);

    $fieldspec['end_date_sales']            = array('type' => 'date',
                                                    'size' => 12);

    $fieldspec['end_date_support']          = array('type' => 'date',
                                                    'size' => 12);

    $fieldspec['prod_comment']              = array('type' => 'string',
                                                    'size' => 255,
                                                    'control' => 'multiline',
                                                    'cols' => 70,
                                                    'rows' => 5);

    $fieldspec['product_subtype']           = array('type' => 'string',
                                                    'size' => 1,
                                                    'required' => 'y',
                                                    'default' => 'G',
                                                    'uppercase' => 'y',
                                                    'control' => 'dropdown',
                                                    'optionlist' => 'product_subtype');

    $fieldspec['uom_id']                    = array('type' => 'string',
                                                    'size' => 16,
                                                    'uppercase' => 'y',
                                                    'control' => 'popup',
                                                    'task_id' => 'pro_uom(popup)',
                                                    'foreign_field' => 'uom_desc');

    $fieldspec['created_date']              = array('type' => 'datetime',
                                                    'size' => 20,
                                                    'required' => 'y',
                                                    'default' => '2001-01-01 00:00:00',
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
    $this->primary_key                      = array('product_id');

    // unique key details
    $this->unique_keys                      = array();

    // child relationship details
    $this->child_relations[]                = array('child' => 'good_identification',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'inventory_item',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'inventory_item_status_hist',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'inventory_item_variance',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'price_component',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'prod_cat_class',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'prod_feature_applicability',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    $this->child_relations[]                = array('child' => 'prod_feature_interaction',
                                                    'type' => 'RES',
                                                    'fields' => array('product_id' => 'product_id'));

    // parent relationship details
    $this->parent_relations[]               = array('parent' => 'unit_of_measure',
                                                    'parent_field' => 'uom_desc, uom_abbrev',
                                                    'fields' => array('uom_id' => 'uom_id'));

    // determines if database updates are recorded in an audit log
    $this->audit_logging                    = TRUE;

    // default sort sequence
    $this->default_orderby                  = '';

    // finished
?>