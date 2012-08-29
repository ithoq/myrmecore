<?php

/**
 * Users_model handles direct transactions to the users table
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

class Users_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
        $this->load->model('API_Keys_model');
    }
    
	function authenticate($credentials)
	{
		$result = array();
    	$this->db->select('value')->from('settings')->where('name','auth_mode');
    	$query = $this->db->get();		
		$auth_mode = $query->row()->value;
		
		switch ($auth_mode)
		{
			case 'DB':
				$query = $this->db->get_where('users', array('login' => $credentials['username']));
				if ($query->num_rows() == 0) {
					$result['result'] = 'FAILED';
					$result['cause'] = 'WRONG_USERNAME';
					$result['message'] = $this->Strings_model->translate($result['cause'],NULL);
					return $result;
				} else {
					$this->db->select('value')->from('settings')->where('name','hash_loops');
					$query = $this->db->get();		
					$hash_loops = $query->row()->value;	
					
					$this->db->select('salt')->from('users')->where('login',$credentials['username']);
					$query = $this->db->get();		
					$salt = $query->row()->salt;	
					
					$halfpass = str_split($credentials['password'],(strlen($credentials['password'])/2)+1);
					$hash = hash('whirlpool', $halfpass[0].$salt.$halfpass[1]);
					
					for ($i=1; $i<$hash_loops; $i++)
					{
						$hash = hash('whirlpool',$hash);
					}
					
					$query = $this->db->get_where('users', array('login' => $credentials['username'],'hash' => $hash));
					if ($query->num_rows() == 0) {
						$result['result'] = 'FAILED';
						$result['cause'] = 'WRONG_PASSWORD';
						$result['message'] = $this->Strings_model->translate($result['cause'],NULL);
						return $result;
					} else {
						$check = $this->db->get_where('users', array('login' => $credentials['username'],'enabled' => 'TRUE'));
						if ($check->num_rows() == 0) {
							$result['result'] = 'FAILED';
							$result['cause'] = 'DISABLED_USER';
							$result['message'] = $this->Strings_model->translate($result['cause'],NULL);
							return $result;							
						} else {
							$row = $query->row(); 

							$user = array();
							$user['ID'] = $row->id;
							$user['Name'] = $row->name;
							$user['Login'] = $row->login;
							$user['Email'] = $row->email;
							$user['Role'] = $row->role;
							$user['Phone'] = $row->phone;																											
							$user['Key'] = $this->API_Keys_model->generate($row->role);							
							$user['Preferences'] = $row->preferences;
							
							$result['result'] = 'SUCCESS';
							$result['user'] = $user;
							return $result;							
						}
					}					
				}				
				break;
			case 'LDAP':
				$result['result'] = 'FAILED';
				$result['cause'] = 'NOT_IMPLEMENTED';
				$result['message'] = $this->Strings_model->translate($result['cause'],NULL);
				return $result;			
				break;
		}		
		

	}
	
	function getAll($id)
	{
		$query = $this->db->get_where('users', array('id' => $id));	
		if ($query->num_rows() > 0)
		{
			$row = $query->row_array(); 
			return $row;
		} else {
			return NULL;	
		} 
	}
	
	function getPreferences($id)
	{
		$result = array();
    	$this->db->select('preferences')->from('users')->where('id',$id);
    	$query = $this->db->get();		
    	if ($query->num_rows() > 0) {		
			$row = $query->row();
			$result['result'] = 'SUCCESS';
			$result['preferences'] = json_decode($query->row()->preferences);					
		} else {
			$result['result'] = 'FAILED';
			$result['cause'] = 'DISABLED_USER';					
		}	
		return $result;		
	}
	
	function add($userlogin,$password,$role)
    {
		$this->load->library('SaltGenerator');
		
    	$this->db->select('value')->from('settings')->where('name','hash_loops');
    	$query = $this->db->get();		
		$hash_loops = $query->row()->value;		
		
    	$this->db->select('value')->from('settings')->where('name','salt_size');
    	$query = $this->db->get();		
		$salt_size = $query->row()->value;		
			
		$salt = $this->saltgenerator->gen($salt_size);
		
		$halfpass = str_split($password,(strlen($password)/2)+1);
		$hash = hash('whirlpool', $halfpass[0].$salt.$halfpass[1]);
		
		for ($i=1; $i<$hash_loops; $i++)
		{
			$hash = hash('whirlpool',$hash);
		}
		
		$newrow = array('login' => $userlogin, 'salt' => $salt, 'hash' => $hash, 'role' => $role);
		$this->db->trans_start();
		$this->db->insert('users', $newrow); 
		$user_id = $this->db->insert_id();
		$this->db->trans_complete();
		
		if ($this->db->trans_status() === FALSE)
		{
			return NULL;
		} else {
			return $user_id;
		}
	}

}
