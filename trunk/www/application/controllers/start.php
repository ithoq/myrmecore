<?php

class Start extends Controller {

	function Start()
	{
		parent::Controller();	
	}
	
	function index()
	{
		$this->load->view('start_message');
	}
}

/* End of file start.php */
/* Location: ./system/application/controllers/start.php */
