<?php defined('BASEPATH') OR exit('No direct script access allowed');

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
						$result[$enabledZones[$zone]][$enabledNodes[$node]][$enabledGroups[$group]] = array_values($enabledSensors);						
					}					
				}				
			}
			
			//print_r($result);
			$this->response($result, 200);
		} else {
			$this->response(NULL, 403);	
		}		
	}

}
