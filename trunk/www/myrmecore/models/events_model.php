<?php

/**
 * Events_model handles transactions to the events table
 *
 * @category   Model 
 * @package    Important events, table 
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Events_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getEvents($params,$limit)
    {
		$this->db->from('events')->where($params)->order_by('id', 'DESC')->limit($limit);
		$query = $this->db->get();
		
		$result = array();
		if ($query->num_rows() > 0)
		{
			$this->load->model('Event_classes_model', '', TRUE);
			$this->load->model('Action_sets_model', '', TRUE);
			foreach ($query->result_array() as $row)
			{
				$event_class = $this->Event_classes_model->getEventClass($row['class']);
				$action_set = $this->Action_sets_model->getActionSet($row['action_set']);
				$result[] = array('reading' => $row['reading'], 'class' => $event_class['name'], 'action_set' => $action_set['name'], 'timestamp' => $row['timestamp'], 'cleared' => $row['cleared']);
			}			
		}		
		return $result;		
	}

}
