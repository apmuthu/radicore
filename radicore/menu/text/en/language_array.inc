<?php

// Each entry must be an array of values

$array['pswd_change'] = array('AR' => 'At Random',
                              'AL' => "After 'n' logons",
                              'AD' => "After 'n' days");

//$array['pswd_change'] = array('AR' => array('value' => 'At Random',
//                                            'onkeypress' => "alert('AR');"),
//                              'AL' => array('value' => "After 'n' logons",
//                                            'onkeypress' => "alert('AL');"),
//                              'AD' => array('value' => "After 'n' days",
//                                            'onkeypress' => "alert('AD');"),);

$array['access_type'] = array('FULL' => 'Full',
                              'NED'  => 'NOEDIT',
                              'NDI'  => 'NODISPLAY');

$array['repeat_unit'] = array('D' => 'Days',
                              'W' => 'Weeks',
                              'M' => 'Months');

$array['task_type'] = array('PROC' => 'Proc',
                            'MENU' => 'Menu');

return $array;

?>