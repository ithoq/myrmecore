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
	
	function getGroup($id)
	{
        $result = array();
        $query = $this->db->get_where('groups', array('id' => $id));
        if ($query->num_rows() > 0) {
			$group = $query->row_array();
			return $group;
        } else {
			return array();
        }    
	}
	
	function add($data)
	{
		$this->db->trans_begin();
		$this->db->insert('groups', $data); 

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
		$this->db->update('groups', $data); 

		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			return false;
		} else {
			$this->db->trans_commit();
			return $this->db->affected_rows();
		}	
	}	
}
