<?php
/**
 * MyrmeCore
 *
 * A Web-based Wireless Sensor Network Management System
 *
 * @package		MyrmeCore
 * @author		Juan F. Duque <jfelipe@grupodyd.com>
 * @copyright	Copyright (c) 2011, Dinamica y Desarrollo Ltda.
 * @license		http://www.myrmecore.com/license/
 * @link		http://www.myrmecore.com
 * @since		Version 0.1
 * @filesource
 */

class Welcome extends Controller {

	function Welcome()
	{
		parent::Controller();	
	}
	
	function index()
	{
		$this->load->view('welcome_message');
	}
}

/* End of file welcome.php */
/* Location: ./system/application/controllers/welcome.php */