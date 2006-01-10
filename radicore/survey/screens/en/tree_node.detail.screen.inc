<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'tree_node';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('node_id' => 'Id');
$structure['main']['fields'][] = array('node_depth' => 'Node Depth');
$structure['main']['fields'][] = array('node_desc_snr' => 'Parent Node');
$structure['main']['fields'][] = array('node_type' => 'Node Type');
$structure['main']['fields'][] = array('node_desc' => 'Description');
$structure['main']['fields'][] = array('org_type_id' => 'Organisation Type');
$structure['main']['fields'][] = array('location_type_id' => 'Location Type');
$structure['main']['fields'][] = array('asset_type_id' => 'Asset Type');
$structure['main']['fields'][] = array('address_line1' => 'Address 1');
$structure['main']['fields'][] = array('address_line2' => 'Address 2');
$structure['main']['fields'][] = array('town' => 'Town');
$structure['main']['fields'][] = array('county' => 'County');
$structure['main']['fields'][] = array('postcode' => 'Postcode');
$structure['main']['fields'][] = array('country' => 'Country');
$structure['main']['fields'][] = array('telephone' => 'Telephone');
$structure['main']['fields'][] = array('fax' => 'Fax');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>