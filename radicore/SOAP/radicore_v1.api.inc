<?php
// radicore_v1.api.inc

// contains information from which the WSDL can be constructed,
// and functions which exeute each of the SOAP operations.

$GLOBALS['mode'] = "SOAP";

require('include.library.inc');

// Define an array to name the soap methods and their corresponding PHP functions
$soap_methods = array();

// define the method names and their input/output arguments
$soap_methods['menu_getPatternList'] = array('input' => array('params' => 'tns:menu_getPatternListRequest'),
                                             'output' => array('return' => 'tns:ArrayOfPatternRowShort'),
                                             'documentation' => 'Request a list of available Patterns.');

$soap_methods['menu_viewPatternId'] = array('input' => array('params' => 'tns:menu_viewPatternIdRequest'),
                                            'output' => array('return' => 'tns:PatternRowFull'),
                                            'documentation' => 'Request the details of a selected Pattern.');

$soap_methods['menu_getAnswer'] = array('input' => array('request' => 'xsd:string'),
                                        'output' => array('return' => 'xsd:string'),
                                        'documentation' => 'Request an answer.');

// define any simple data types
//$soap_methods['simpletype']['menu_getAnswerRequest'] = array('type' => 'xsd:string');

// this output will consist of nothing but a single string
//$soap_methods['simpletype']['menu_getAnswerResponse'] = array('type' => 'xsd:string');

// define any complex data types
$soap_methods['complextype'][] = array('name' => 'rdc_error',
                                       'elements' => array('fieldname'  => array('name' => 'fieldname', 'type' => 'xsd:string'),
                                                           'fieldvalue' => array('name' => 'fieldvalue', 'type' => 'xsd:string')
                                                          ));
// this output will have a single string named 'response' an an optional array of error messages
//$soap_methods['complextype'][] = array('name' => 'menu_getAnswerResponse', 'compositor' => 'sequence',
//                                       'elements' => array('response'   => array('name' => 'text',       'type' => 'xsd:string'),
//                                                           'rdc_errors' => array('name' => 'rdc_errors', 'type' => 'rdc_error', 'minOccurs' => 0)
//                                                          ));

$soap_methods['complextype'][] = array('name' => 'menu_getPatternListRequest',
                                       'elements' => array('limit'   => array('name' => 'limit', 'type' => 'xsd:int'),
                                                           'page_no' => array('name' => 'page_no', 'type' => 'xsd:int'),
                                                           'order'   => array('name' => 'order', 'type' => 'xsd:string')
                                                          ));
$soap_methods['complextype'][] = array('name' => 'menu_viewPatternIdRequest',
                                       'elements' => array('pattern_id' => array('name' => 'pattern_id', 'type' => 'xsd:string')
                                                          ));

$soap_methods['complextype'][] = array('name' => 'ArrayOfPatternRowShort');
$soap_methods['complextype'][] = array('name' => 'PatternRowShort',
                                       'elements' => array('pattern_id'        => array('name' => 'pattern_id',        'type' => 'xsd:string'),
                                                           'pattern_desc'      => array('name' => 'pattern_desc',      'type' => 'xsd:string'),
                                                           'pattern_long_desc' => array('name' => 'pattern_long_desc', 'type' => 'xsd:string'),
                                                           'context_preselect' => array('name' => 'context_preselect', 'type' => 'xsd:boolean'),
                                                           'keep_data'         => array('name' => 'keep_data',         'type' => 'xsd:boolean'),
                                                           'visible_screen'    => array('name' => 'visible_screen',    'type' => 'xsd:boolean')
                                                          ));
$soap_methods['complextype'][] = array('name' => 'PatternRowFull',
                                       'elements' => array('pattern_id'        => array('name' => 'pattern_id',        'type' => 'xsd:string'),
                                                           'pattern_desc'      => array('name' => 'pattern_desc',      'type' => 'xsd:string'),
                                                           'pattern_long_desc' => array('name' => 'pattern_long_desc', 'type' => 'xsd:string'),
                                                           'context_preselect' => array('name' => 'context_preselect', 'type' => 'xsd:boolean'),
                                                           'keep_data'         => array('name' => 'keep_data',         'type' => 'xsd:boolean'),
                                                           'visible_screen'    => array('name' => 'visible_screen',    'type' => 'xsd:boolean'),
                                                           'created_date'      => array('name' => 'created_date',      'type' => 'xsd:datetime'),
                                                           'created_user'      => array('name' => 'created_user',      'type' => 'xsd:string'),
                                                           'revised_date'      => array('name' => 'revised_date',      'type' => 'xsd:datetime'),
                                                           'revised_user'      => array('name' => 'revised_user',      'type' => 'xsd:string'),
                                                           'rdc_errors'        => array('name' => 'rdc_errors',        'type' => 'rdc_error', 'minOccurs' => 0)
                                                          ));

// ****************************************************************************
function menu_getAnswer ($params=null)
// return a single value as the result
{
    $response = 'this is the answer';
    //$response['response'] = 'this is the answer';

//    SOAP_error(5331, "this is a fatal error message");

    $errors = array();
//    $errors['field1'] = 'this field is invalid';
//    $errors['field2'] = 'this field is also invalid';
//
//    if (!empty($errors)) {
//        $errorLine = $errors;
//        $response['errorLine'] = $errors;
//    } // if

    return $response;

} // menu_getAnswer

// ****************************************************************************
function menu_getPatternList ( $params=null )
// list entries from the MNU_PATTERN table.
{
    if (is_array($params)) {
        $page_size =& $params['limit'];
        $order     =& $params['order'];
        $page_no   =& $params['page_no'];
    } elseif (is_object($params)) {
        $page_size =& $params->limit;
        $order     =& $params->order;
        $page_no   =& $params->page_no;
    } // if

    // instantiate object to access the database
    $dbobject = RDCsingleton::getInstance('mnu_pattern');

    if (!empty($order)) {
    	$dbobject->setOrderBy($order, 'ASC');
    } // if

    if ($page_size < 1 OR $page_size > 20) {
        $page_size = 20;
    } // if
    $dbobject->setRowsPerPage($page_size);

    if ($page_no < 1) {
        $page_no = 1;
    } // if
    $dbobject->setPageNo($page_no);

    // issue the query
    $resource = $dbobject->getData_serial();
    if ( $resource ) {
        $entries = array();
        while ( $result = $dbobject->fetchRow ( $resource ) ) {

            // Extract the variables we want to send in our response
            $entry['pattern_id']         = $result['pattern_id'];
            $entry['pattern_desc']       = $result['pattern_desc'];
            $entry['pattern_long_desc']  = $result['pattern_long_desc'];
            $entry['pattern_desc']       = $result['pattern_desc'];
            $entry['visible_screen']     = $result['visible_screen'];
            $entry['context_preselect']  = $result['context_preselect'];
            $entry['keep_data']          = $result['keep_data'];
            //xmlrpc_set_type($news_item['date'], 'datetime');

            // Add to the output array
            $entries[] = $entry;
        } // while

        $response = $entries;
    } else {
        // there was an error, so respond with an error message
        SOAP_error(1234, "menu_getPatternList() error: Unable to read entries");
    } // if

    return $response;

} // menu_getPatternList

// ****************************************************************************
function menu_viewPatternId ( $params=null )
// view a full news item corresponding to the news.viewNewsItem method
{
    if (is_array($params)) {
        $pattern_id =& $params['pattern_id'];
    } elseif (is_object($params)) {
        $pattern_id =& $params->pattern_id;
    } // if

    // instantiate object to access the database
    $dbobject = RDCsingleton::getInstance('mnu_pattern');

    // issue the query
    $resource = $dbobject->getData_serial("pattern_id='$pattern_id'");

    if ( $result = $dbobject->fetchRow ( $resource ) ) {

        // Extract the variables we want to send in our response
        $entry['pattern_id']    = $result['pattern_id'];
        $entry['pattern_desc']  = $result['pattern_desc'];
        $entry['pattern_long_desc']  = $result['pattern_long_desc'];
        $entry['visible_screen']  = $result['visible_screen'];
        //$entry['visible_screen']  = array("_" => $result['visible_screen'], "foo" => "bar");
        $entry['context_preselect']  = $result['context_preselect'];
        $entry['keep_data']  = $result['keep_data'];
        $entry['created_date']  = $result['created_date'];
        //xmlrpc_set_type($entry['created_date'], 'datetime');
        $entry['created_user']  = $result['created_user'];
        $entry['revised_date']  = $result['revised_date'];
        //xmlrpc_set_type($entry['revised_date'], 'datetime');
        $entry['revised_user']  = $result['revised_user'];

        $response = $entry;

        $errors = array();
        $errors['field1'] = 'this field is invalid';
        $errors['field2'] = 'this field is also invalid';

        if (!empty($errors)) {
            $response['rdc_errors'] = $errors;
        } // if

        //XMLRPC_fatal_error(1234, "menu_viewPatternId() error: Unable to read entry");
    } else {
        // there was an error, so respond with an error message
        SOAP_error(1234, "menu_viewPatternId() error: Unable to read entry");
    } // if

    return $response;

} // menu_viewPatternId

// ****************************************************************************

return $soap_methods;

?>
