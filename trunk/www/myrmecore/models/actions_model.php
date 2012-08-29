<?php

/**
 * Actions_model handles individual actions
 *
 * @category   Model 
 * @package    Action sets
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Actions_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function search($params)
    {
		$query = $this->db->get_where('actions', $params);
		
		if ($query->num_rows() > 0) {
			$result = array();
			foreach ($query->result_array() as $row)
			{
				$row_id = $row['id'];
				unset($row['id']);
				$result[$row_id] = $row;
			}				
			return $result;
		} else {
			return array();
		}
	}
}
