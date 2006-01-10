<?php

// Each entry must be an array of values

$array['feature_interaction']   = array('D' => 'Dependent',
                                        'I' => 'Incompatible');

$array['feature_type']          = array('S' => 'Standard',
                                        'O' => 'Optional',
                                        'R' => 'Required',
                                        'X' => 'Selectable');

$array['price_frequency']       = array('1' => 'One Time charge',
                                        'R' => 'Recurring charge',
                                        'U' => 'Utilisation charge');
        
$array['price_type']            = array('B' => 'Base Price',
                                        'D' => 'Discount',
                                        'S' => 'Surcharge',
                                        'M' => 'MRP');

$array['product_subtype']       = array('G' => 'Good',
                                        'S' => 'Service');


return $array;

?>