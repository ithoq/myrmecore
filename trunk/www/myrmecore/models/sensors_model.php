<?php

/**
 * Sensors_model handles the sensors table
 *
 * @category   Model 
 * @package    Sensor management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Sensors_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getSensors($params)
    {
		$this->db->from('sensors')->where($params)->order_by('id','ASC');
		$query = $this->db->get();		
		
		$result = array();
		foreach ($query->result_array() as $row)
		{
			$result[$row['id']] = $row;
		}				
		return $result;		
	}
	
	function getEnabledSensors($group)
	{
		$sensors = $this->getSensors(array('group' => $group,'enabled' => 'TRUE'));
		$result = array();
		foreach ($sensors as $sensor)
		{
			$result[$sensor['id']] = $sensor['name'];
		}
		return $result;
	}
	
	function getSensorShort($sensor_id)
	{
        $result = array();
        $query = $this->db->get_where('sensors', array('id' => $sensor_id));
        if ($query->num_rows() > 0) {
            $result = $query->row_array(); 
        }     
        return $result;   		
	}		
    
    function getSensor($sensor_id)
    {
        $result = array();
        $query = $this->db->get_where('sensors', array('id' => $sensor_id));
        if ($query->num_rows() > 0) {
            $sensor = $query->row_array(); 
            $result['result'] = 'SUCCESS';
            $result['sensor'] = $sensor;
            $this->load->model('Sensor_models_model', '', TRUE);
            $this->load->model('Transductors_model', '', TRUE);
            $sensor_model_id = $result['sensor']['model'];
            $result['sensor']['model'] = $this->Sensor_models_model->getSensorModel($sensor_model_id);
            $result['sensor']['transductors'] = $this->Transductors_model->getTransductors($sensor['id']);
        } else {
            $result['result'] = 'FAILED';
            $result['cause'] = 'SENSOR_NOT_FOUND';
        }    
        return $result;            
    }

	function add($data)
	{
		$this->db->trans_begin();
		$this->db->insert('sensors', $data); 

		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			return false;
		} else {
			$this->db->trans_commit();
			return $this->db->insert_id();
		}		
	}
	
	function edit($id,$data)
	{
		$this->db->trans_begin();
		$this->db->where('id', $id);
		$this->db->update('sensors', $data); 

		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			return false;
		} else {
			$this->db->trans_commit();
			return $this->db->affected_rows();
		}	
	}
}
