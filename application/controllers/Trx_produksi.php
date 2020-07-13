<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Trx_produksi extends CI_Controller {

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

		$sql = "SELECT * FROM hasilproduksi order by TglTransaksi DESC";
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

		// Pemakaian
		$RowID 			= $this->input->post('RowID');
		$NoTransaksi 	= $this->input->post('NoTransaksi');
		$TglTransaksi 	= $this->input->post('TglTransaksi');
		$KodeItemRM 	= $this->input->post('KodeItemRM');
		$NamaItemRM 	= $this->input->post('NamaItemRM');
		$QtyIssue 		= $this->input->post('QtyIssue');
		$Createdby 		= $this->session->userdata('NamaUser');
		$Createdon 		= date("Y-m-d h:i:sa");
		$exploder_KodeItemRM = explode("|",$KodeItemRM);

		// Detail

		$RowID 				= $this->input->post('RowID');
		$PemakaianBahanID 	= $this->input->post('PemakaianBahanID');
		$KodeItemFG 		= $this->input->post('KodeItemFG');
		$QtyFG 				= $this->input->post('QtyFG');

		$exploder_KodeItemFG 	= explode("|",$KodeItemFG);
		// var_dump($exploder_KodeItemFG);

		$id = $this->input->post('id');
		$formtype = $this->input->post('formtype');

		$parampemakaian = array(
			'RowID' 			=> $RowID,
			'NoTransaksi' 		=> $NoTransaksi,
			'TglTransaksi' 		=> $TglTransaksi,
			'KodeItemRM'		=> $KodeItemRM,
			'NamaItemRM'		=> $NamaItemRM,
			'QtyIssue'			=> $QtyIssue,
			'Createdby' 		=> $Createdby,
			'Createdon' 		=> $Createdon
		);
		$this->db->trans_begin();
			try {
				if ($table == 'bahan') {
					$Q_stockbahan = "CALL fn_GetStock('".$KodeItemRM."')";

					$stockbahan = $this->db->query($Q_stockbahan)->row();

					if ($stockbahan->Stock - $QtyIssue > 0) {
						$rsbahan = $this->ModelsExecuteMaster->ExecInsert($parampemakaian,'pemakaianbahan');
						if ($rsbahan) {
							$flagsuccess = true;
						}
						else{
							$data['message'] = "Something wrong with appending data in Issue For Production";
							$flagsuccess = false;
						}
					}
					else{
						$data['message'] = "Qty Pemakaian menyebabkan Stock barang ".$KodeItemRM." menjadi 0 / negative";
 						$flagsuccess = false;
					}
				}
				elseif ($table == 'hasil') {
					$paramhasil = array(
						'RowID'				=> $RowID,
						'PemakaianBahanID'	=> $PemakaianBahanID,
						'NoTransaksi'		=> $NoTransaksi,
						'TglTransaksi'		=> $TglTransaksi,
						'KodeItemFG'		=> $exploder_KodeItemFG[0],
						'NamaItemFG'		=> $exploder_KodeItemFG[1],
						'QtyFG'				=> $QtyFG,
						'Createdon'			=> $Createdon,
						'Createdby'			=> $Createdby
					);
					$rsdetail = $this->ModelsExecuteMaster->ExecInsert($paramhasil,'hasilproduksi');
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
		echo json_encode($data);
	}
}
