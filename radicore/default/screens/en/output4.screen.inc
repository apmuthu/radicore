<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = '#tablename#';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][0][] = array('label' => 'Restore Selection');
$structure['main']['fields'][0][] = array('field' => 'rdc_restore_selection', 'colspan' => 3);

$structure['main']['fields'][1][] = array('label' => 'Description');
$structure['main']['fields'][1][] = array('field' => 'rdc_selection_desc', 'size' => 50);
$structure['main']['fields'][1][] = array('field' => 'rdc_save_selection', 'colspan' => 2);

$structure['main']['fields'][2][] = array('label' => 'blank', 'class' => 'divider');
$structure['main']['fields'][2][] = array('field' => 'blank', 'colspan' => 3, 'class' => 'divider');

// the remaining contents of this screen are constructed at run time

?>