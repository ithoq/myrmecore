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
    function __construct()
    {
        parent::__construct();
    }
    	
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
    
    function getsensors_get()
    {
        if ($this->session->userdata('ID')) {  
			$this->load->model('Sensors_model', '', TRUE);          
			$this->load->model('Sensor_models_model', '', TRUE);          
			$this->load->model('Groups_model', '', TRUE);          
			$sensor_list = $this->Sensors_model->getSensors(array());
			foreach ($sensor_list as $sensor)
			{
				$sensor_model = $this->Sensor_models_model->getSensorModel($sensor['model']);
				$sensor_list[$sensor['id']]['model'] = $sensor_model['name'];
				
				$group = $this->Groups_model->getGroup($sensor['group']);
				$sensor_list[$sensor['id']]['group'] = $group['name'];
				
				if ($sensor['enabled'] = 'true') {
					$sensor_list[$sensor['id']]['enabled'] = 'TRUE';	
				} else {
					$sensor_list[$sensor['id']]['enabled'] = 'FALSE';	
				}
			}
            $this->response($sensor_list, 200);
        } else {
            $this->response(NULL, 403);    
        } 		
	}
	
	function addzone_post()
	{
        if ($this->session->userdata('ID')) {            
			if ($this->input->post('name') && (strlen($this->input->post('name')) > 0)) {
				$this->load->model('Zones_model', '', TRUE);
				$add_result = $this->Zones_model->add(array('name' => $this->input->post('name', TRUE)));
				if (is_numeric($add_result)) {
					$result = $this->Zones_model->getZone($add_result);
					$this->response($result, 200);	
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);	
				}
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_ZONE_NAME'), 400);	
			}
            
        } else {
            $this->response(NULL, 403);    
        } 		
	}
	
	function editzone_post()
	{
        if ($this->session->userdata('ID')) {            
			if (is_numeric($this->input->post('id'))) {
				$id = $this->input->post('id', TRUE);
				$data = array();
				if (strlen($this->input->post('name', TRUE)) > 0) {
					$data['name'] = $this->input->post('name', TRUE);
				} 
				
				$enabled = $this->input->post('enabled', TRUE);
				if (in_array($enabled, array('true','TRUE','t','false','FALSE','f','0','1'), TRUE)) {
					$data['enabled'] = $this->input->post('enabled', TRUE);
				}
				
				if (count($data) > 0) {
					$this->load->model('Zones_model', '', TRUE);
					$edit_result = $this->Zones_model->edit($id,$data);
					if ($edit_result > 0) {
						$result = $this->Zones_model->getZone($id);
						$this->response($result, 200);
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);
					}	
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'NO_PARAMETERS_SPECIFIED'), 400);		
				} 								
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_ZONE_ID'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        }		
	}

	function addnode_post()
	{
        if ($this->session->userdata('ID')) {            
			if ($this->input->post('name', TRUE) && (strlen($this->input->post('name', TRUE)) > 0)) {
				$name = $this->input->post('name', TRUE);
				if (is_numeric($this->input->post('zone', TRUE))) {
					$this->load->model('Zones_model', '', TRUE);
					$zone = $this->input->post('zone', TRUE);					
					$zone_check = $this->Zones_model->getZone($zone);
					if (count($zone_check) > 0) {
						$this->load->model('Nodes_model', '', TRUE);
						$add_result = $this->Nodes_model->add(array('name' => $name, 'zone' => $zone));
						if (is_numeric($add_result)) {
							$result = $this->Nodes_model->getNode($add_result);
							$this->response($result, 200);	
						} else {
							$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);	
						}													
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'ZONE_NOT_SET'), 400);	
					} 
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_ZONE_ID'), 400);	
				}
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_NODE_NAME'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        } 		
	}
	
	function editnode_post()
	{
        if ($this->session->userdata('ID')) {            
			if (is_numeric($this->input->post('id'))) {
				$id = $this->input->post('id', TRUE);
				$data = array();
				if (strlen($this->input->post('name', TRUE)) > 0) {
					$data['name'] = $this->input->post('name', TRUE);
				} 
				
				if (is_numeric($this->input->post('zone', TRUE))) {
					$this->load->model('Zones_model', '', TRUE);
					$zone = $this->input->post('zone', TRUE);					
					$zone_check = $this->Zones_model->getZone($zone);
					if (count($zone_check) > 0) {
						$data['zone'] = $zone;													
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'ZONE_NOT_SET'), 400);	
					} 					
				}
				
				$enabled = $this->input->post('enabled', TRUE);
				if (in_array($enabled, array('true','TRUE','t','false','FALSE','f','0','1'), TRUE)) {
					$data['enabled'] = $this->input->post('enabled', TRUE);
				}
				
				if (count($data) > 0) {
					$this->load->model('Nodes_model', '', TRUE);
					$edit_result = $this->Nodes_model->edit($id,$data);
					if ($edit_result > 0) {
						$result = $this->Nodes_model->getNode($id);
						$this->response($result, 200);
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);
					}	
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'NO_PARAMETERS_SPECIFIED'), 400);		
				} 								
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_NODE_ID'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        }		
	}
	
	function addgroup_post()
	{
        if ($this->session->userdata('ID')) {            
			if ($this->input->post('name', TRUE) && (strlen($this->input->post('name', TRUE)) > 0)) {
				$name = $this->input->post('name', TRUE);
				if (is_numeric($this->input->post('node', TRUE))) {
					$this->load->model('Nodes_model', '', TRUE);
					$node = $this->input->post('node', TRUE);					
					$node_check = $this->Nodes_model->getNode($node);
					if (count($node_check) > 0) {
						$this->load->model('Groups_model', '', TRUE);
						$add_result = $this->Groups_model->add(array('name' => $name, 'node' => $node));
						if (is_numeric($add_result)) {
							$result = $this->Groups_model->getGroup($add_result);
							$this->response($result, 200);	
						} else {
							$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);	
						}													
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'NODE_NOT_SET'), 400);	
					} 
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_NODE_ID'), 400);	
				}
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_GROUP_NAME'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        } 			
	}
	
	function editgroup_post()
	{
        if ($this->session->userdata('ID')) {            
			if (is_numeric($this->input->post('id'))) {
				$id = $this->input->post('id', TRUE);
				$data = array();
				if (strlen($this->input->post('name', TRUE)) > 0) {
					$data['name'] = $this->input->post('name', TRUE);
				} 
				
				if (is_numeric($this->input->post('node', TRUE))) {
					$this->load->model('Nodes_model', '', TRUE);
					$node = $this->input->post('node', TRUE);					
					$node_check = $this->Nodes_model->getNode($node);
					if (count($node_check) > 0) {
						$data['node'] = $node;													
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'NODE_NOT_SET'), 400);	
					} 					
				}
				
				$enabled = $this->input->post('enabled', TRUE);
				if (in_array($enabled, array('true','TRUE','t','false','FALSE','f','0','1'), TRUE)) {
					$data['enabled'] = $this->input->post('enabled', TRUE);
				}
				
				if (count($data) > 0) {
					$this->load->model('Groups_model', '', TRUE);
					$edit_result = $this->Groups_model->edit($id,$data);
					if ($edit_result > 0) {
						$result = $this->Groups_model->getGroup($id);
						$this->response($result, 200);
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);
					}	
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'NO_PARAMETERS_SPECIFIED'), 400);		
				} 								
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_GROUP_ID'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        }		
	}
	
	function addsensor_post()
	{
        if ($this->session->userdata('ID')) {            
			if ($this->input->post('name', TRUE) && (strlen($this->input->post('name', TRUE)) > 0)) {
				$name = $this->input->post('name', TRUE);
				if (is_numeric($this->input->post('model', TRUE))) {
					$this->load->model('Sensor_models_model', '', TRUE);
					$sensor_model = $this->input->post('model', TRUE);					
					$sensor_model_check = $this->Sensor_models_model->getSensorModel($sensor_model);
					if (count($sensor_model_check) > 0) {
						if (is_numeric($this->input->post('group', TRUE))) {
							$this->load->model('Groups_model', '', TRUE);
							$group = $this->input->post('group', TRUE);
							$group_check = $this->Groups_model->getGroup($group);
							if (count($group_check) > 0) {
								$this->load->model('Sensors_model', '', TRUE);								
								if ($this->input->post('hwaddress', TRUE) && (strlen($this->input->post('hwaddress', TRUE)) > 0)) {
									$hwaddress = $this->input->post('hwaddress', TRUE);	
								} else {
									$hwaddress = '';
								}								
								$add_result = $this->Sensors_model->add(array('name' => $name, 'hwaddress' => $hwaddress, 'model' => $sensor_model, 'group' => $group));	
								if (is_numeric($add_result)) {
									$result = $this->Sensors_model->getSensorShort($add_result);
									$this->response($result, 200);	
								} else {
									$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);	
								}														
							} else {
								$this->response(array('result' => 'FAILED','cause' => 'GROUP_NOT_SET'), 400);	
							}													
						} else {
							$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_GROUP_ID'), 400);
						}
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'SENSOR_MODEL_NOT_SET'), 400);	
					} 
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_SENSOR_MODEL_ID'), 400);	
				}
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_SENSOR_NAME'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        } 		
	}
	
	function editsensor_post()
	{
        if ($this->session->userdata('ID')) {            
			if (is_numeric($this->input->post('id'))) {
				$id = $this->input->post('id', TRUE);
				$data = array();
				if (strlen($this->input->post('name', TRUE)) > 0) {
					$data['name'] = $this->input->post('name', TRUE);
				} 
				
				if (strlen($this->input->post('hwaddress', TRUE)) > 0) {
					$data['hwaddress'] = $this->input->post('hwaddress', TRUE);
				} 				
				
				if (is_numeric($this->input->post('model', TRUE))) {
					$this->load->model('Sensor_models_model', '', TRUE);
					$sensor_model = $this->input->post('model', TRUE);					
					$sensor_model_check = $this->Sensor_models_model->getSensorModel($sensor_model);
					if (count($sensor_model_check) > 0) {
						$data['model'] = $sensor_model;													
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'SENSOR_MODEL_NOT_SET'), 400);	
					} 					
				}
				
				if (is_numeric($this->input->post('group', TRUE))) {
					$this->load->model('Groups_model', '', TRUE);
					$group = $this->input->post('group', TRUE);					
					$group_check = $this->Groups_model->getGroup($group);
					if (count($group_check) > 0) {
						$data['group'] = $group;													
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'GROUP_NOT_SET'), 400);	
					} 					
				}				
				
				$enabled = $this->input->post('enabled', TRUE);
				if (in_array($enabled, array('true','TRUE','t','false','FALSE','f','0','1'), TRUE)) {
					$data['enabled'] = $this->input->post('enabled', TRUE);
				}
				
				if (count($data) > 0) {
					$this->load->model('Sensors_model', '', TRUE);
					$edit_result = $this->Sensors_model->edit($id,$data);
					if ($edit_result > 0) {
						$result = $this->Sensors_model->getSensorShort($id);
						$this->response($result, 200);
					} else {
						$this->response(array('result' => 'FAILED','cause' => 'DB_TRANSACTION_ERROR'), 409);
					}	
				} else {
					$this->response(array('result' => 'FAILED','cause' => 'NO_PARAMETERS_SPECIFIED'), 400);		
				} 								
			} else {
				$this->response(array('result' => 'FAILED','cause' => 'EMPTY_OR_INVALID_SENSOR_ID'), 400);	
			}           
        } else {
            $this->response(NULL, 403);    
        }			
	}
}
