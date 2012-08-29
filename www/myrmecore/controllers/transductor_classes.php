<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Transductor add, edit & processing
 *
 * @category   General 
 * @package    Transductor Classes
 * @author     Juan F. Duque G. <jfelipe@grupodyd.com>
 * @author     Andrés M. Eusse T. <aeusse@grupodyd.com>
 * @copyright  2012 DyD Dinámica y Desarrollo Ltda.
 * @license    http://www.myrmecore.com/license
 * @version    Release: 1.0
 * @since      1.0
 */

class Transductor_Classes extends Base_Controller
{ 
    function __construct()
    {
        parent::__construct();
        $this->load->model('Transductor_class_model');
    }	
	
	function list_get()
	{
		if ($this->session->userdata('ID')) {	
			$result = array();
			$transductor_classes = $this->Transductor_class_model->getAll();
			$this->response($transductor_classes, 200);
		} else {
			$this->response(NULL, 403);	
		}		
	}
}
