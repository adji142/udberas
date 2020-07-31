<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Laporan extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */
	function __construct()
	{
		parent::__construct();
		$this->load->model('ModelsExecuteMaster');
		$this->load->model('GlobalVar');
		$this->load->model('Apps_mod');
		$this->load->model('LoginMod');
	}
	public function read()
	{
		$data = array('success' => false ,'message'=>array(),'data' => array(),'datadetail'=>array());
		
		$tglawal = $this->input->post('tglawal');
		$tglakhir = $this->input->post('tglakhir');

		$sql = "SELECT 
			a.TglTransaksi,a.NoTransaksi,a.KodeCustomer,c.NamaCustomer,
			b.KodeItem,b.NamaItem,SUM(b.QtyJual) Qty
		FROM penjualanheader a
		LEFT JOIN penjualandetail b on a.RowID = b.HeaderID
		LEFT JOIN tcustomer c on a.KodeCustomer = c.KodeCustomer
		WHERE a.TglTransaksi BETWEEN '".$tglawal."' AND '".$tglakhir."'
		GROUP BY a.TglTransaksi,a.NoTransaksi,a.KodeCustomer,b.KodeItem
				";

		$rs = $this->db->query($sql);

		if ($rs->num_rows()>0) {
			$data['success'] = true;
			$data['data'] = $rs->result();
			$data['datadetail'] = array();
		}
		else{
			$data['message'] = 'No Record Found';
		}
		echo json_encode($data);
	}
}
