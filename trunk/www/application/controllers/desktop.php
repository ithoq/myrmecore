 <?php
/**
 * MyrmeCore
 *
 * A Web-based Wireless Sensor Network Management System
 *
 * @package         MyrmeCore
 * @author          Juan F. Duque <jfelipe@grupodyd.com>
 * @copyright       Copyright (c) 2011, Dinamica y Desarrollo Ltda.
 * @license         http://www.myrmecore.com/license/
 * @link            http://www.myrmecore.com
 * @since           Version 0.1
 * @filesource
 */

class Desktop extends Controller {

    function Desktop()
    {
        parent::Controller();    
    }
    
    function index()
    {
        $this->load->view('desktop_view');
    }
}

/* End of file desktop.php */
/* Location: ./system/application/controllers/desktop.php */
