<?php

/**
 * Zones_model handles the zones table
 *
 * @category   Model 
 * @package    Geographical zone management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Zones_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getEnabledZones()
    {
		$this->db->select('id,name')->from('zones')->where('enabled','TRUE')->order_by('id','ASC');
		$query = $this->db->get();		
		
		$result = array();
		foreach ($query->result_array() as $row)
		{
			$result[$row['id']] = $row['name'];
		}				
		return $result;		
	}

}
