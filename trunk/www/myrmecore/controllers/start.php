<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Start manages initial asset delivery to the client and create login screen
 *
 * @category   General 
 * @package    Public
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Start extends Public_Controller
{
    public function index()
    {
		$this->load->model('Settings_model', '', TRUE);        
        $data['title'] = $this->Settings_model->getValue('title');
        $this->output->set_header('Cache-Control: max-age=3600');
        $this->load->view('theme', $data);
    }
}

/* End of file start.php */
/* Location: ./turnstat/controllers/start.php */
