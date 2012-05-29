<?php

/**
 * Action_sets_model handles groups/sets of actions
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

class Action_sets_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getActionSet($id)
    {
        $result = array();
        $query = $this->db->get_where('action_sets', array('id' => $id));
        if ($query->num_rows() > 0) {
            $action_set = $query->row_array(); 
            return $action_set;
        } else {
            return array();
        }               
    }

}
