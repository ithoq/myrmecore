<?php

/**
 * Strings_model handles direct transactions to the strings table
 *
 * @category   Model 
 * @package    String & regionalization management
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Strings_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
        $this->load->model('Settings_model');
    }
    
    function translate($name,$language)
    {
		if (!isset($language) or $language == 'default') {
			$language = $this->Settings_model->getValue('default_language');
		}
		$this->db->select('text')->from('strings')->where('lang',$language)->where('name',strtolower($name));	
		$query = $this->db->get(); 
		
		if ($query->num_rows() > 0)
		{
			return $query->row()->text;
		} else {
			return NULL;
		}		
		
	}
    
    function getStringSet($widget,$language) 
    {
		$default_language = $this->Settings_model->getValue('default_language');
    	$strings = array();
		switch ($widget) {
		    case 'login':
		        $stringlist = array('authentication','username','password','enter','empty_password','empty_username','already_authenticated','authentication_required','date','title','content');
		        break;			
		    case 'user_caller':
		        $stringlist = array('call_panel','next','create','actions','details','finish','dump','restart','insist','on_hold','resume','transfer','turn','service','name');
		        break;
		    case 'user_slots':
		        $stringlist = array('slot','slot_listing','you_selected_slot','select_your_stage','select_your_slot');
		        break;
		    case 'admin_usermgmt':
		        $stringlist = array('username','password','user_already_exists','user_already_exists_detail');
		        break;
		    case 'admin_status':
		        $stringlist = array('status_panel','groups','spots','slots','users','services','origin');
		        break;		        		        
		}
		
    	foreach ($stringlist as $stringitem) {
     		$this->db->select('name,text')->from('strings')->where('lang',$language)->where('name',$stringitem);	
 			$query = $this->db->get(); 
 			
 			if ($query->num_rows() > 0)
 			{
				$row = $query->row(); 
				$strings[$row->name] = $row->text;	
			} else {
				$this->db->select('name,text')->from('strings')->where('lang',$default_language)->where('name',$stringitem);	
				$query = $this->db->get();				
				$row = $query->row(); 
				$strings[$row->name] = $row->text; 		
			}
    	}
 		return $strings;
    }

}
