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

<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller {

	public function index()
	{
		$this->load->view('welcome_message');
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */