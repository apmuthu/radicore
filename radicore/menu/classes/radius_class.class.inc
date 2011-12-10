<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class radius_class
{
    // member variables
    var $server_array;          // array of RADIUS server addresses
    var $shared_secret;         // shared secret
    var $port;                  // port
    var $resource;              // resource
    var $timeout;               //
    var $max_tries;             //
    var $auth_type;             //

    function radius_class ()
    {
        require 'radius.config.inc';

        if (is_array($radserver)) {
        	$this->server_array = $radserver;
        } else {
            $this->server_array = (array)$radserver;
        } // if

        $this->port          = $radport;
        $this->shared_secret = $shared_secret;
        $this->timeout       = $timeout;
        $this->max_tries     = $max_tries;
        $this->auth_type     = $auth_type;

        if (!$this->resource = radius_auth_open()) {
            // "Cannot create RADIUS resource"
            trigger_error(getLanguageText('sys0172'), E_USER_ERROR);
        } // if

        foreach ($this->server_array as $server) {
            if (!radius_add_server($this->resource,
                                   $server,
                                   $this->port,
                                   $this->shared_secret,
                                   $this->timeout,
                                   $this->max_tries)) {
		        $error = radius_strerror($this->resource);
		        // "RADIUS error: xxx"
		        trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
            } // if
        } // foreach

    } // radius_class

    function authenticate ($username, $password)
    // check if this username and password are valid.
    {
        if (!radius_create_request($this->resource, RADIUS_ACCESS_REQUEST)) {
		    $error = radius_strerror($this->resource);
		    // "RADIUS error: xxx"
		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
        } // if

        if (!radius_put_attr($this->resource, RADIUS_USER_NAME, $username)) {
            $error = radius_strerror($this->resource);
		    // "RADIUS error: xxx"
		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
        } // if

        switch ($this->auth_type) {
        	case 'chap':
        		// generate Challenge
                mt_srand(time());
                $chall = mt_rand();

                // FYI: CHAP = md5(ident + plaintextpass + challenge)
                $chapval = pack('H*', md5(pack('Ca*',1 , $password . $chall)));
                // Radius wants the CHAP Ident in the first byte of the CHAP-Password
                $pass = pack('C', 1) . $chapval;

                if (!radius_put_attr($this->resource, RADIUS_CHAP_PASSWORD, $pass)) {
                    $error = radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if

                if (!radius_put_attr($this->resource, RADIUS_CHAP_CHALLENGE, $chall)) {
                    $error = radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if
        		break;

        	case 'mschapv1':
                include_once('radius.mschap.php');

                $challenge = GenerateChallenge();
                printf ("Challenge:%s\n", bin2hex($challenge));

                if (!radius_put_vendor_attr($this->resource, RADIUS_VENDOR_MICROSOFT, RADIUS_MICROSOFT_MS_CHAP_CHALLENGE, $challenge)) {
                    $error = 'RADIUS_MICROSOFT_MS_CHAP_CHALLENGE: ' .radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if

                $ntresp = ChallengeResponse($challenge, NtPasswordHash($password));
                $lmresp = str_repeat ("\0", 24);

                printf ("NT Response:%s\n", bin2hex($ntresp));
                // Response: chapid, flags (1 = use NT Response), LM Response, NT Response
                $resp = pack('CCa48',1 ,1, $lmresp . $ntresp);
                printf ("Response:%d %s\n", strlen($resp), bin2hex($resp));

                if (!radius_put_vendor_attr($this->resource, RADIUS_VENDOR_MICROSOFT, RADIUS_MICROSOFT_MS_CHAP_RESPONSE, $resp)) {
                    $error = 'RADIUS_MICROSOFT_MS_CHAP_RESPONSE: ' .radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if
        		break;

        	case 'mschapv2':
                include_once('radius.mschap.php');

                $authChallenge = GenerateChallenge(16);
                printf ("Auth Challenge:%s\n", bin2hex($authChallenge));

                if (!radius_put_vendor_attr($this->resource, RADIUS_VENDOR_MICROSOFT, RADIUS_MICROSOFT_MS_CHAP_CHALLENGE, $authChallenge)) {
                    $error = 'RADIUS_MICROSOFT_MS_CHAP_CHALLENGE: ' .radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if

                // we have no client, therefore we generate the Peer-Challenge
                $peerChallenge = GeneratePeerChallenge();
                printf ("Peer Challenge:%s\n", bin2hex($peerChallenge));

                $ntresp = GenerateNTResponse($authChallenge, $peerChallenge, $username, $password);
                $reserved = str_repeat ("\0", 8);

                printf ("NT Response:%s\n", bin2hex($ntresp));
                // Response: chapid, flags (1 = use NT Response), Peer challenge, reserved, Response
                $resp = pack('CCa16a8a24',1 , 1, $peerChallenge, $reserved, $ntresp);
                printf ("Response:%d %s\n", strlen($resp), bin2hex($resp));

                if (!radius_put_vendor_attr($this->resource, RADIUS_VENDOR_MICROSOFT, RADIUS_MICROSOFT_MS_CHAP2_RESPONSE, $resp)) {
                    $error = 'RADIUS_MICROSOFT_MS_CHAP_RESPONSE: ' .radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if
        		break;

        	case 'pap':
        	default:
        	    if (!radius_put_attr($this->resource, RADIUS_USER_PASSWORD, $password)) {
                    $error = radius_strerror($this->resource);
        		    // "RADIUS error: xxx"
        		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
                } // if
        		break;
        } // switch

        $result = radius_send_request($this->resource);
		if ($result == RADIUS_ACCESS_ACCEPT) {
			$loginAccepted = true;

		} else if ($result == RADIUS_ACCESS_REJECT) {
			$loginAccepted = false;

		} else if ($result == RADIUS_ACCESS_CHALLENGE) {
			$loginAccepted = false;

		} else {
		    $error = radius_strerror($this->resource);
		    // "RADIUS error: xxx"
		    trigger_error(getLanguageText('sys0173', $error), E_USER_ERROR);
		} // if

        return $result;

    } // authenticate

} // radius_class
?>
