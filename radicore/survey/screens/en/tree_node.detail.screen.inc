<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'tree_node';

$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '5%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '60%');

$structure['main']['fields'][1] = array('node_id' => 'Id', 'colspan' => 3);

$structure['main']['fields'][2][] = array('label' => 'Node Depth');
$structure['main']['fields'][2][] = array('field' => 'node_depth');
$structure['main']['fields'][2][] = array('label' => 'Parent Node');
$structure['main']['fields'][2][] = array('field' => 'node_desc_snr');

$structure['main']['fields'][] = array('node_type' => 'Node Type', 'colspan' => 3);
$structure['main']['fields'][] = array('node_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][] = array('org_type_id' => 'Organisation Type', 'colspan' => 3);
$structure['main']['fields'][] = array('location_type_id' => 'Location Type', 'colspan' => 3);
$structure['main']['fields'][] = array('asset_type_id' => 'Asset Type', 'colspan' => 3);
$structure['main']['fields'][] = array('address_line1' => 'Address 1', 'colspan' => 3);
$structure['main']['fields'][] = array('address_line2' => 'Address 2', 'colspan' => 3);
$structure['main']['fields'][] = array('town' => 'Town', 'colspan' => 3);
$structure['main']['fields'][] = array('county' => 'County', 'colspan' => 3);
$structure['main']['fields'][] = array('postcode' => 'Postcode', 'colspan' => 3);
$structure['main']['fields'][] = array('country' => 'Country', 'colspan' => 3);
$structure['main']['fields'][] = array('telephone' => 'Telephone', 'colspan' => 3);
$structure['main']['fields'][] = array('fax' => 'Fax', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>