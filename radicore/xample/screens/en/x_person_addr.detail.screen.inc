<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_person_addr';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][] = array('person_id' => 'Person Id');
$structure['main']['fields'][] = array('address_no' => 'Address No');
$structure['main']['fields'][] = array('telephone_no' => 'Telephone No');
$structure['main']['fields'][] = array('fax_no' => 'Fax No');
$structure['main']['fields'][] = array('addr_line_1' => 'Addr Line 1');
$structure['main']['fields'][] = array('addr_line_2' => 'Addr Line 2');
$structure['main']['fields'][] = array('addr_line_3' => 'Addr Line 3');
$structure['main']['fields'][] = array('town' => 'Town');
$structure['main']['fields'][] = array('county' => 'County');
$structure['main']['fields'][] = array('postcode' => 'Postcode');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created User');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised User');

// the LONG format defines more than two cells in the row, as in:

// it is possible to have a field without a label, but not a label without a field

// all other rows in the table should span the same number of columns (cells), so ...
// any cell can be expanded beyond its default of 1 by adding the COLSPAN keyword

?>