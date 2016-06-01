<?php

// Each entry must be an array of values

$array['align_hv']              = array('H' => 'HORIZONTAL',
                                        'V' => 'VERTICAL');

$array['align_lr']              = array('L' => 'LEFT',
                                        'R' => 'RIGHT');

$array['audit_logging']         = array('N' => 'No',
                                        'Y' => 'LOGGING ENABLED');

$array['auto_insert']           = array('N' => 'No',
                                        'Y' => 'AUTO-INSERT');

$array['auto_update']           = array('N' => 'No',
                                        'Y' => 'AUTO-UPDATE');

$array['col_auto_increment']    = array('N' => 'No',
                                        'Y' => 'AUTO INCREMENT');

$array['col_key']               = array('PRI' => 'PRIMARY',
                                        'UNI' => 'UNIQUE',
                                        'MUL' => 'NON-UNIQUE');

$array['col_null']              = array('N' => 'NOT NULL',
                                        'Y' => 'NULL');

$array['col_unsigned']          = array('N' => 'No',
                                        'Y' => 'UNSIGNED');

$array['col_zerofill_bwz']      = array('ZF'  => 'ZEROFILL',
                                        'BWZ' => 'BLANK WHEN ZERO',
                                        'STZ' => 'STRIP TRAILING ZERO');

$array['control']               = array('dropdown'   => 'DROPDOWN LIST',
                                        'multidrop'  => 'MULTI-DROPDOWN',
                                        'radio'      => 'RADIO GROUP',
                                        'checkbox'   => 'CHECKBOX',
                                        'm_checkbox' => 'MULTI-CHECKBOX',
                                        'multiline'  => 'MULTI-LINE TEXT BOX',
                                        'popup'      => 'POPUP',
                                        'filepicker' => 'FILE PICKER',
                                        'hyperlink'  => 'HYPERLINK',
                                        'imagehyper' => 'IMAGE HYPERLINK',
                                        'image'      => 'IMAGE');

$array['is_required']           = array('N' => 'No',
                                        'Y' => 'REQUIRED');

$array['is_password']           = array('N' => 'No',
                                        'Y' => 'PASSWORD');

$array['noedit_nodisplay']      = array('NED' => 'NOEDIT',
                                        'NDI' => 'NODISPLAY');

$array['no_audit']              = array('NAL' => 'NOAUDIT');

$array['no_search']             = array('NSR' => 'NOSEARCH');

$array['rel_type']              = array('RES' => 'RESTRICTED',
                                        'DEL' => 'CASCADE (framework)',
                                        'NUL' => 'NULLIFY (framework)',
                                        'DEX' => 'CASCADE (FK constraint)',
                                        'NUX' => 'NULLIFY (FK constraint)',
                                        'IGN' => 'IGNORE');

$array['col_subtype']           = array('filename' => 'FILE NAME',
                                        'email'    => 'E-MAIL',
                                        'image'    => 'IMAGE',
                                        'video'    => 'VIDEO');

$array['upper_lowercase']       = array('UPPER' => 'UPPERCASE',
                                        'LOWER' => 'LOWERCASE');

$array['infinityisnull']        = array('N' => 'No',
                                        'Y' => 'INFINITY IS NULL');


return $array;

?>