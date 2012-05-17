<?php

/**
 * News_model handles direct transactions to the news table
 *
 * @category   Model 
 * @package    News reading & distribution
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class News_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();
    }	
    
    function getLatestNews($role,$reach,$number)
    {
		$this->db->select('date, title, content')->from('news')->where(array('role' => $role, 'reach' => $reach))->order_by('date','desc')->limit($number);
        $query = $this->db->get();
        return $query->result();  		
	}
}
