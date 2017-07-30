<?php
    // file created on November 21, 2008, 9:35 pm

    // field specifications for table menu.mnu_file
    $fieldspec['file_id']                   = array('type' => 'string',
                                                    'size' => 255);

    $fieldspec['filename']                  = array('type' => 'string',
                                                    'size' => 255);

    $fieldspec['file_name']                 = array('type' => 'string',
                                                    'size' => 255);

    // primary key details
    $this->primary_key                      = array('file_name');

    // default sort sequence
    $this->default_orderby                  = 'file_date';

    // finished
?>