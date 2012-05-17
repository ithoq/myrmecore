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
    
    function getEnabledSensors($groupid)
    {
		$this->db->select('id,name')->from('sensors')->where(array('group' => $groupid,'enabled' => 'TRUE'))->order_by('id','ASC');
		$query = $this->db->get();		
		
		$result = array();
		foreach ($query->result_array() as $row)
		{
			$result[$row['id']] = $row['name'];
		}				
		return $result;		
	}

}
