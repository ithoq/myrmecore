<?php

/**
 * Groups_model handles the groups table
 *
 * @category   Model 
 * @package    Group management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Groups_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getEnabledGroups($nodeid)
    {
		$this->db->select('id,name')->from('groups')->where(array('node' => $nodeid,'enabled' => 'TRUE'))->order_by('id','ASC');
		$query = $this->db->get();		
		
		$result = array();
		foreach ($query->result_array() as $row)
		{
			$result[$row['id']] = $row['name'];
		}				
		return $result;		
	}

}
