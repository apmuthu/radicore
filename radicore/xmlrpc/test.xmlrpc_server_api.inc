<?php
// xmlrpc_api.php

// Define an array to name the xmlrpc methods and their corresponding PHP functions
$xmlrpc_methods = array();
$xmlrpc_methods['menu.getPatternList'] = 'menu_getPatternList';
$xmlrpc_methods['menu.viewPatternId'] = 'menu_viewPatternId';
$xmlrpc_methods['menu.getAnswer'] = 'menu_getAnswer';

// ****************************************************************************
function menu_getAnswer ($func, $params, $user_data)
// return a single value as the result
{
    $response = 'this is the answer';

//    XMLRPC_fatal_error(5331, "this is a fatal error message");

    $errors['field1'] = 'this field is invalid';
    $errors['field2'] = 'this field is also invalid';
//    XMLRPC_non_fatal_error($errors);

    return $response;

} // menu_getAnswer
// ****************************************************************************
function menu_getPatternList ( $func, $params, $user_data )
// list entries from the MNU_PATTERN table.
{
    if (is_int(key($params))) {
    	$params = $params[0];
    } // if

    // instantiate object to access the database
    $dbobject = singleton::getInstance('mnu_pattern');

    if ( isset ( $params['order'] ) ) {
        $order = $params['order'];
    } // if
    $dbobject->setOrderBy($order, 'ASC');

    if ( isset ( $params['page_size'] ) AND $params['page_size'] <= 20 ) {
        $page_size = $params['page_size'];
    } else {
        $page_size = 20;
    } // if
    $dbobject->setRowsPerPage($page_size);

    if ( isset ( $params['page_no'] ) ) {
        $page_no = $params['page_no'];
    } else {
        $page_no = 1;
    } // if
    $dbobject->setPageNo($page_no);

    // issue the query
    $resource = $dbobject->getData_serial();
    if ( $resource ) {
        $entries = array();
        while ( $result = $dbobject->fetchRow ( $resource ) ) {

            // Extract the variables we want to send in our response
            $entry['pattern_id']    = $result['pattern_id'];
            $entry['pattern_desc']  = $result['pattern_desc'];
            //xmlrpc_set_type($news_item['date'], 'datetime');

            // Add to the output array
            $entries[] = $entry;
        } // while

        $response = $entries;
    } else {
        // there was an error, so respond with an error message
        XMLRPC_fatal_error(1234, "menu_getPatternList() error: Unable to read entries");
    } // if
    return $response;
} // menu_getPatternList

// ****************************************************************************
function menu_viewPatternId ( $func, $params, $user_data )
// view a full news item corresponding to the news.viewNewsItem method
{
    if (is_int(key($params))) {
    	$params = $params[0];
    } // if

    // instantiate object to access the database
    $dbobject = singleton::getInstance('mnu_pattern');

    if (isset($params['pattern_id'])) {
    	$pattern_id = $params['pattern_id'];
    } else {
        $pattern_id = '';
    } // if

    // issue the query
    $resource = $dbobject->getData_serial("pattern_id='$pattern_id'");

    if ( $result = $dbobject->fetchRow ( $resource ) ) {

        // Extract the variables we want to send in our response
        $entry['pattern_id']    = $result['pattern_id'];
        $entry['pattern_desc']  = $result['pattern_desc'];
        $entry['pattern_long_desc']  = $result['pattern_long_desc'];
        $entry['pattern_desc']  = $result['pattern_desc'];
        $entry['visible_screen']  = $result['visible_screen'];
        $entry['context_preselect']  = $result['context_preselect'];
        $entry['keep_data']  = $result['keep_data'];
        $entry['created_date']  = $result['created_date'];
        xmlrpc_set_type($entry['created_date'], 'datetime');
        $entry['created_user']  = $result['created_user'];
        $entry['revised_date']  = $result['revised_date'];
        xmlrpc_set_type($entry['revised_date'], 'datetime');
        $entry['revised_user']  = $result['revised_user'];

        $response = $entry;
        //XMLRPC_fatal_error(1234, "menu_viewPatternId() error: Unable to read entry");
    } else {
        // there was an error, so respond with an error message
        XMLRPC_fatal_error(1234, "menu_viewPatternId() error: Unable to read entry");
    } // if
    return $response;
} // menu_viewPatternId

// ****************************************************************************

return $xmlrpc_methods;

?>