<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Readings query, management
 *
 * @category   General 
 * @package    Platform
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Readings extends Base_Controller
{ 
    function __construct()
    {
        parent::__construct();
        $this->load->model('Readings_model');
    }	
	
	function query_post()
	{
		if ($this->session->userdata('ID')) {	
			$params = array();		
			if ($this->post('start')) {
				$params['timestamp >='] = $this->post('start');
			} 
			
			if ($this->post('end')) {
				$params['timestamp <='] = $this->post('end');
			} 
			
			if (is_numeric($this->post('sensor_id'))) {
				$this->load->model('Sensors_model', '', TRUE);
				$sensorShort = $this->Sensors_model->getSensorShort($this->post('sensor_id'));
				
				if ($sensorShort['enabled'] == TRUE) {
					$params['sensor_id'] = $this->post('sensor_id');	
				}
			}					
			
			if (is_numeric($this->post('transductor_id'))) {
				$params['transductor_id'] = $this->post('transductor_id');	
			}
			
			if (is_numeric($this->post('value_greater_than'))) {
				$params['value >='] = $this->post('value_greater_than');
			} 			
			
			if (is_numeric($this->post('value_lesser_than'))) {
				$params['value <='] = $this->post('value_lesser_than');
			} 				
			
			if (is_numeric($this->post('limit'))) {
				$limit = $this->post('limit');
			} else {
				$limit = $this->Settings_model->getValue('default_query_limit');	
			}	
			$result = array();
			
			if (count($params) > 0) {
				$result = $this->Readings_model->getReadings($params,$limit);			
			} else {
				$result = array('result' => 'FAILED', 'cause' => 'NO_ARGUMENTS_GIVEN');
			}
						
			$this->response($result, 200);
		} else {
			$this->response(NULL, 403);	
		}		
	}
    
    function getsensor_post()
    {
        if ($this->session->userdata('ID')) {            
            $sensor_id = $this->post('sensor_id');
            if (is_numeric($sensor_id)) {
                $result = array();
                $this->load->model('Sensors_model', '', TRUE);
                $result = $this->Sensors_model->getSensor($sensor_id);                   
            } else {
                $this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_SENSOR_ID'), 400);
            }
            $this->response($result, 200);
        } else {
            $this->response(NULL, 403);    
        }        
    }

}
