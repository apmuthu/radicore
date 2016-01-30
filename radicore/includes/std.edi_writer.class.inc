<?php
// *****************************************************************************
// This is used to construct a message in EDIFACT format.
// This version is primarily used to create INVOIC documents.
//
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class edi_writer {

    var $errors;                // error messages

    var $header = array();      // Interchange Header

    var $message = array();     // one message for each Purchase Order

    // ****************************************************************************
    function __construct()
    {

    } // __construct

    // ****************************************************************************
    function setHeader ($array)
    // load values into UNB segment - Interchange Header
    {
        $this->header['identifier']          = 'UNOC';
        $this->header['version']             = '2';
        $this->header['sender_id']           = null;
        $this->header['sender_qualifier']    = '14';
        $this->header['recipient_id']        = null;
        $this->header['recipient_qualifier'] = '14';
        $this->header['date']                = null;
        $this->header['time']                = null;
        $this->header['control_ref']         = null;
        $this->header['application_ref']     = null;
        $this->header['aggreement_id']       = null;
        $this->header['test_indicator']      = null;

        if (!empty($array['identifier']))               $this->header['identifier']          = $array['identifier'];
        if (!empty($array['version']))                  $this->header['version']             = $array['version'];
        if (!empty($array['sender_id']))                $this->header['sender_id']           = $array['sender_id'];
        if (!empty($array['sender_qualifier']))         $this->header['sender_qualifier']    = $array['sender_qualifier'];
        if (!empty($array['recipient_id']))             $this->header['recipient_id']        = $array['recipient_id'];
        if (!empty($array['recipient_qualifier']))      $this->header['recipient_qualifier'] = $array['recipient_qualifier'];

        if (!empty($array['date']))                     $this->header['date']                = $array['date'];
        if (!empty($array['time']))                     $this->header['time']                = $array['time'];
        if (!empty($array['datetime'])) {
            // this should be in the format 'CCYY-MM-DD HH:MM:SS'
            $datetime = preg_replace('/[^0-9]/u', '', $array['datetime']);       // strip non-numeric characters
            $this->header['date']                     = substr($datetime, 2, 6);   // reduced to YYMMDD
            $this->header['time']                     = substr($datetime, 8, 4);   // reduced to HHMM
        } // if

        if (!empty($array['control_ref']))     $this->header['control_ref']     = $array['control_ref'];
        if (!empty($array['application_ref'])) $this->header['application_ref'] = $array['application_ref'];
        if (!empty($array['aggreement_id']))   $this->header['aggreement_id']   = $array['aggreement_id'];
        if (!empty($array['test_indicator']))  $this->header['test_indicator']  = $array['test_indicator'];

        $this->message = array();

        return;

    } // setHeader

    // ****************************************************************************
    function setOrderResponse ($array)
    // load values for Order Response into the message array
    {
        $this->header['identifier']           = 'UNOA';
        $this->header['version']              = '2';

        $response['message_id']               = 'ORDRSP';
        $response['message_version']          = 'D';
        $response['message_release']          = '96A';
        $response['controlling_agency']       = 'UN';
        $response['assigned_code']            = 'EAN005';
        $response['message_code']             = '231';
        $response['function_code']            = '29';  // accepted without amendment

        $response['po_number']                = null;  // purchase order number
        $response['document_id']              = null;  // sales order number
        $response['document_date']            = date('Ymd');
        $response['currency_code']            = null;

        if (!empty($array['po_number']))       $response['po_number']       = $array['po_number'];
        if (!empty($array['vendor_order_no'])) $response['document_id']     = $array['vendor_order_no'];
        if (!empty($array['order_date']))      $response['document_date']   = preg_replace('/[^0-9]/u', '', $array['order_date']);
        if (!empty($array['currency_code']))   $response['currency_code']   = $array['currency_code'];

        //if (!empty($array['xxx']))   $response['xxx']   = $array['xxx'];

        $response['line_items'] = array();

        $this->message[] = $response;

        return;

    } // setOrderResponse

    // ****************************************************************************
    function setDespatchAdvice ($array)
    // load values for Despatch Advice into the message array
    {
        $this->header['identifier']         = 'UNOC';
        $this->header['version']            = '3';

        $advice['message_id']               = 'DESADV';
        $advice['message_version']          = 'D';
        $advice['message_release']          = '96A';
        $advice['controlling_agency']       = 'UN';
        $advice['assigned_code']            = 'EAN005';
        $advice['message_code']             = '351';
        $advice['function_code']            = '9';  // original

        $advice['document_id']              = null;  // manifest number
        $advice['document_date']            = date('Ymd');
        $advice['arrival_date']             = date('Ymd');
        $advice['bill_of_lading_ref']       = null;
        $advice['carrier_ref']              = null;
        $advice['ref_date']                 = date('Ymd');
        $advice['carrier_id']               = null;
        $advice['transport_mode']           = 'road';

        if (!empty($array['despatch_id']))        $advice['document_id']        = $array['despatch_id'];
        if (!empty($array['despatch_date']))      $advice['document_date']      = preg_replace('/[^0-9]/u', '', $array['despatch_date']);
        if (!empty($array['arrival_date']))       $advice['arrival_date']       = preg_replace('/[^0-9]/u', '', $array['arrival_date']);
        if (!empty($array['bill_of_lading_ref'])) $advice['bill_of_lading_ref'] = $array['bill_of_lading_ref'];
        if (!empty($array['carrier_ref']))        $advice['carrier_ref']        = $array['carrier_ref'];
        if (!empty($array['ref_date']))           $advice['ref_date']           = preg_replace('/[^0-9]/u', '', $array['ref_date']);
        if (!empty($array['carrier_id']))         $advice['carrier_id']         = $array['carrier_id'];
        if (!empty($array['transport_mode']))     $advice['transport_mode']     = $array['transport_mode'];

        $advice['transport_mode'] = strtolower($advice['transport_mode']);
        if (!preg_match('/(sea|rail|road|air)/', $advice['transport_mode'])) {
            $advice['transport_mode'] = 'road';
        } // if
        switch ($advice['transport_mode']) {
            case 'sea':
                $advice['transport_mode'] = 10;
                $advice['transport_type'] = 13;  // ocean vessel
                break;
            case 'rail':
                $advice['transport_mode'] = 20;
                $advice['transport_type'] = 25;  // rail express
                break;
            case 'air':
                $advice['transport_mode'] = 40;
                $advice['transport_type'] = 41;  // aircraft
                break;
            case 'road';
            default:
                $advice['transport_mode'] = 30;
                $advice['transport_type'] = 31;  // truck
        } // switch

        //if (!empty($array['xxx']))   $response['xxx']   = $array['xxx'];

        $advice['line_items'] = array();

        $this->message[] = $advice;

        return;

    } // setDespatchAdvice

    // ****************************************************************************
    function setInvoice ($array)
    // load values for Invoice into the message array
    {
        $this->header['identifier']          = 'UNOC';
        $this->header['version']             = '2';

        $invoice['message_id']               = 'INVOIC';
        $invoice['message_version']          = 'D';
        $invoice['message_release']          = '96A';
        $invoice['controlling_agency']       = 'UN';
        $invoice['assigned_code']            = 'EAN008';
        $invoice['message_code']             = '380';
        $invoice['function_code']            = '9';  // original

        $invoice['po_number']                = null;  // purchase order number
        $invoice['document_id']              = null;  // invoice number
        $invoice['document_date']            = date('Ymd');
        $invoice['delivery_date']            = null;
        $invoice['tax_date']                 = null;
        $invoice['currency_code']            = null;

        if (!empty($array['po_number']))       $invoice['po_number']       = $array['po_number'];
        if (!empty($array['invoice_no']))      $invoice['document_id']     = $array['invoice_no'];
        if (!empty($array['invoice_date']))    $invoice['document_date']   = preg_replace('/[^0-9]/u', '', $array['invoice_date']);
        if (!empty($array['delivery_date']))   $invoice['delivery_date']   = preg_replace('/[^0-9]/u', '', $array['delivery_date']);
        if (!empty($array['tax_date']))        $invoice['tax_date']        = preg_replace('/[^0-9]/u', '', $array['tax_date']);
        if (!empty($array['currency_code']))   $invoice['currency_code']   = $array['currency_code'];

        // payment terms
        if (!empty($array['terms_days'])) {
            $invoice['terms_days']    = (int)$array['terms_days'];
            $invoice['terms_eom']     = null;
            if (!empty($array['terms_from_end_of_month']) AND is_True($array['terms_from_end_of_month'])) {
                $invoice['terms_eom'] = '7';
            } // if
            if (!empty($array['terms_discount_percent'])) {
                $invoice['terms_discount_percent'] = (float)$array['terms_discount_percent'];
            } // if
        } // if

        //if (!empty($array['xxx']))   $invoice['xxx']   = $array['xxx'];

        $invoice['line_items'] = array();

        $this->message[] = $invoice;

        return;

    } // setInvoice

    // ****************************************************************************
    function addLineItem ($array)
    // add a line item to the current document (ORDRSP, DESADV or INVOICE)
    {
        $item['ean']        = null;
        $item['part_no']    = null;

        $ix = count($this->message)-1;
        if ($this->message[$ix]['message_id'] == 'ORDRSP') {
            $item['action']         = 5;
            $item['qty_despatched'] = 0;
            $item['qty_backorder']  = 0;
            $item['unit_price']     = 0;
            $item['tax_rate']       = 0;
            if (!empty($array['action']))            $item['action']            = (int)$array['action'];
            if (!empty($array['qty_despatched']))    $item['qty_despatched']    = (int)$array['qty_despatched'];
            if (!empty($array['qty_backorder']))     $item['qty_backorder']     = (int)$array['qty_backorder'];
            if (!empty($array['qty_cancelled']))     $item['qty_cancelled']     = (int)$array['qty_cancelled'];
            if (!empty($array['qty_rejected']))      $item['qty_rejected']      = (int)$array['qty_rejected'];
            if (!empty($array['qty_free']))          $item['qty_free']          = (int)$array['qty_free'];
            if (!empty($array['est_despatch_date'])) $item['est_despatch_date'] = preg_replace('/[^0-9]/u', '', $array['est_despatch_date']);
            if (!empty($array['est_delivery_date'])) $item['est_delivery_date'] = preg_replace('/[^0-9]/u', '', $array['est_delivery_date']);
            if (!empty($array['unit_price']))        $item['unit_price']        = number_format($array['unit_price'], 2, '.', '');
            if (!empty($array['tax_rate']))          $item['tax_rate']          = (float)$array['tax_rate'];
            if (!empty($array['seq_no']))            $item['seq_no']            = (int)$array['seq_no'];

        } elseif ($this->message[$ix]['message_id'] == 'DESADV') {
            $item['po_number'] = null;
            $item['quantity'] = 1;  // default
            $item['unit_price'] = 0;
            $item['tax_rate']   = 0;
            if (!empty($array['quantity']))   $item['quantity']   = (int)$array['quantity'];
            if (!empty($array['po_number']))  $item['po_number']  = $array['po_number'];

        } elseif ($this->message[$ix]['message_id'] == 'INVOIC') {
            $item['action']   = null;
            $item['quantity'] = 1;  // default
            $item['unit_price'] = 0;
            $item['tax_rate']   = 0;
            if (!empty($array['quantity']))   $item['quantity']   = (int)$array['quantity'];
            if (!empty($array['unit_price'])) $item['unit_price'] = number_format($array['unit_price'], 2, '.', '');
            if (!empty($array['tax_rate']))   $item['tax_rate']   = (float)$array['tax_rate'];

        } // if

        if (!empty($array['ean']))        $item['ean']        = $array['ean'];
        if (!empty($array['part_no']))    $item['part_no']    = $array['part_no'];

        $ix = count($this->message)-1;
        if ($this->message[$ix]['message_id'] == 'DESADV') {
            // add item to current package within current message
            $pkg = count($this->message[$ix]['packages'])-1;
            $this->message[$ix]['packages'][$pkg]['line_items'][] = $item;
        } else {
            // add item to current message
            $this->message[$ix]['line_items'][] = $item;
        } // if

        return;

    } // addLineItem

    // ****************************************************************************
    function addPackage ($array)
    // add a package to the current document (DESADV only).
    // This should be followed by one or more calls to addLineItem().
    {
        $package['length']   = null;
        $package['width']    = null;
        $package['height']   = null;
        $package['weight']   = null;
        $package['handling'] = null;
        $package['sscc_code'] = null;

        if (!empty($array['length']))        $package['length']        = $array['length'];
        if (!empty($array['width']))         $package['width']         = $array['width'];
        if (!empty($array['height']))        $package['height']        = $array['height'];
        if (!empty($array['weight']))        $package['weight']        = $array['weight'];
        if (!empty($array['handling']))      $package['handling']      = $array['handling'];
        if (!empty($array['sscc_code']))     $package['sscc_code']     = $array['sscc_code'];

        $ix = count($this->message)-1;
        $this->message[$ix]['packages'][] = $package;

        return;

    } // addPackage

    // ****************************************************************************
    function setBuyer ($array)
    // set name and address details for the BUYER
    {
        $party_data = $this->_setPartyData($array);

        $ix = count($this->message)-1;
        $this->message[$ix]['buyer_data'] = $party_data;

        return;

    } // setBuyer

    // ****************************************************************************
    function setSupplier ($array)
    // set name and address details for the SUPPLIER
    {
        $party_data = $this->_setPartyData($array);

        if (!empty($array['vat_reg_no']))     $party_data['vat_reg_no']     = $array['vat_reg_no'];
        if (!empty($array['company_reg_no'])) $party_data['company_reg_no'] = $array['company_reg_no'];

        $ix = count($this->message)-1;
        $this->message[$ix]['supplier_data'] = $party_data;

        return;

    } // setSupplier

    // ****************************************************************************
    function setDeliveryAddress ($array)
    // set name and address details for the BUYER
    {
        $party_data = $this->_setPartyData($array);

        $ix = count($this->message)-1;
        $this->message[$ix]['delivery_address'] = $party_data;

        return;

    } // setDeliveryAddress

    // ****************************************************************************
    function setInvoiceAddress ($array)
    // set name and address details for the BUYER
    {
        $party_data = $this->_setPartyData($array);

        if (!empty($array['vat_reg_no']))     $party_data['vat_reg_no']     = $array['vat_reg_no'];

        $ix = count($this->message)-1;
        $this->message[$ix]['invoice_address'] = $party_data;

        return;

    } // setInvoiceAddress

    // ****************************************************************************
    function _setPartyData ($array)
    // set name and address details for a party
    {
        if (!empty($array['party_id']))      $party_data['party_id']     = $array['party_id'];
        if (!empty($array['gln_id']))        $party_data['party_id']     = $array['gln_id'];
        if (!empty($array['party_name_1']))  $party_data['party_name1']  = $array['party_name_1'];
        if (!empty($array['party_name_2']))  $party_data['party_name2']  = $array['party_name_2'];
        if (!empty($array['party_name_3']))  $party_data['party_name3']  = $array['party_name_3'];
        if (!empty($array['party_name_4']))  $party_data['party_name4']  = $array['party_name_4'];
        if (!empty($array['party_name_5']))  $party_data['party_name5']  = $array['party_name_5'];
        if (!empty($array['street_1']))      $party_data['street1']      = $array['street_1'];
        if (!empty($array['street_2']))      $party_data['street2']      = $array['street_2'];
        if (!empty($array['street_3']))      $party_data['street3']      = $array['street_3'];
        if (!empty($array['city']))          $party_data['city']         = $array['city'];
        if (!empty($array['county']))        $party_data['county']       = $array['county'];
        if (!empty($array['postcode']))      $party_data['postcode']     = $array['postcode'];
        if (!empty($array['country_code']))  $party_data['country_code'] = $array['country_code'];

        return $party_data;

    } // _setPartyData

    // ****************************************************************************
    function toEDI ()
    // output data as an EDIFACT format string
    {
        $quote = chr(39);  // single quote
        $nl    = chr(10);  // new line

        // output Interchange Header
        $string  = 'UNB+';
        $string .= $this->header['identifier'].':'.$this->header['version'].'+';
        $string .= $this->header['sender_id'].':'.$this->header['sender_qualifier'].'+';
        $string .= $this->header['recipient_id'].':'.$this->header['recipient_qualifier'].'+';
        $string .= $this->header['date'].':'.$this->header['time'].'+';
        $string .= $this->header['control_ref'].'+';
        $string .= $this->header['application_ref'].'+';
        $string .= $this->header['aggreement_id'].'+';
        $string .= $this->header['test_indicator'].'+';
        $string .= '+EANCOM';
        $string .= $quote.$nl;

        $eol   = $quote.$nl;
        foreach ($this->message as $ix => $message) {
            $message['message_ref'] = $ix+1;
            switch ($message['message_id']) {
                case 'ORDRSP':
                    $string .= $this->_output_ORDRSP($message, $eol);
                    break;
                case 'DESADV':
                    $string .= $this->_output_DESADV($message, $eol);
                    break;
                case 'INVOIC':
                    $string .= $this->_output_INVOIC($message, $eol);
                    break;
                default:
                    // do nothing
            } // switch
        } // foreach

        if (strpos($eol, chr(10)) === false) {
            $string .= chr(10);  // newline not included, so insert it manually
        } // if

        // output Interchange Trailer
        $string .= 'UNZ+'.count($this->message).'+'.$this->header['control_ref'].$quote;

        return $string;

    } // toEDI

    // ****************************************************************************
    function _output_DESADV ($message, $eol)
    // outout details for message type 'DESADV' - Despatch Advice
    {
        $string = '';
        $segment_count = 0;

        // Message Header
        $string .= 'UNH+';
        $string .= $message['message_ref'].'+';
        $string .= $message['message_id'].':';
        $string .= $message['message_version'].':';
        $string .= $message['message_release'].':';
        $string .= $message['controlling_agency'].':';
        $string .= $message['assigned_code'].$eol;
        $segment_count++;

        // Begin Message
        $string .= 'BGM+';
        $string .= $message['message_code'].'+';
        $string .= $message['document_id'].'+';
        $string .= $message['function_code'].$eol;
        $segment_count++;

        // Dates
        $string .= 'DTM+11:'.$message['document_date'].':102'.$eol;  // despatch date
        $segment_count++;

        $string .= 'DTM+132:'.$message['arrival_date'].':102'.$eol;
        $segment_count++;

        if (strlen($message['document_date']) == 8) {
            $string .= 'DTM+137:'.$message['document_date'].':102'.$eol;  // date only
        } else {
            $string .= 'DTM+137:'.$message['document_date'].':203'.$eol;  // date+time
        } // if
        $segment_count++;

        if (!empty($message['bill_of_lading_ref'])) {
            $string .= 'RFF+BM:'.$message['bill_of_lading_ref'].$eol;
            $segment_count++;
        } // if

        if (!empty($message['carrier_ref'])) {
            $string .= 'RFF+CN:'.$message['carrier_ref'].$eol;
            $segment_count++;
        } // if

        if (!empty($message['ref_date'])) {
            $string .= 'DTM+171:'.$message['ref_date'].':102'.$eol;
            $segment_count++;
        } // if

        if (!empty($message['buyer_data'])) {
            $data = $message['buyer_data'];
            $string .= 'NAD+BY+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        if (!empty($message['carrier_id'])) {
            $string .= 'NAD+CA:'.$message['carrier_id'].$eol;
            $segment_count++;
        } // if

        if (!empty($message['delivery_address'])) {
            $data = $message['delivery_address'];
            $string .= 'NAD+DP+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        if (!empty($message['supplier_data'])) {
            $data = $message['supplier_data'];
            $string .= 'NAD+SU+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        $string .= 'TDT+20++'.$message['transport_mode'].'+'.$message['transport_type'].$eol;
        $segment_count++;

        $string .= 'CPS+1'.$eol;  // start Consignment Package Sequence
        $segment_count++;

        $package_count = count($message['packages']);

        $string .= 'PAC+2++202'.$eol;  // package type = UK pallet
        $segment_count++;
        $string .= 'PAC+2++PK'.$eol;  // package type = carton
        $segment_count++;

        $item_no   = 0;  // items are numbered sequentially within a message
        $total_qty = 0;  // sum of all item quantities

        foreach ($message['packages'] as $ix => $package) {
            $unit = $ix+2;
            $string .= 'CPS+'.$unit.'+1'.$eol;  // 1st unit is shown as '2'
            $segment_count++;
            $string .= 'PAC+1+:52+PK'.$eol;  // carton
            $segment_count++;

            if (!empty($package['length'])) {
                // package dimensions
                $string .= 'MEA+PD+LN+CMT:'.$package['length'].$eol;
                $segment_count++;
                $string .= 'MEA+PD+WD+CMT:'.$package['width'].$eol;
                $segment_count++;
                $string .= 'MEA+PD+HT+CMT:'.$package['height'].$eol;
                $segment_count++;
                $string .= 'MEA+PD+AAB+KGM:'.$package['weight'].$eol;
                $segment_count++;
            } // if

            if (!empty($package['handling'])) {
                $string .= 'HAN+'.$package['handling'].$eol;
                $segment_count++;
            } // if

            if (!empty($package['sscc_code'])) {
                $string .= 'PCI+33E'.$eol;
                $segment_count++;
                $string .= 'GIN+BJ+'.$package['sscc_code'].$eol;
                $segment_count++;
            } // if

            foreach ($package['line_items'] as $ix => $item) {
                $item_no++;
                $string .= 'LIN+'.$item_no.'++'.$item['ean'].':EN'.$eol;
                $segment_count++;
                $string .= 'QTY+12:'.$item['quantity'].$eol;
                $segment_count++;
                $string .= 'RFF+ON:'.$item['po_number'].$eol;
                $segment_count++;

                $total_qty = $total_qty + $item['quantity'];
            } // foreach
        } // foreach

        $string .= 'CNT+1:'.$total_qty.$eol;
        $segment_count++;

        // output Message Trailer
        $string .= 'UNT+';
        $string .= $segment_count.'+';
        $string .= $message['message_ref'].$eol;

        return $string;

    } // _output_DESADV

    // ****************************************************************************
    function _output_INVOIC ($message, $eol)
    // outout details for message type 'INVOIC' - Invoice
    {
        $string = '';
        $segment_count = 0;

        // Message Header
        $string .= 'UNH+';
        $string .= $message['message_ref'].'+';
        $string .= $message['message_id'].':';
        $string .= $message['message_version'].':';
        $string .= $message['message_release'].':';
        $string .= $message['controlling_agency'].':';
        $string .= $message['assigned_code'].$eol;
        $segment_count++;

        // Begin Message
        $string .= 'BGM+';
        $string .= $message['message_code'].'+';
        $string .= $message['document_id'].'+';
        $string .= $message['function_code'].$eol;
        $segment_count++;

        // Dates
        $message['document_date'] = substr($message['document_date'], 0, 8);  // strip any time from datetime
        $string .= 'DTM+137:'.$message['document_date'].':102'.$eol;
        $segment_count++;

        if (!empty($message['delivery_date'])) {
            $string .= 'DTM+35:'.$message['delivery_date'].':102'.$eol;
            $segment_count++;
        } // if

        if (!empty($message['tax_date'])) {
            $string .= 'DTM+131:'.$message['tax_date'].':102'.$eol;
            $segment_count++;
        } // if

        // Parties
        if (!empty($message['buyer_data'])) {
            $data = $message['buyer_data'];
            $string .= 'NAD+BY+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        if (!empty($message['supplier_data'])) {
            $data = $message['supplier_data'];
            $string .= 'NAD+SU+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
            if (!empty($data['vat_reg_no'])) {
                $string .= 'RFF+VA:'.$data['vat_reg_no'].$eol;
                $segment_count++;
            } // if
            if (!empty($data['company_reg_no'])) {
                $string .= 'RFF+FC:'.$data['company_reg_no'].$eol;
                $segment_count++;
            } // if
        } // if

        if (!empty($message['delivery_address'])) {
            $data = $message['delivery_address'];
            $string .= 'NAD+DP+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        if (!empty($message['invoice_address'])) {
            $data = $message['invoice_address'];
            $string .= 'NAD+IV+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
            if (!empty($data['vat_reg_no'])) {
                $string .= 'RFF+VA:'.$data['vat_reg_no'].$eol;
                $segment_count++;
            } // if
        } // if

        $string .= 'CUX+2:'.$message['currency_code'].':4'.$eol;
        $segment_count++;

        if (!empty($message['terms_days'])) {
            $string .= 'PAT+1++5:'.$message['terms_eom'].':D:'.$message['terms_days'].$eol;
            $segment_count++;
            if (!empty($message['terms_discount_percent'])) {
                $string .= 'PCD+7:'.$message['terms_discount_percent'].':13'.$eol;
                $segment_count++;
            } // if
        } // if

        $total_price = 0;
        $total_vat   = 0;
        $vat_array   = array();
        foreach ($message['line_items'] as $ix => $item) {
            $item_no = $ix+1;
            $extended_price = number_format( ($item['unit_price'] * $item['quantity']), 2, '.', '');

            $string .= 'LIN+'.$item_no.'++'.$item['ean'].':EN'.$eol;
            $segment_count++;
            $string .= 'QTY+47:'.$item['quantity'].$eol;
            $segment_count++;
            $string .= 'MOA+203:'.$extended_price.':'.$message['currency_code'].':4'.$eol;
            $segment_count++;
            $string .= 'PRI+AAA:'.$item['unit_price'].':CT:NTP'.$eol;
            $segment_count++;
            $string .= 'RFF+ON:'.$message['po_number'].$eol;
            $segment_count++;
            $string .= 'TAX+7+VAT+++:::'.$item['tax_rate'].$eol;
            $segment_count++;

            $total_price = $total_price + $extended_price;
            // accumulate the total goods amount for each tax rate
            if (!array_key_exists($item['tax_rate'], $vat_array)) {
                $vat_array[$item['tax_rate']] = 0;
            } // if
            $vat_array[$item['tax_rate']] = $vat_array[$item['tax_rate']] + $extended_price;

        } // foreach

        $string .= 'UNS+S'.$eol;  // section separator
        $segment_count++;
        $string .= 'CNT+2:'.count($message['line_items']).$eol;
        $segment_count++;

        // Invoice totals - goods amount, vat amount, gross amount
        ksort($vat_array);
        foreach ($vat_array as $rate => $goods_amount) {
            $tax_amount = $goods_amount * ($rate / 100);
            $tax_amount = floor($tax_amount*100)/100;  // round DOWN to 2 decimal places
            $total_vat  = $total_vat + $tax_amount;
        } // foreach
        $string .= 'MOA+77:'.number_format($total_price + $total_vat, 2, '.', '').':'.$message['currency_code'].':4'.$eol;  // section separator
        $segment_count++;

        foreach ($vat_array as $rate => $goods_amount) {
            $tax_amount = $goods_amount * ($rate / 100);
            $tax_amount = floor($tax_amount*100)/100;  // round DOWN to 2 decimal places
            $string .= 'TAX+7+VAT+++:::'.$rate.$eol;
            $segment_count++;
            $string .= 'MOA+124:'.number_format($tax_amount, 2, '.', '').':'.$message['currency_code'].':4'.$eol;
            $segment_count++;
            $string .= 'MOA+125:'.number_format($goods_amount, 2, '.', '').':'.$message['currency_code'].':4'.$eol;
            $segment_count++;
        } // foreach

        // output Message Trailer
        $string .= 'UNT+';
        $string .= $segment_count.'+';
        $string .= $message['message_ref'].$eol;

        return $string;

    } // _output_INVOIC

    // ****************************************************************************
    function _output_ORDRSP ($message, $eol)
    // outout details for message type 'ORDRSP' - Order Response
    {
        $string = '';
        $segment_count = 0;

        // Message Header
        $string .= 'UNH+';
        $string .= $message['message_ref'].'+';
        $string .= $message['message_id'].':';
        $string .= $message['message_version'].':';
        $string .= $message['message_release'].':';
        $string .= $message['controlling_agency'].':';
        $string .= $message['assigned_code'].$eol;
        $segment_count++;

        // Begin Message
        $string .= 'BGM+';
        $string .= $message['message_code'].'+';
        $string .= $message['document_id'].'+';
        $string .= $message['function_code'].$eol;
        $segment_count++;

        $message['document_date'] = substr($message['document_date'], 0, 8);  // strip any time from datetime
        $string .= 'DTM+137:'.$message['document_date'].':102'.$eol;
        $segment_count++;

        $string .= 'RFF+ON:'.$message['po_number'].$eol;
        $segment_count++;

        // Parties
        if (!empty($message['buyer_data'])) {
            $data = $message['buyer_data'];
            $string .= 'NAD+BY+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        if (!empty($message['supplier_data'])) {
            $data = $message['supplier_data'];
            $string .= 'NAD+SU+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        if (!empty($message['delivery_address'])) {
            $data = $message['delivery_address'];
            $string .= 'NAD+DP+'.$data['party_id'].'::9+';
            $string .= $this->_writeAddressData($data).$eol;
            $segment_count++;
        } // if

        $string .= 'CUX+2:'.$message['currency_code'].':4'.$eol;
        $segment_count++;

        foreach ($message['line_items'] as $ix => $item) {
            if (!empty($item['seq_no'])) {
                $item_seq_no = $item['seq_no'];
            } else {
                $item_seq_no = $ix+1;
            } // if

            if (!empty($item['ean'])) {
                $string .= 'LIN+'.$item_seq_no.'+'.$item['action'].'+'.$item['ean'].':EN'.$eol;
                $segment_count++;
            } else {
                $string .= 'LIN+'.$item_seq_no.$eol;
                $segment_count++;
            } // if
            if (!empty($item['part_no'])) {
                $string .= 'PIA+5+'.$item['part_no'].':SA'.$eol;
                $segment_count++;
            } // if
            if ($item['qty_despatched'] > 0) {
                $string .= 'QTY+12:'.$item['qty_despatched'].$eol;
                $segment_count++;
            } // if
            if ($item['qty_cancelled'] > 0) {
                $string .= 'QTY+182:'.$item['qty_cancelled'].$eol;
                $segment_count++;
            } // if
            if ($item['qty_rejected'] > 0) {
                $string .= 'QTY+185:'.$item['qty_rejected'].$eol;
                $segment_count++;
            } // if
            if ($item['qty_backorder'] > 0) {
                $string .= 'QTY+83:'.$item['qty_backorder'].$eol;
                $segment_count++;
            } // if
            if ($item['qty_free'] > 0) {
                $string .= 'QTY+192:'.$item['qty_free'].$eol;
                $segment_count++;
            } // if
            // one of these two dates may be present
            if (!empty($item['est_despatch_date'])) {
                $string .= 'DTM+11:'.$item['est_despatch_date'].':102'.$eol;
                $segment_count++;
            } elseif (!empty($item['est_delivery_date'])) {
                $string .= 'DTM+67:'.$item['est_delivery_date'].':102'.$eol;
                $segment_count++;
            } // if
            if (!empty($item['unit_price'])) {
                $string .= 'PRI+AAA:'.$item['unit_price'].':CT:NTP'.$eol;
                $segment_count++;
            } // if
            if (!empty($item['tax_rate'])) {
                $string .= 'TAX+7+VAT+++:::'.$item['tax_rate'].$eol;
                $segment_count++;
            } // if
        } // foreach

        $string .= 'UNS+S'.$eol;  // section separator
        $segment_count++;
        $string .= 'CNT+2:'.count($message['line_items']).$eol;
        $segment_count++;

        // output Message Trailer
        $string .= 'UNT+';
        $string .= $segment_count.'+';
        $string .= $message['message_ref'].$eol;

        return $string;

    } // _output_ORDRSP

    // ****************************************************************************
    function _writeAddressData ($data)
    {
        $string = '';

        // party_name may have up to 5 lines
        $string .= '+'.$data['party_name1'];
        if (!empty($data['party_name2'])) {
            $string .= ':'.$data['party_name2'];
        } // if
        if (!empty($data['party_name3'])) {
            $string .= ':'.$data['party_name3'];
        } // if
        if (!empty($data['party_name4'])) {
            $string .= ':'.$data['party_name4'];
        } // if
        if (!empty($data['party_name5'])) {
            $string .= ':'.$data['party_name5'];
        } // if
        // street may have up to 3 lines
        $string .= '+'.$data['street1'];
        if (!empty($data['street2'])) {
            $string .= ':'.$data['street2'];
        } // if
        if (!empty($data['street3'])) {
            $string .= ':'.$data['street3'];
        } // if
        $string .= '+'.$data['city'];
        $string .= '+'.$data['county'];
        $string .= '+'.$data['postcode'];
        $string .= '+'.$data['country_code'];

        return $string;

    } // _writeAddressData

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

// ****************************************************************************
} // end edi_writer
// ****************************************************************************

?>
