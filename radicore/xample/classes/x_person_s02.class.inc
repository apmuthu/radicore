<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s02 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person_upd(js).php
    // it demonstrates the inclusion of javascript capabilties
    // ****************************************************************************

    // ****************************************************************************
    function _cm_setJavaScript ($javascript)
    // insert any javascript to be included in the <HEAD> or <BODY> elements.
    {
        global $mode;

        if ($mode == 'insert' or $mode == 'update') {
            $javascript['head'][]['file'] = 'javascript/usableforms.js';
            $javascript['head'][]['code'] = 'document.write();';
            $javascript['head'][]['code'] = 'document.write(getCalendarStyles());';
            $javascript['head'][]['file'] = 'javascript/CalendarPopup.js';
            $javascript['head'][]['code'] = 'document.write(getCalendarStyles());';
            $javascript['head'][]['code'] = 'var cal1 = new CalendarPopup(); cal1.showYearNavigation();';
        } // if

        // specify javascript events on certain fields
        if ($mode == 'insert' or $mode == 'update') {
            $this->fieldspec['first_name']['javascript'] = array('onclick' => 'doStuff(1);',
                                                                 'onfocus' => 'doStuff(2);',
                                                                 'onblur' => 'doStuff(3);',
                                                                 'onselect' => 'doStuff(4);',
                                                                 'onchange' => 'doStuff(5)');
    	    $this->fieldspec['star_sign']['javascript']  = array('onchange' => "alert('change');");

            $this->fieldspec['start_date']['javascript'] = array('href_onclick' => "cal1.select(document.forms[0].start_date,'anchor1','dd-NNN-yyyy'); return false;",
    	                                                         'href_name' => 'anchor1',
    	                                                         'href_id' => 'anchor1',
    	                                                         //'href_image' => 'images/calendar.gif',
    	                                                         'href_label' => 'select');

        	$this->fieldspec['end_date']['javascript']   = array('href_onclick' => "cal1.select(document.forms[0].end_date,'anchor2','dd-NNN-yyyy'); return false;",
    	                                                         'href_name' => 'anchor2',
    	                                                         'href_id' => 'anchor2',
    	                                                         'javascript' => 'var cal1 = new CalendarPopup(); cal1.showYearNavigation();',
    	                                                         //'href_label' => 'select',
    	                                                         'href_image' => 'images/calendar.gif');
        } // if

        // specify scripting events on <body> tag
        $javascript['body']['onload'] = 'prepareForm()';
        //$javascript['body']['onunload'] = 'finish()';

        // specify scripting events on <tbody> tag
        $javascript['tbody'] = array('id' => 'waitingRoom', 'style' => 'display:none');

        return $javascript;

    } // _cm_setJavaScript

// ****************************************************************************
} // end class
// ****************************************************************************

?>
