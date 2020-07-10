<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Mstr_Item extends CI_Controller {

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
			$rs = $this->ModelsExecuteMaster->FindData(array('isActive'=>1),'titem');
		}
		else{
			$rs = $this->ModelsExecuteMaster->FindData(array('isActive'=>1,'ItemCode'=>$id),'titem');
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

		$ItemCode = $this->input->post('ItemCode');
		$ItemName = $this->input->post('ItemName');
		// $ItemGroup = $this->input->post('ItemGroup');
		$Createdby = $this->session->userdata('NamaUser');
		$Createdon = date("Y-m-d h:i:sa");

		// $exploder = explode("|",$ItemGroup[0]);

		$id = $this->input->post('id');
		$formtype = $this->input->post('formtype');

		$param = array(
			'ItemCode'	=> $ItemCode,
			'ItemName'	=> $ItemName,
			// 'ItemGroup'	=> $ItemGroup,
			'Createdby'	=> $Createdby,
			'Createdon'	=> $Createdon
		);
		if ($formtype == 'add') {
			$this->db->trans_begin();
			try {
				$rs = $this->ModelsExecuteMaster->ExecInsert($param,'titem');
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
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('ItemCode'=> $ItemCode),'titem');
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
				$rs = $this->ModelsExecuteMaster->ExecUpdate(array('isActive'=>0),array('ItemCode'=> $ItemCode),'titem');
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
