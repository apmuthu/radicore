<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'x_person.class.inc';
class x_person_s04 extends x_person
{
    // ****************************************************************************
    // this class is for use by script: person_output(pdf)3.php
    // it demonstrates the creation of a complex invoice layout via PDF
    // ****************************************************************************

    var $total_price;       //

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!isset($this->fieldspec['invoice_date'])) {
            // provide specifications so that these fields can be formatted
        	$this->fieldspec['invoice_date']   = array('type' => 'date');
        	$this->fieldspec['ship_date']      = array('type' => 'date');
        	$this->fieldspec['sub_total']      = array('type' => 'numeric', 'precision' => 9, 'scale' => 2);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_output_multi ($name, $fieldarray)
    // get extra data to pass to PDF class.
    {
        $outarray = array();

        switch ($name) {
        	case 'multi1':
        	    $this->total_price = 0;
        	    $this->total_vat   = 0;

        	    $row['quantity']       = 2;
        	    $row['product_name']   = 'Stuff';
        	    $row['product_desc']   = 'Expensive Stuff, Grade I, with bells and whistles and lots of fancy bits';
        	    $row['product_price']  = '543.45';
        	    $row['extended_price'] = $row['quantity'] * $row['product_price'];
        	    $this->total_price     = $this->total_price + $row['extended_price'];
        	    $row['extended_price'] = number_format($row['extended_price'], 2);
        	    $row['vat_percent']    = '17.5';
        	    $row['picture']        = 'pictures/female1.jpg';
                $row['image_label']    = 'LABEL:';
                $row['image_01']       = 'pictures/female1.jpg';
                $row['image_02']       = 'pictures/male2.jpg';
        	    $outarray[] = $row;

        	    $row['quantity']       = 5;
        	    $row['product_name']   = 'Other Stuff';
        	    $row['product_desc']   = 'Less Expensive Stuff, Grade 2, without bells and whistles and only a few fancy bits';
        	    $row['product_price']  = '49.99';
        	    $row['extended_price'] = $row['quantity'] * $row['product_price'];
        	    $this->total_price     = $this->total_price + $row['extended_price'];
        	    $row['extended_price'] = number_format($row['extended_price'], 2);
        	    $row['vat_percent']    = '17.5';
        	    $row['picture']        = 'pictures/female2.jpg';
                $row['image_label']    = 'LABEL:';
                $row['image_01']       = '';
                $row['image_02']       = 'pictures/male2.jpg';
        	    $outarray[] = $row;

        	    $row['quantity']       = 25;
        	    $row['product_name']   = 'Widgets';
        	    $row['product_desc']   = 'Widgets, small, round and soft';
        	    $row['product_price']  = '24.99';
        	    $row['extended_price'] = $row['quantity'] * $row['product_price'];
        	    $this->total_price     = $this->total_price + $row['extended_price'];
        	    $row['extended_price'] = number_format($row['extended_price'], 2);
        	    $row['vat_percent']    = '17.5';
        	    $row['picture']        = 'pictures/female1.jpg';
                $row['image_label']    = 'LABEL:';
                $row['image_01']       = '';
                $row['image_02']       = '';
        	    $outarray[] = $row;

        	    $row['quantity']       = 25;
        	    $row['product_name']   = 'Gadgets';
        	    $row['product_desc']   = 'Gadgets, large, square and hard';
        	    $row['product_price']  = '13.99';
        	    $row['extended_price'] = $row['quantity'] * $row['product_price'];
        	    $this->total_price     = $this->total_price + $row['extended_price'];
        	    $row['extended_price'] = number_format($row['extended_price'], 2);
        	    $row['vat_percent']    = '17.5';
        	    $row['picture']        = 'pictures/female2.jpg';
                $row['image_label']    = '';
                $row['image_01']       = '';
                $row['image_02']       = '';
        	    $outarray[] = $row;

        	    if (empty($outarray)) {
        	    	// return a non-empty array to print an empty line
                    $outarray[] = array('dummy' => '');
        	    } // if
        		break;

        	case 'multi2':
        	    // invoice notes
    	        $extra['note_id'] = 'NOTE';
    	        $extra['note_text'] = 'This is a note which is attached to the invoice. It can contain whatever text you like, and can even span several lines.';
    	        $outarray[] = $extra;

        	    $extra['note_id'] = 'NOTE 2';
        	    $extra['note_text'] = "Here is another piece of text which uses a lot of words but says very little.";
        	    $outarray[] = $extra;

                //$outarray = array();

                break;

        	case 'multi3':
        	    $extra['vat_percent1'] = 17.5;
        	    $extra['vat_amount1']  = round($this->total_price * ($extra['vat_percent1'] / 100), 2);
        	    $vat_total = $extra['vat_amount1'];
        	    $extra['vat_amount1'] = number_format($extra['vat_amount1'], 2);

                $extra['vat_percent2'] = null;
                $extra['vat_amount2']  = null;

        	    $extra['sub_total'] = $this->total_price;
        	    $extra['vat_total'] = $vat_total;
        	    $extra['inv_total'] = number_format($this->total_price + $vat_total, 2);
        	    $outarray[] = $extra;

                // return a non-empty array to print an empty line
                //$outarray[] = array('dummy' => '');
        		break;

        	case 'multi4':
                // return a non-empty array to print an empty line
                //$outarray[] = array('dummy' => '');
                $outarray[] = array('barcode' => '0123456789');
        		break;

        	case 'multi5':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi6':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi7':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi8':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi9':
                // return a non-empty array to print an empty line
                //$outarray[] = array('dummy' => '');
                //$outarray = array();
                $outarray[] = array('multi9_1' => 'multi9_1', 'multi9_2' => 'multi9_2');
        		break;

        	case 'multi10':
                // return a non-empty array to print an empty line
                //$outarray[] = array('dummy' => '');
                //$outarray = array();
                //$outarray[] = array('multi10_image' => 'images/radicore.jpg', 'multi10_text' => 'multi10');
                break;

            case 'multi11':
                // return a non-empty array to print an empty line
                //$outarray[] = array('dummy' => '');
                //$outarray = array();
                break;

            default:
        		break;
        } // switch

        if ($outarray) {
        	return $outarray;
        } else {
            return false;
        } // if

    } // _cm_output_multi

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        $fieldarray['company_name']    = 'Radicore Software Limited';
        $fieldarray['company_address'] = "Code Castle\nWebtown\nFrameworkshire\nEngland, AA1 1AA";

        $fieldarray['invoice_date'] = '2006-08-26';
        $fieldarray['invoice_no']   = '06/1001';

        $fieldarray['invoice_to']   = "Invoice line 1 one two three four five six seven eight nine ten el\nInvoice line 2\nInvoice line 3\nInvoice line 4\nInvoice line 5\nInvoice line 6\nInvoice line 7\nInvoice line 8";
        $fieldarray['ship_to']      = "Ship line 1 one two three four five six seven eight nine ten eleve\nShip line 2\nShip line 3\nShip line 4\nShip line 5\nShip line 6\nShip line 7\nShip line 8";

        $fieldarray['payment_terms']     = '60 days';
        $fieldarray['purchase_order_id'] = 'A/1234';
        $fieldarray['ship_date']         = '2006-08-28';
        $fieldarray['carrier_id']        = 'ACME Freight';
        $fieldarray['cust_contact']      = 'Bill Gates';
        $fieldarray['barcode']           = '9876543210';

        $fieldarray['delivery_address']  = 'Delivery address:  27 Lesby Avenue, Smalltown, Smallshire, SS1 1SS';

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // ensure that a single primary key is passed
        $this->checkPrimaryKey = true;
        $this->rows_per_page   = 1;

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
