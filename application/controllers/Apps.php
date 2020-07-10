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

	public function initialData()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());

		$rs = $this->db->query("
				SELECT 
					CONCAT(DATE_FORMAT(Tanggal,'%b'),'-',YEAR(Tanggal))  Periode,
					SUM(CASE WHEN Tipe = 'KARTUN' THEN Qty else 0 END) KARTUN,
					SUM(CASE WHEN Tipe = 'ABSTRAK' THEN Qty else 0 END) ABSTRAK,
					SUM(CASE WHEN Tipe = 'TROPIKAL' THEN Qty else 0 END) TROPIKAL
				FROM ttransaksi 
				WHERE YEAR(Tanggal) = '2019'
				GROUP BY CONCAT(DATE_FORMAT(Tanggal,'%b'),'-',YEAR(Tanggal))
				ORDER BY MONTH(Tanggal)
			");

		if ($rs){
			$data['success'] = true;
			$data['data']= $rs->result();
		}
		else{
			$data['message']='Gagal Proses Initial Data testing';
		}
		echo json_encode($data);
	}

	public function AddForecast()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());

		$Periode = $this->input->post('Periode');
		$Jenis = $this->input->post('Jenis');
		$Jumlah = $this->input->post('Jumlah');
		$F01 = $this->input->post('F01');
		$F02 = $this->input->post('F02');
		$F03 = $this->input->post('F03');
		$F04 = $this->input->post('F04');
		$F05 = $this->input->post('F05');
		$F06 = $this->input->post('F06');
		$F07 = $this->input->post('F07');
		$F08 = $this->input->post('F08');
		$F09 = $this->input->post('F09');

		$param = array(
			'Periode'	=> $Periode,
			'Jenis'		=> $Jenis,
			'Jumlah'	=> $Jumlah,
			'F01'		=> $F01,
			'F02'		=> $F02,
			'F03'		=> $F03,
			'F04'		=> $F04,
			'F05'		=> $F05,
			'F06'		=> $F06,
			'F07'		=> $F07,
			'F08'		=> $F08,
			'F09'		=> $F09
		);

		try {
			$this->ModelsExecuteMaster->ExecInsert($param,'tforcast');
			$data['success'] = true;
		} catch (Exception $e) {
			$data['success'] = false;
			$data['message'] = "Gagal memproses data ". $e->getMessage();
		}
		echo json_encode($data);
	}
	public function RemoveData()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());
		$Jenis = $this->input->post('Jenis');

		$rs = $this->ModelsExecuteMaster->DeleteData(array('Jenis' => $Jenis),'tforcast');
		$data['success'] = true;

		echo json_encode($data);
	}

	public function ShowDataForcast()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());

		$Jenis = $this->input->post('Jenis');

		$rs = $this->db->query("
				SELECT * FROM tforcast where Jenis = '".$Jenis."' order by id
			");

		if ($rs){
			$data['success'] = true;
			$data['data']= $rs->result();
		}
		else{
			$data['message']='Gagal Proses Initial Data testing';
		}
		echo json_encode($data);
	}
	public function RemoveMae()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());
		$Jenis = $this->input->post('Jenis');

		$rs = $this->ModelsExecuteMaster->DeleteData(array('Jenis' => $Jenis),'tmae');
		$data['success'] = true;

		echo json_encode($data);
	}
	public function AddMae()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());

		$Jenis = $this->input->post('Jenis');
		$F01 = $this->input->post('F01');
		$F02 = $this->input->post('F02');
		$F03 = $this->input->post('F03');
		$F04 = $this->input->post('F04');
		$F05 = $this->input->post('F05');
		$F06 = $this->input->post('F06');
		$F07 = $this->input->post('F07');
		$F08 = $this->input->post('F08');
		$F09 = $this->input->post('F09');

		$param = array(
			'Jenis'		=> $Jenis,
			'F01'		=> $F01,
			'F02'		=> $F02,
			'F03'		=> $F03,
			'F04'		=> $F04,
			'F05'		=> $F05,
			'F06'		=> $F06,
			'F07'		=> $F07,
			'F08'		=> $F08,
			'F09'		=> $F09
		);

		try {
			$this->ModelsExecuteMaster->ExecInsert($param,'tmae');
			$data['success'] = true;
		} catch (Exception $e) {
			$data['success'] = false;
			$data['message'] = "Gagal memproses data ". $e->getMessage();
		}
		echo json_encode($data);
	}
	public function ShowDataMAE()
	{
		$data = array('success' => false ,'message'=>array(),'data'=>array());

		$Jenis = $this->input->post('Jenis');

		$rs = $this->db->query("
				SELECT * FROM tmae where Jenis = '".$Jenis."' order by id
			");

		if ($rs){
			$data['success'] = true;
			$data['data']= $rs->result();
		}
		else{
			$data['message']='Gagal Proses Initial Data testing';
		}
		echo json_encode($data);
	}
}