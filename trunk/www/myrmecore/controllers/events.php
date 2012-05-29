<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Event dispatching, notification & configuration
 *
 * @category   General 
 * @package    Events
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Events extends Base_Controller
{ 
    function __construct()
    {
        parent::__construct();
    }	
    
    function getlatest_post()
    {
        if ($this->session->userdata('ID')) {   
			if (is_numeric($this->post('limit'))) {
				$limit = $this->post('limit');
				$this->load->model('Events_model', '', TRUE);   
				$params = array();
				if ($this->post('class')) {
					$params['class'] = $this->post('class');
				}
				$result = $this->Events_model->getEvents($params,$limit);				
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_LIMIT'), 400);	
			} 
  
            $this->response($result, 200);
        } else {
            $this->response(NULL, 403);    
        } 		
	}   
}
