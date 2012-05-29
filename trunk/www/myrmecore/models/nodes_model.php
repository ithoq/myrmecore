<?php

/**
 * Nodes_model handles the nodes table
 *
 * @category   Model 
 * @package    Node management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Nodes_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getEnabledNodes($zoneid)
    {
		$this->db->select('id,name')->from('nodes')->where(array('zone' => $zoneid,'enabled' => 'TRUE'))->order_by('id','ASC');
		$query = $this->db->get();		
		
		$result = array();
		foreach ($query->result_array() as $row)
		{
			$result[$row['id']] = $row['name'];
		}				
		return $result;		
	}
	
	function getNode($id)
	{
        $result = array();
        $query = $this->db->get_where('nodes', array('id' => $id));
        if ($query->num_rows() > 0) {
            $result = $query->row_array(); 
        }     
        return $result;   	
	}
	
	function add($data)
	{
		$this->db->trans_begin();
		$this->db->insert('nodes', $data); 

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
		$this->db->update('nodes', $data); 

		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			return false;
		} else {
			$this->db->trans_commit();
			return $this->db->affected_rows();
		}	
	}		

}
