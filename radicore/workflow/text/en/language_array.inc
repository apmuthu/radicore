<?php

// Each entry must be an array of values

$array['arc_type']              = array(''           => ' ',
                                        'SEQ'        => 'Sequential',
                                        'OR-SPLIT-E' => 'OR-split (Explicit)',
                                        'OR-SPLIT-I' => 'OR-split (Implicit)',
                                        'OR-JOIN'    => 'OR-join',
                                        'AND-SPLIT'  => 'AND-split',
                                        'AND-JOIN'   => 'AND-join');
        
$array['case_status']           = array('OP' => 'Open',
                                        'CL' => 'Closed',
                                        'SU' => 'Suspended',
                                        'CA' => 'Cancelled');
        
$array['direction']             = array(''    => ' ',
                                        'IN'  => 'In (P -> T)',
                                        'OUT' => 'Out (P <- T)');

$array['token_status']          = array('FREE' => 'Free',
                                        'LOCK' => 'Locked',
                                        'CONS' => 'Consumed',
                                        'CANC' => 'Cancelled');

$array['transition_trigger']    = array(''     => ' ',
                                        'USER' => 'User (manual)',
                                        'AUTO' => 'Automatic',
                                        'MSG'  => 'Message',
                                        'TIME' => 'Time');

$array['workitem_status']       = array('EN' => 'Enabled',
                                        'IP' => 'In Progress',
                                        'CA' => 'Cancelled',
                                        'FI' => 'Finished');


return $array;

?>