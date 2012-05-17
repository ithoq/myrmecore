<?php

/**
 * Settings_model handles direct transactions to the settings table
 *
 * @category   Model 
 * @package    Settings & setup management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Settings_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function getValue($name)
    {
		$this->db->select('value')->from('settings')->where('name',$name);
		$query = $this->db->get();		
		return $query->row()->value;		
	}

}
