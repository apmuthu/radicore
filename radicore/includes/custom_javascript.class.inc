<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// *****************************************************************************
// allows custom javascript to be defined globally for any number of fields,
// or globally for every form.
// *****************************************************************************

class custom_javascript
{
    var $form_level_js;

    // ****************************************************************************
    function __construct ()
    {
        // nothing here

        return;

    } // __construct

    // ****************************************************************************
    function field_level_js ($fieldname, $fieldvalue, $spec)
    // see if any javascript needs to be inserted for this field
    {
        $this->form_level_js = array();
        $javascript          = array();

        if (isset($GLOBALS['mode'])) {
            $mode = trim($GLOBALS['mode']);
        } else {
            $mode = '';
        }  // if

//        if ($mode == 'insert' OR $mode == 'search' OR $mode == 'update') {
//            if (!isset($spec['javascript'])) {
//                if ($spec['type'] == 'datetime' OR $spec['type'] == 'date') {
//                    // date and datetime fields only
//                    if (!isset($spec['noedit'])) {
//                        // editable fields only
//                        if (!isset($spec['noedit'])) {
//                            // no other controls implemented
//                            if ($mode != 'search' OR !isset($spec['nosearch'])) {
//                                // add calendar control javascript if insert or update mode,
//                                // or search mode without nosearch spec
//                                $javascript = array('onfocus' => "showCalendarControl(this);");
//                                $this->form_level_js['head'][]['file'] = '../javascript/CalendarControl/CalendarControl.js';
//                            } // if
//                        } // if
//                    } // if
//                } // if
//            } // if
//        } // if

        return $javascript;

    } // field_level_js

    // ****************************************************************************
    function form_level_js ($form_id)
    // see if any javascript needs to be inserted for this form
    {
        static $javascript = array();

        if (!empty($javascript)) {
            return false;  // already done, so don't do it again
        } // if

        if (isset($GLOBALS['mode'])) {
            $mode = trim($GLOBALS['mode']);
        } else {
            $mode = '';
        }  // if

//        if (!empty($mode) AND $mode != 'logon') {
//            // custom code goes here
//        } // if

        $javascript['head'][]['file'] = '../javascript/jquery-3.1.1.min.js';
        $javascript['head'][]['file'] = '../javascript/jquery.cookie.min.js';

        // the following code contribution was supplied by Kong
        $javascript['foot'][]['code'] =  "
            (function($) {
                $('form :submit').click(function (event) {
                    $(this).
                        prop('disabled', true).
                        closest('form').
                        append($('<input/>', {
                            id: 'disabled_submit_button_info',
                            type: 'hidden',
                            name: this.name,
                            value: this.value
                        })).
                        submit();
                    $(this).addClass('loadingspinner');
                    clean_up_screen_upon_cookie();
                    event.preventDefault();
                });

                function clean_up_screen_upon_cookie() {
                    var clean_up_screen_cookie =
                        'clean_up_screen_' + $('input:hidden[name=\"session_name\"]').val();
                    var interval_id = setInterval (function() {
                        if ($.cookie(clean_up_screen_cookie) !== undefined) {
                            clearInterval(interval_id);
                            $.removeCookie(clean_up_screen_cookie);
                            $('#disabled_submit_button_info').remove();
                            $(':submit').prop('disabled', false);
                            $(':submit').removeClass('loadingspinner');
                        };
                    }, 500);
                };

            })(jQuery);
        ";

        return $javascript;

    } // form_level_js

// ****************************************************************************
} // class: custom_javascript
// ****************************************************************************
?>
