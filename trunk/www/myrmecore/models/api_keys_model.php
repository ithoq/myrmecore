<?php

/**
 * API_Keys_model handles direct transactions to the api_keys table
 *
 * @category   Model 
 * @package    API KEY Management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2011 Grupo DyD Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */
 
 class API_Keys_model extends CI_Model {
 
	function __construct()
    {
        parent::__construct();
    }
    
    public function generate($role)
    {
		do
		{
			$salt = sha1(time().mt_rand());
			$new_key = substr($salt, 0, 40);
		}

		while (self::_key_exists($new_key));
		
		$level = array('PUBLIC' => 0, 'USER' => 1, 'ADMIN' => 2, 'AUDIT' => 3, 'SUPPORT' => 4);
		
		$this->db->insert('api_keys', array('key' => $new_key, 'level' => $level[$role], 'ignore_limits' => 1, 'date_created' => time())); 

		return $new_key;		
	}
	
	public function destroy($key)
	{
		$this->db->delete('api_keys', array('key' => $key));
		return $this->db->affected_rows();	
	}
	
	private function _key_exists($key)
	{
		return $this->db->where('key', $key)->count_all_results('api_keys') > 0;
	}
 }
