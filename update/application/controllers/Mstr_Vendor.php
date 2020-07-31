<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Mstr_Vendor extends CI_Controller {

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
		$data = array('success' => false ,'message'=>array(),'data' => array());

		$id = $this->input->post('id');

		if ($id == '') {
			$rs = $this->ModelsExecuteMaster->FindData(array('isActive'=>1),'tvendor');
		}
		else{
			$rs = $this->ModelsExecuteMaster->FindData(array('isActive'=>1,'KodeVendor'=>$id),'tvendor');
		}

		if ($rs->num_rows()>0) {
			$data['success'] = true;
			$data['data'] = $rs->result();
		}
		else{
			$data['message'] = 'No Record Found';
		}
		echo json_encode($data);
	}
	public function CRUD()
	{
		$data = array('success' => false ,'message'=>array());

		$KodeVendor		= $this->input->post('KodeVendor');
		$NamaVendor		= $this->input->post('NamaVendor');
		$AlamatVendor	= $this->input->post('AlamatVendor');
		$TlpVendor		= $this->input->post('TlpVendor');

		$id = $this->input->post('id');
		$formtype = $this->input->post('formtype');

		$param = array(
			'KodeVendor'	=> $KodeVendor,
			'NamaVendor'	=> $NamaVendor,
			'AlamatVendor'	=> $AlamatVendor,
			'TlpVendor'		=> $TlpVendor
		);
		if ($formtype == 'add') {
			$this->db->trans_begin();
			try {
				$rs = $this->ModelsExecuteMaster->ExecInsert($param,'tvendor');
				if ($rs) {
					$this->db->trans_commit();
					$data['success'] = true;
				}
				else{
					$data['message'] = "Gagal Input Master Item";
					goto jump;
				}
			} catch (Exception $e) {
				jump:
				$this->db->trans_rollback();
				// $data['success'] = false;
				// $data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		elseif ($formtype == 'edit') {
			try {
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('KodeVendor'=> $KodeVendor),'tvendor');
				if ($rs) {
					$data['success'] = true;
				}
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		elseif ($formtype == 'delete') {
			try {
				$rs = $this->ModelsExecuteMaster->ExecUpdate(array('isActive'=>0),array('KodeVendor'=> $KodeVendor),'tvendor');
				if ($rs) {
					$data['success'] = true;
				}
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		else{
			$data['success'] = false;
			$data['message'] = "Invalid Form Type";
		}
		echo json_encode($data);
	}
}
