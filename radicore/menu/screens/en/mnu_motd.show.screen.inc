<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_motd';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][] = array('motd_subject' => 'Subject');

$structure['main']['fields'][] = array('motd_message' => 'Message');

$structure['main']['fields'][] = array('start_date' => 'Date');

?>