<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Apps extends CI_Controller {

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
	}
	
	// =========================== BATAS =========================== 
	public function FindData()
	{
		$data = array('success' => false ,'message'=>array(),'data' =>array());

		$where_field = $this->input->post('where_field');
		$where_value = $this->input->post('where_value');
		$table 		 = $this->input->post('table');
		
		if ($where_field == '') {
			$rs = $this->ModelsExecuteMaster->GetData($table);
		}
		else{
			$where = array(
				$where_field => $where_value
			);
			$rs = $this->ModelsExecuteMaster->FindData($where,$table);
		}
		if ($rs){
			$data['success'] = true;
			$data['data'] = $rs->result();
		}
		else{
			$data['success'] = false;
			$data['message'] = 'Gagal Mengambil data';
		}
		echo json_encode($data);
	}
	public function remove()
	{
		$data = array('success' => false ,'message'=>array(),'data' =>array());
		
		$table = $this->input->post('table');
		$field = $this->input->post('field');
		$value = $this->input->post('value');
		
		try {
			$where = array(
				$field	=> $value
			);
			$rs = $this->ModelsExecuteMaster->DeleteData($where,$table);
			$data['success'] = true;
		} catch (Exception $e) {
			$data['success'] = false;
			$data['message'] = "Gagal memproses data ". $e->getMessage();
		}
		echo json_encode($data);
	}

	public function appendTransaksi()
	{
		$data = array('success' => false ,'message'=>array(),'data' =>array());

		$tgltransaksi 	= $this->input->post('tgltransaksi');
		$NoRef 			= $this->input->post('NoRef');
		$Merk 			= $this->input->post('Merk');
		$tipe 			= $this->input->post('tipe');
		$jml 			= $this->input->post('jml');

		$formtype 		= $this->input->post('formtype');
		$id 			= $this->input->post('id');

		if ($formtype == 'add') {
			$param = array(
				'Tanggal'	=> $tgltransaksi,
				'NoRef'		=> $NoRef,
				'Merk'		=> $Merk,
				'Tipe'		=> $tipe,
				'Qty'		=> $jml
			);
			try {
				$rs = $this->ModelsExecuteMaster->ExecInsert($param,'ttransaksi');
				$data['success'] = true;
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		elseif ($formtype == 'edit') {
			$param = array(
				'Tanggal'	=> $tgltransaksi,
				'NoRef'		=> $NoRef,
				'Merk'		=> $Merk,
				'Tipe'		=> $tipe,
				'Qty'		=> $jml
			);
			try {
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('id'=> $id),'ttransaksi');
				$data['success'] = true;
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		else{
			$data['success'] = false;
			$data['message'] = "Invalid Form Type ";
		}
		echo json_encode($data);
	}

	public function addUsers()
	{
		$data = array('success' => false ,'message'=>array(),'data' =>array());

		$Username		= $this->input->post('Username');
		$Password		= $this->input->post('Password');
		// $tipe 			= $this->input->post('tipe');

		$formtype 		= $this->input->post('formtype');
		$id 			= $this->input->post('id');

		if ($formtype == 'add') {
			$param = array(
				'username'	=> $Username,
				'username'	=> $Username,
				'password'	=> $this->encryption->encrypt($Password)
			);
			try {
				$rs = $this->ModelsExecuteMaster->ExecInsert($param,'users');
				$xuser = $this->ModelsExecuteMaster->FindData(array('username'=>$Username),'users');
				if ($xuser->num_rows() > 0) {
					$insert = array(
						'userid' 	=> $xuser->row()->id,
						'roleid'	=> 3,
					);
					$call_x = $this->ModelsExecuteMaster->ExecInsert($insert,'userrole');
					if ($call_x) {
						$data['success'] = true;
					}
				}
				$data['success'] = true;
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		else{
			$param = array(
				'username'	=> $Username,
				'username'	=> $Username,
				'password'	=> $this->encryption->encrypt($Password)
			);
			try {
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('id'=> $id),'ttransaksi');
				$data['success'] = true;
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		json_encode($data);
	}

	public function GetNumeric()
	{
		$data = array('success' => false ,'message'=>array(),'prefix'=>'');

		$table = $this->input->post('table');
		$field = $this->input->post('field');
		$prefix = 0;

		$call = $this->ModelsExecuteMaster->GetMax($table,$field);
		// var_dump($call->result());
		if ($call->row()->$field != NULL) {
			$prefix = substr($call->row()->NoTransaksi, -4)+1;
		}
		else{
			$prefix = 1;
		}
		// echo "string".$prefix;
		$data['success'] = true;
		$data['prefix'] = $prefix;

		echo json_encode($data);
	}
	public function GetPersediaan()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());

		$ItemCode = $this->input->post('ItemCode');

		$SQL = "CALL fn_GetStock('".$ItemCode."')";

		$rs = $this->db->query($SQL);

		if ($rs->num_rows() > 0) {
			$data['data'] = $rs->result();
			$data['success'] = true;
			# code...
		}
		echo json_encode($data);
	}
}