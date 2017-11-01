<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = '#tablename#';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][] = array('fieldname' => 'Label');
$structure['main']['fields'][] = array('fieldname' => 'Label');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

// the LONG format defines more than two cells in the row, as in:
$structure['main']['fields'][1][] = array('label' => 'Survey ID');      // cell 1=label
$structure['main']['fields'][1][] = array('field' => 'survey_id');      // cell 2=field
$structure['main']['fields'][1][] = array('label' => 'Name');           // cell 3=label
$structure['main']['fields'][1][] = array('field' => 'survey_name');    // cell 4=field

// it is possible to have a field without a label, but not a label without a field

// all other rows in the table should span the same number of columns (cells), so ...
// any cell can be expanded beyond its default of 1 by adding the COLSPAN keyword
$structure['main']['fields'][] = array('fieldname' => 'Label', 'colspan' => 3);

?>