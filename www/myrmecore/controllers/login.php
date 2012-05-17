<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Login handles login & authentication
 *
 * @category   General 
 * @package    Authentication
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Login extends Public_Controller
{	  
    function __construct()
    {
        parent::__construct();
        $this->load->model('Strings_model');
    }  	
	
    public function index()
    {
		$this->load->helper('url');
		redirect(base_url(), 'refresh');
    }
    
    // User Authentication, or login
    public function auth()
    {
		if (!$this->session->userdata('ID'))
		{
			$this->load->model('Users_model', '', TRUE);
			
			$data = array();
			if ($this->input->post('username'))
			{ 
				$credentials['username'] = $this->input->post('username'); 
				
				if ($this->input->post('password'))
				{ 
					$credentials['password'] = $this->input->post('password');  
					
					$data = $this->Users_model->authenticate($credentials);								
				} else {
					$data['result'] = 'FAILED';
					$data['cause'] = 'EMPTY_PASSWORD'; 	
					$data['message'] = $this->Strings_model->translate($data['cause'],NULL);		
				}                        
			} else {
				$data['result'] = 'FAILED';
				$data['cause'] = 'EMPTY_USERNAME'; 	
				$data['message'] = $this->Strings_model->translate($data['cause'],NULL);		
			}
			
			if ($data['result'] == 'SUCCESS') {
				$userdata = $data['user'];
				$this->session->set_userdata($userdata);
			} else {
				$this->session->sess_destroy();
			} 
		} else {
			$data['result'] = 'SUCCESS';
			$data['warning'] = 'ALREADY_AUTHENTICATED';		
			$data['message'] = $this->Strings_model->translate($data['warning'],NULL);	
		}
		$this->output->set_header('Cache-Control: no-store, no-cache, must-revalidate');
		$this->output->set_header('Cache-Control: post-check=0, pre-check=0');
		$this->output->set_header('Pragma: no-cache');
		$this->output->set_content_type('application/json')->set_output(json_encode($data));		
    }
    
    // User De-Authentication, or logout
    public function deauth()
    {
		$data = array();
		if ($this->session->userdata('ID'))
		{
			if ($this->session->userdata('Key'))
			{
				$this->load->model('API_Keys_model', '', TRUE);
				$deleted_keys = $this->API_Keys_model->destroy($this->session->userdata('Key'));
				if ($deleted_keys > 0)
				{
					$this->session->sess_destroy();
					$data['result'] = 'SUCCESS';
				} else {
					$this->session->sess_destroy();
					$data['result'] = 'SUCCESS';
					$data['warning'] = 'KEY_NOT_FOUND';
				}					
			}			
		} else {
			$data['result'] = 'FAILED';
			$data['cause'] = 'AUTHENTICATION_REQUIRED'; 
			$data['message'] = $this->Strings_model->translate($data['cause'],NULL);
		}
		
		$this->output->set_header('Cache-Control: no-store, no-cache, must-revalidate');
		$this->output->set_header('Cache-Control: post-check=0, pre-check=0');
		$this->output->set_header('Pragma: no-cache');
		$this->output->set_content_type('application/json')->set_output(json_encode($data));					
	}
	  
    // Get translated text strings
    public function getStrings()
    {
		$this->load->model('Settings_model', '', TRUE);
		$this->load->model('Strings_model', '', TRUE);
		$language = $this->Settings_model->getValue('default_language');
		$stringSet = $this->uri->segment(1);
		
		$strings = $this->Strings_model->getStringSet($stringSet,$language);
		
		$this->output->set_content_type('application/json')->set_output(json_encode($strings));
	}
    
    // Get latest public news
    public function news()
    {
		$this->load->model('News_model', '', TRUE);
		$this->load->model('Settings_model', '', TRUE);
		$number = $this->Settings_model->getValue('number_news');
		$news = $this->News_model->getLatestNews('PUBLIC','SYSTEM',$number);
		$this->output->set_content_type('application/json')->set_output(json_encode($news));
	}
}

/* End of file login.php */
/* Location: ./turnstat/controllers/login.php */
