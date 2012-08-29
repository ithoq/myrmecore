<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Main Configuration controller
 *
 * @category   General 
 * @package    Configuration
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Configuration extends Base_Controller
{ 
    function __construct()
    {
        parent::__construct();
    }	
    
    function add_user_post()
    {
		if ($this->session->userdata('ID')) {	
			$this->load->model('Users_model');
			
			$userlogin = $this->post('userlogin');
			$password = $this->post('password');
			$role = 'USER';
			
			$result = $this->Users_model->add($userlogin,$password,$role);
			
			$this->response($result, 200);
		} else {
			$this->response(NULL, 403);	
		}			
	}	
}
