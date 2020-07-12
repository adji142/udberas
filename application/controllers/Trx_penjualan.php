<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Trx_penjualan extends CI_Controller {

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

		$sql = "SELECT 
					a.*,b.NamaCustomer,
					CASE WHEN a.`Status` = 1 THEN 'Ordered' ELSE
						CASE WHEN a.`Status` = 2 THEN 'Di Proses' ELSE 
							CASE WHEN a.`Status` = 3 THEN 'Di Kirim' ELSE 
								CASE WHEN a.`Status` = 4 THEN 'Selesai' ELSE 
									CASE WHEN a.`Status` = 5 THEN 'Cancel' ELSE 'Unknown' END
								END
							END
						END
					END DescStatus
				FROM penjualanheader a 
				LEFT JOIN tcustomer b on a.KodeCustomer = b.KodeCustomer
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
	public function CRUD()
	{
		$flagsuccess = false;
		$data = array('success' => false ,'message'=>array());

		$table = $this->input->post('table');

		// HeaderSide
		$RowID 			= $this->input->post('RowID');
		$NoTransaksi	= $this->input->post('NoTransaksi');
		$TglTransaksi	= $this->input->post('TglTransaksi');
		$KodeCustomer	= $this->input->post('KodeCustomer');
		$CustomerSource	= 1;//$this->input->post('CustomerSource');
		$printed		= 0;
		$Status			= $this->input->post('Status');

		// Detail
		$DetailRowID 	= $this->input->post('DetailRowID');
		$HeaderID 		= $this->input->post('HeaderID');
		$KodeItem 		= $this->input->post('KodeItem');
		$NamaItem 		= $this->input->post('NamaItem');
		$QtyJual 		= $this->input->post('QtyJual');
		$HargaJual 		= $this->input->post('HargaJual');

		$Createdby = $this->session->userdata('NamaUser');
		$Createdon = date("Y-m-d h:i:sa");
		$exploder_Customer = explode("|",$KodeCustomer);

		$id = $this->input->post('id');
		$formtype = $this->input->post('formtype');

		$paramheader = array(
			'RowID' 			=> $RowID,
			'NoTransaksi' 		=> $NoTransaksi,
			'TglTransaksi' 		=> $TglTransaksi,
			'KodeCustomer' 		=> $exploder_Customer[0],
			'CustomerSource' 	=> $CustomerSource,
			'printed' 			=> $printed,
			'Status' 			=> 1,
			'Createdby' 		=> $Createdby,
			'Createdon' 		=> $Createdon
		);

		$paramDetail = array(
			'RowID' 			=> $DetailRowID,
			'HeaderID' 			=> $HeaderID,
			'KodeItem' 			=> $KodeItem,
			'NamaItem' 			=> $NamaItem,
			'QtyJual' 			=> $QtyJual,
			'HargaJual' 		=> $HargaJual,
			'Createdby' 		=> $Createdby,
			'Createdon' 		=> $Createdon
		);
		$this->db->trans_begin();
			try {
				if ($table == 'header') {
					$rsheader = $this->ModelsExecuteMaster->ExecInsert($paramheader,'penjualanheader');
					if ($rsheader) {
						$flagsuccess = true;
					}
					else{
						$data['message'] = "Something wrong with appending data in Header Table";
						$flagsuccess = false;
					}
				}
				elseif ($table == 'detail') {
					$rsdetail = $this->ModelsExecuteMaster->ExecInsert($paramDetail,'penjualandetail');
					if ($rsdetail) {
						$flagsuccess = true;
					}
					else{
						$flagsuccess = false;
						$data['message'] = "Something wrong with appending data in Detail Table";
					}
				}
				else{
					$flagsuccess = false;
					$data['message'] = "Something wrong with Table Type";
				}
				// Clearing

				if ($flagsuccess) {
					$this->db->trans_commit();
					$data['success'] = true;
				}
				else{
					goto jump;
				}
			} catch (Exception $e) {
				jump:
				$this->db->trans_rollback();
				// $data['success'] = false;
				// $data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		// if ($formtype == 'add') {
			
		// }
		// elseif ($formtype == 'edit') {
		// 	try {
		// 		$rs = $this->ModelsExecuteMaster->ExecUpdate(array('Status'=>$Status),'penjualanheader');
		// 		if ($rs) {
		// 			$data['success'] = true;
		// 		}
		// 	} catch (Exception $e) {
		// 		$data['success'] = false;
		// 		$data['message'] = "Gagal memproses data ". $e->getMessage();
		// 	}
		// }
		// elseif ($formtype == 'delete') {
		// 	try {
		// 		$rs = $this->ModelsExecuteMaster->ExecUpdate(array('isActive'=>0),array('id'=> $id),'tcustomer');
		// 		if ($rs) {
		// 			$data['success'] = true;
		// 		}
		// 	} catch (Exception $e) {
		// 		$data['success'] = false;
		// 		$data['message'] = "Gagal memproses data ". $e->getMessage();
		// 	}
		// }
		// else{
		// 	$data['success'] = false;
		// 	$data['message'] = "Invalid Form Type";
		// }
		echo json_encode($data);
	}
	public function TransactionUpdate()
	{
		$data = array('success' => false ,'message'=>array());

		$saved = false;

		$NoTransaksi = $this->input->post('	NoTransaksi');
		$Status = $this->input->post('Status');

		$StatusX = "";
		switch ($Status) {
			case '1':
				$StatusX = "Ordered";
				break;
			case '2':
				$StatusX = "Di Proses";
				break;
			case '3':
				$StatusX = "Di Kirim";
				break;
			case '4':
				$StatusX = "Selesai";
				break;
			case '5':
				$StatusX = "Cancel";
				break;
			default:
				$StatusX = "";
				break;
		}

		$param = array(
			'NoTransaksi'		=> $NoTransaksi,
			'TanggalPencatatan'	=> Date("Y-m-d h:i:sa"),
			'Status'			=> $StatusX
		);

		$x = $this->ModelsExecuteMaster->FindData(array('NoTransaksi'=>$NoTransaksi),'penjualanheader');

		if ($x->row()->Status != $Status) {
			try {
				$this->db->trans_begin();
				$rs = $this->ModelsExecuteMaster->ExecInsert($param,'transactionStatus');
				if ($rs) {
					$update = $this->ModelsExecuteMaster->ExecUpdate(array('Status'=>$Status),array('NoTransaksi'=>$NoTransaksi),'penjualanheader');
					if ($update) {
						$saved = true;
					}
					else{
						$saved = false;
						$data['message'] = "Gagal Update Status";
					}
				}
				else{
					$saved = false;
					$data['message'] = "Gagal insert Loging";
				}

				if ($saved) {
					$this->db->trans_commit();
					$data['success'] = true;
				}
				else{
					goto jump;
				}
			} catch (Exception $e) {
				jump:
				$this->db->trans_rollback();
			}
		}
		else{
			$data['message'] = "Sudah Terupdate";
		}
		echo json_encode($data);
	}
}
