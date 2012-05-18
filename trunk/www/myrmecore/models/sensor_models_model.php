<?php

/**
 * Sensor_models_model handles the table that holds sensor version inventory
 *
 * @category   Model 
 * @package    Sensor version inventory
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Sensor_models_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getSensorModel($id)
    {
        $result = array();
        $query = $this->db->get_where('sensor_models', array('id' => $id));
        if ($query->num_rows() > 0) {
            $sensor_model = $query->row_array(); 
            return $sensor_model;
        } else {
            return array();
        }               
    }

}
