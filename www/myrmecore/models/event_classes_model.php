<?php

/**
 * Event_classes_model handles event types stored within event_classes table
 *
 * @category   Model 
 * @package    Event classes
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Event_classes_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getEventClass($id)
    {
        $result = array();
        $query = $this->db->get_where('event_classes', array('id' => $id));
        if ($query->num_rows() > 0) {
            $event_class = $query->row_array(); 
            return $event_class;
        } else {
            return array();
        }               
    }

}
