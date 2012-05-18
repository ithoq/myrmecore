<?php

/**
 * Transductors_model handles transactions to and from transductors table
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

class Transductors_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
        $this->load->model('Transductor_types_model', '', TRUE);
    }
    
    function getTransductors($sensor_id)
    {
        $result = array();
        $query = $this->db->get_where('transductors', array('sensor' => $sensor_id));
        if ($query->num_rows() > 0) {
            foreach ($query->result_array() as $row)
            {
               $transductorType = $this->Transductor_types_model->getTransductorType($row['type']);
               $transductorTypes[$row['type']] = array('name' => $transductorType['name'], 'units' => $transductorType['units']);
            }
            return $transductorTypes;
        } else {
            return array();
        }               
    }

}
