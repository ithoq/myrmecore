<?php defined('BASEPATH') OR exit('No direct script access allowed');
 
require APPPATH.'/libraries/REST_Controller.php';

class Base_Controller extends REST_Controller
{
	function __construct()
	{
		parent::__construct();
		
		// Write common code here
	}
}
