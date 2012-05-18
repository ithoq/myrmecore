<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Platform management
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

class Platform extends Base_Controller
{ 
	function getplatform_get()
	{
		if ($this->session->userdata('ID')) {			
			$this->load->model('Zones_model', '', TRUE);
			$this->load->model('Nodes_model', '', TRUE);
			$this->load->model('Groups_model', '', TRUE);
			$this->load->model('Sensors_model', '', TRUE);
			$result = array();
			$enabledZones = $this->Zones_model->getEnabledZones();
			foreach (array_keys($enabledZones) as $zone)
			{
				$enabledNodes = $this->Nodes_model->getEnabledNodes($zone);
				foreach (array_keys($enabledNodes) as $node)
				{
					$enabledGroups = $this->Groups_model->getEnabledGroups($node);
					foreach (array_keys($enabledGroups) as $group)
					{
						$enabledSensors = $this->Sensors_model->getEnabledSensors($group);
						$result[$enabledZones[$zone]][$enabledNodes[$node]][$enabledGroups[$group]] = $enabledSensors;						
					}					
				}				
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
