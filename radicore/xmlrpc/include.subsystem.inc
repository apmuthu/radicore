<?php

// modify INCLUDE_PATH
$include_path = ini_get('include_path');
$include_path .= PATH_SEPARATOR .'../party';
$include_path .= PATH_SEPARATOR .'../shipment';
$include_path .= PATH_SEPARATOR .'../order';
$include_path .= PATH_SEPARATOR .'../product';
$include_path .= PATH_SEPARATOR .'../request';
$include_path .= PATH_SEPARATOR .'../invoice';
$include_path .= PATH_SEPARATOR .'../inventory';
$include_path .= PATH_SEPARATOR .'../wrd';
ini_set('include_path', $include_path);
unset($include_path);

?>