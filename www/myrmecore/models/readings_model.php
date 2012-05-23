<?php

/**
 * Readings_model handles the readings table
 *
 * @category   Model 
 * @package    Sensor readings/measurement management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Readings_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getReadings($params,$limit)
    {	
		$this->db->from('readings')->where($params)->order_by('id', 'ASC')->limit($limit);
		$query = $this->db->get();
		
		$result = array();
		$readings = array();
		$num_readings = $query->num_rows();
		$result['num_readings'] = $num_readings;
		if ($num_readings > 0)
		{
			foreach ($query->result_array() as $row)
			{
				$readings[$row['id']] = array('sensor_id' => $row['sensor_id'], 'transductor_id' => $row['transductor_id'], 'timestamp' => $row['timestamp'], 'value' => $row['value']);
			}		
			$result['readings'] = $readings;	
		}		
		return $result;		
	}

}
