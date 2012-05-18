<?php

/**
 * Transductor_types_model handles transactions to and from transductor_types table
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

class Transductor_types_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getTransductorType($type)
    {
        $result = array();
        $query = $this->db->get_where('transductor_types', array('id' => $type));
        if ($query->num_rows() > 0) {
            $transductorType = $query->row_array(); 
            return $transductorType;
        } else {
            return array();
        }               
    }

}
