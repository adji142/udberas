<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
<input type="hidden" id="access" value="<?php echo $HakAkses; ?>">
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Transaksi <?php echo $HakAkses == 4 ? 'Pembelian' : 'Penjualan'; ?></a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5><?php echo $HakAkses == 4 ? 'Pembelian' : 'Penjualan'; ?></h5>
			        </div>
			        <div class="widget-content">
			        	<div class="widget-content">
			        		<?php
			        			if ($HakAkses == 4) {
			        				echo '<center><h4>Syarat dan Ketentuan Pemesanan</h4></center>
			        		<p>1. Setiap Pembelian dinyatakan Sah setelah Customer Melakukan Pembayaran. </p>
			        		<p>2. Setiap Pembelian akan di proses setelah Customer membayar pesanan.</p>
			        		<p>3. Pembayaran dilayani melalui transfer ke rekening rekening bank berikut</p>
			        		<p>&nbsp &nbsp &nbsp BCA 111.111.1111 AN xxxx</p>
			        		<p>&nbsp &nbsp &nbsp BRI 111.111.1111 AN xxxx</p>
			        		<p>&nbsp &nbsp &nbsp BNI 111.111.1111 AN xxxx</p>
			        		<p>4. Setalah melakukan Pembayaran silahkan melakukan konfirmasi dengan menekan tombol <span class="date badge badge-important">Upload Bukti Pembayaran</span>. dan Upload bukti pembayaran</p>';
			        			}
			        		?>
			        		
			        	</div>
			        	<!-- <button type="button" class="btn btn-mini btn-info" data-toggle="modal" data-target="#modal_">
							  Tambah Pelayan
						</button> -->
						<div class="dx-viewport demo-container">
				        	<div id="data-grid-demo">
				        		<div id="gridContainer">
				        		</div>
				        	</div>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- Modal -->
<div class="modal hide" id="modal_" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog-scrollable" role="document">
  	<div class="modal-content">
  		<div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">
	        	<div id="title_modal">Tambah Penjualan
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
	        	</div>
	        </h5>
	    </div>
	    <div class="modal-body">
	    	<form class="form-horizontal" enctype='application/json' id="post_">
	    		<div class="control-group">
	    			<label class="control-label">Nomer Transaksi</label>
	    			<div class="controls">
	    				<input type="text" name="NoTransaksi" id="NoTransaksi" required="" placeholder="Nomor Transaksi" readonly="" required="" autocomplete="off">
	    				<input type="hidden" name="formtype" id="formtype" value="add">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Tanggal Transaksi</label>
	    			<div class="controls">
	    				<input type="date" name="TglTransaksi" id="TglTransaksi" required="" autocomplete="off">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Customer</label>
	    			<div class="controls">
	    				<?php 
	    					$input = '';
	    					if ($HakAkses == 4) {
	    						$SQL = "select * from tcustomer where isActive = 1 ";
	    						$rsx = $this->ModelsExecuteMaster->FindData(array('username'=>$username),'users');
	    						if ($rsx->row()->HakAkses == 4) {
	    							$SQL .= " AND KodeCustomer = '".$username."' ";
	    						}
	    						$SQL .= " order by KodeCustomer";
	    						$rs = $this->db->query($SQL)->row();

	    						$input = '<input type = "text" name="KodeCustomer" id="KodeCustomer" class="form-control" value = "'.$rs->KodeCustomer." | ".$rs->NamaCustomer.'" >';
	    					}
	    					else{
	    						$SQL = "select * from tcustomer where isActive = 1 ";
	    						$rsx = $this->ModelsExecuteMaster->FindData(array('username'=>$username),'users');
	    						if ($rsx->row()->HakAkses == 4) {
	    							$SQL .= " AND KodeCustomer = '".$username."' ";
	    						}
	    						$SQL .= " order by KodeCustomer";
	    						$rs = $this->db->query($SQL)->result();

	    						$input = '<input list="listCustomer" name="KodeCustomer" id="KodeCustomer" class="form-control" autocomplete="off">
	    							<datalist id="listCustomer" >';
	    						foreach ($rs as $key) {
	                    			$input .= "<option value = '".$key->KodeCustomer." | ".$key->NamaCustomer."'>";
	                    		}
	                    		$input .='</datalist>';
	    					}
	    					echo $input;
	    				?>
	    			</div>
	    		</div>

	            <!-- <div class="control-group">
	    			<label class="control-label">Group Item</label>
	    			<div class="controls">
	    				<select name="tipe" id="tipe">
	    					<option value="1">Penjualan</option>
	    					<option value="2">Bahan Baku</option>
	    				</select>
	    			</div>
	    		</div> -->
	    	</form>
	    	<div id="gridContainer_Detail">
        	
        	</div>
        	<br>
        	<button class="btn btn-primary" id="btn_Save">Save</button>
	    </div>
  	</div>
  </div>
</div>

<div class="modal hide" id="ModalStatus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Ganti Status Transaksi
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </h5>
      </div>
      <div class="modal-body">
        <!-- Input from hire -->
        <input type="hidden" name="NoTransaksi" id="NoTransaksi">
        <div class="control-group">
			<label class="control-label">Status Transaksi</label>
			<div class="controls">
				<select id="listStatus" >
					<option value="1">Ordered</option>
					<option value="2">Di Proses</option>
					<option value="3">Di Kirim</option>
					<option value="4">Selesai</option>
					<option value="5">Cancel</option>
				</select>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="Save_Btn_Status">Save changes</button>
      </div>
    </div>
  </div>
</div>


<div class="modal hide" id="ModalAlat" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><div id="title_modal"></div></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Input from hire -->
        <table class="table table-bordered data-table" id="alat_list">
        	<thead>
              <tr>
              	<th>Kode Item</th>
                <th>Nama Item</th>
              </tr>
            </thead>
            <tbody id="load_data_alat">
              
            </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary" id="Save_Btn">Save changes</button> -->
      </div>
    </div>
  </div>
</div>

<div class="modal hide" id="ModalFoto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><div id="title_modal"></div></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Input from hire -->
        <input type="hidden" id="xNoTransaksi" name="xNoTransaksi">
        <div class="control-group">
            <label class="control-label">Foto</label>
            <div class="controls">
                <input type="file" id="bannerimage" name="bannerimage" />
	              <img src="" id="profile-img-tag" width="200" />
	              <span class="help-block">Max Resolution 800 x 600</span>
	              <textarea id="Image" name="Image" style=""></textarea>
	              <!-- display: none; -->
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="Save_Btn_Bukti">Save changes</button>
      </div>
    </div>
  </div>
</div>

<div class="modal hide" id="ModalShowFoto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><div id="title_modal"></div></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Input from hire -->
        <input type="hidden" id="UpdateNoTransaksi" name="UpdateNoTransaksi">
        <center>
        	<img src="" id="profile-img-tag-view" width="400" />
        	<br>
        	<button type="button" class="btn btn-primary" id="Save_Btn_Konfirm">Konfirmasi</button>
        </center>
      </div>
      <div class="modal-footer">
        
      </div>
    </div>
  </div>
</div>
<?php
    require_once(APPPATH."views/parts/Footer.php");
?>

<script type="text/javascript">
	var _URL = window.URL || window.webkitURL;
	$(function () {
		var items_data;
        $(document).ready(function () {
        	
        	var where_field = '';
        	var where_value = '';
        	var table = 'users';

	        $.ajax({
	          type: "post",
	          url: "<?=base_url()?>Trx_penjualan/read",
	          data: {'id':''},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
	          	bindGrid_Detail(response.datadetail);
	          }
	        });
	        // NoTrx
	        var table = 'penjualanheader';
	    	var field = 'NoTransaksi';
	        var prev = 0;
	    	$.ajax({
		      type    :'post',
		      url     : '<?=base_url()?>Apps/GetNumeric',
		      data    : {table:table,field:field},
		      dataType: 'json',
		      success:function (response) {
		        if(response.success == true){
		        	var str = "" + response.prefix;
					var pad = "0000";
					var ans = pad.substring(0, pad.length - str.length) + str;

					var today = new Date();
					var year = today.getFullYear();
					var month = today.getMonth();

			    	$('#NoTransaksi').val('1'+year+''+month+''+ans);
		        }
		      }
		    });
        });
        $('#Save_Btn_Konfirm').click(function () {
        	// alert($('#listStatus').val());
        	$.ajax({
				type    :'post',
			    url     : '<?=base_url()?>Trx_penjualan/TransactionUpdate',
			    data    : {'NoTransaksi':$('#UpdateNoTransaksi').val(),'Status':2},
			    dataType: 'json',
			    success:function (response) {
			    	if (response.success == true) {
			    		$('#ModalShowFoto').modal('toggle');
			    		Swal.fire({
			              type: 'success',
			              title: 'Horray...',
			              text: 'Status Berhasil Di rubah',
			              // footer: '<a href>Why do I have this issue?</a>'
			            }).then((result)=>{
			              location.reload();
			            });
			    	}
			    	else{
			    		$('#ModalShowFoto').modal('toggle');
				            Swal.fire({
				              type: 'error',
				              title: 'Woops...',
				              text: response.message,
				              // footer: '<a href>Why do I have this issue?</a>'
				            }).then((result)=>{
				            	$('#ModalShowFoto').modal('show');
				            });
			    	}
			    }
			});
        });
        $('#Save_Btn_Bukti').click(function () {
        	$('#Save_Btn_Bukti').text('Tunggu Sebentar.....');
		    $('#Save_Btn_Bukti').attr('disabled',true);

		    $.ajax({
		        type    :'post',
		        url     : '<?=base_url()?>Trx_penjualan/UploadImage',
		        data    : {'NoTransaksi': $('#xNoTransaksi').val(),'BuktiBayar':$('#Image').val()},
		        dataType: 'json',
		        success : function (response) {
		          if(response.success == true){
		            $('#ModalFoto').modal('toggle');
		            Swal.fire({
		              type: 'success',
		              title: 'Horay..',
		              text: 'Data Berhasil disimpan!',
		              // footer: '<a href>Why do I have this issue?</a>'
		            }).then((result)=>{
		              location.reload();
		            });
		          }
		          else{
		            $('#ModalFoto').modal('toggle');
		            Swal.fire({
		              type: 'error',
		              title: 'Woops...',
		              text: response.message,
		              // footer: '<a href>Why do I have this issue?</a>'
		            }).then((result)=>{
		            	$('#ModalFoto').modal('show');
			            $('#Save_Btn_Bukti').text('Save');
			            $('#Save_Btn_Bukti').attr('disabled',false);
		            });
		          }
		        }
		      });
        });
        $('#post_').submit(function (e) {
        	$('#btn_Save').text('Tunggu Sebentar.....');
		    $('#btn_Save').attr('disabled',true);

		    e.preventDefault();
			var me = $(this);

			$.ajax({
		        type    :'post',
		        url     : '<?=base_url()?>Mstr_Item/CRUD',
		        data    : me.serialize(),
		        dataType: 'json',
		        success : function (response) {
		          if(response.success == true){
		            $('#modal_').modal('toggle');
		            Swal.fire({
		              type: 'success',
		              title: 'Horay..',
		              text: 'Data Berhasil disimpan!',
		              // footer: '<a href>Why do I have this issue?</a>'
		            }).then((result)=>{
		              location.reload();
		            });
		          }
		          else{
		            $('#modal_').modal('toggle');
		            Swal.fire({
		              type: 'error',
		              title: 'Woops...',
		              text: response.message,
		              // footer: '<a href>Why do I have this issue?</a>'
		            }).then((result)=>{
		            	$('#modal_').modal('show');
			            $('#btn_Save').text('Save');
			            $('#btn_Save').attr('disabled',false);
		            });
		          }
		        }
		      });
        });
        $('#btn_Save').click(function () {
        	$('#btn_Save').text('Tunggu Sebentar.....');
		    $('#btn_Save').attr('disabled',true);

		    var rowid = uuidv4();

		    var gridItems = $("#gridContainer_Detail").dxDataGrid('instance')._controllers.data._dataSource._items;

		    var NoTransaksi = $('#NoTransaksi').val();
			var TglTransaksi = $('#TglTransaksi').val();
			var KodeCustomer = $('#KodeCustomer').val();
			var Status = 1;
			var row = 'header';

			$.ajax({
				type    :'post',
			    url     : '<?=base_url()?>Trx_penjualan/CRUD',
			    data    : {'NoTransaksi' : NoTransaksi,'TglTransaksi':TglTransaksi,'KodeCustomer':KodeCustomer,'Status':Status,'table':row,'RowID':rowid},
			    dataType: 'json',
			    success:function (response) {
			    	if (response.success == true) {
			    		if (gridItems != '[]') {
			    			row = 'detail';

			    			var KodeItem;
		    				var NamaItem;
		    				var QtyJual;
		    				var HargaJual;
		    				var x = 0;
			    			$.each(gridItems,function (k,v) {
			    				var detailid = uuidv4();
			    				console.log(gridItems);
			    				KodeItem = v.ItemCode;
			    				NamaItem = v.ItemName;
			    				QtyJual = v.QtyJual;
			    				HargaJual = v.HargaJual;

			    				$.ajax({
				    				type    :'post',
								    url     : '<?=base_url()?>Trx_penjualan/CRUD',
								    data    : {'NoTransaksi' : NoTransaksi,'table':row,'KodeItem':KodeItem,'NamaItem':NamaItem,'QtyJual':QtyJual,'HargaJual':HargaJual,'DetailRowID':detailid,'HeaderID':rowid},
								    dataType: 'json',
								    success:function (response) {
								    	if (response.success == true) {
								    		x += 1;
								    		console.log(x + " == " + gridItems.length);
								    		if (x == gridItems.length ) {
								    			$('#modal_').modal('toggle');
								    			Swal.fire({
									              type: 'success',
									              title: 'Horray...',
									              text: 'Data Berhasil Di Tambahkan',
									              // footer: '<a href>Why do I have this issue?</a>'
									            }).then((result)=>{
									              location.reload();
									            });
								    		}
								        	
								    	}
								    	else{
								    		$('#modal_').modal('toggle');
								        	Swal.fire({
								              type: 'error',
								              title: 'Woops...',
								              text: response.message,
								              // footer: '<a href>Why do I have this issue?</a>'
								            }).then((result)=>{
								              $('#modal_').modal('show');
								            });
								    	}
								    }
				    			});
			    			});
			    		}
			    		else{
			    			$('#modal_').modal('toggle');
				        	Swal.fire({
				              type: 'error',
				              title: 'Woops...',
				              text: response.message,
				              // footer: '<a href>Why do I have this issue?</a>'
				            }).then((result)=>{
				              $('#modal_').modal('show');
				            });
			    		}
			    	}
			    	else{
			    		$('#modal_').modal('toggle');
			        	Swal.fire({
			              type: 'error',
			              title: 'Woops...',
			              text: response.message,
			              // footer: '<a href>Why do I have this issue?</a>'
			            }).then((result)=>{
			              $('#modal_').modal('show');
			            });
			    	}
			    }
			});

        });
        $('.close').click(function() {
        	location.reload();
        });
        $('#ItemCode').focusout(function () {
			$.ajax({
	          type: "post",
	          url: "<?=base_url()?>Mstr_Item/read",
	          data: {'ItemCode':$('#ItemCode').val()},
	          dataType: "json",
	          success: function (response) {
          		$.each(response.data,function (k,v) {
          			console.log(v.KelompokUsaha);
		            $('#ItemCode').val(v.ItemCode);
					$('#ItemName').val(v.ItemName);

					$('#formtype').val("edit");
		          });
	          }
	        });
        });
        $('#Save_Btn_Status').click(function () {
        	// alert($('#listStatus').val());
        	$.ajax({
				type    :'post',
			    url     : '<?=base_url()?>Trx_penjualan/TransactionUpdate',
			    data    : {'NoTransaksi':$('#NoTransaksi').val(),'Status':$('#listStatus').val()},
			    dataType: 'json',
			    success:function (response) {
			    	if (response.success == true) {
			    		$('#ModalStatus').modal('toggle');
			    		Swal.fire({
			              type: 'success',
			              title: 'Horray...',
			              text: 'Status Berhasil Di rubah',
			              // footer: '<a href>Why do I have this issue?</a>'
			            }).then((result)=>{
			              location.reload();
			            });
			    	}
			    	else{
			    		$('#ModalStatus').modal('toggle');
				            Swal.fire({
				              type: 'error',
				              title: 'Woops...',
				              text: response.message,
				              // footer: '<a href>Why do I have this issue?</a>'
				            }).then((result)=>{
				            	$('#ModalStatus').modal('show');
				            });
			    	}
			    }
			});
        });
        $('#alat_list').on('click','tr',function () {
        	// ItemCode,ItemName,QtyJual,HargaJual
			return_IDData = 1;
			var kd = $(this).find("#xKodeItem").text();
			var nm = $(this).find("#xNamaItem").text();
			var hrg = $(this).find("#xHarga").text();
			var row = $(this).find("#xRowID").text();
			items_data.push({
					id 			: row,
	                ItemCode  	: kd,
	                ItemName  	: nm,
	                QtyJual 	: 1,
	                HargaJual	: hrg
			});
			// console.log(items_data);

			bindGrid_Detail(items_data)
			$('#ModalAlat').modal('toggle');
		});
		$("#bannerimage").change(function(){
		      var file = $(this)[0].files[0];
		      img = new Image();
		      img.src = _URL.createObjectURL(file);
		      var imgwidth = 0;
		      var imgheight = 0;
		      img.onload = function () {
		        imgwidth = this.width;
		        imgheight = this.height;
		        $('#width').val(imgwidth);
		        $('#height').val(imgheight);
		      }
		      readURL(this);
		      encodeImagetoBase64(this);
		      // alert("Current width=" + imgwidth + ", " + "Original height=" + imgheight);
		    });
		function GetData(id) {
			var where_field = 'id';
        	var where_value = id;
        	var table = 'users';
			$.ajax({
	          type: "post",
	          url: "<?=base_url()?>Mstr_Item/read",
	          data: {'ItemCode':id},
	          dataType: "json",
	          success: function (response) {
          		$.each(response.data,function (k,v) {
          			console.log(v.KelompokUsaha);
		            $('#ItemCode').val(v.ItemCode);
					$('#ItemName').val(v.ItemName);

					$('#formtype').val("edit");

					$('#modal_').modal('show');
		          });
	          }
	        });
		}
		function bindGrid(data) {

			$("#gridContainer").dxDataGrid({
				allowColumnResizing: true,
		        dataSource: data,
		        keyExpr: "NoTransaksi",
		        showBorders: true,
		        allowColumnReordering: true,
		        allowColumnResizing: true,
		        columnAutoWidth: true,
		        showBorders: true,
		        paging: {
		            enabled: false
		        },
		        editing: {
		            mode: "row",
		            allowAdding:true,
		            // allowUpdating: true,
		            // allowDeleting: true,
		            texts: {
		                confirmDeleteMessage: ''  
		            }
		        },
		        searchPanel: {
		            visible: true,
		            width: 240,
		            placeholder: "Search..."
		        },
		        export: {
		            enabled: true,
		            fileName: "Daftar Pelayan"
		        },
		        columns: [
		            {
		                dataField: "NoTransaksi",
		                caption: "No. Transaksi",
		                allowEditing:false
		            },
		            {
		                dataField: "TglTransaksi",
		                caption: "Tgl. Transaksi",
		                allowEditing:false
		            },
		            {
		                dataField: "KodeCustomer",
		                caption: "Kode Customer",
		                allowEditing:false
		            },
		            {
		                dataField: "NamaCustomer",
		                caption: "Nama Customer",
		                allowEditing:false
		            },
		            {
		            	dataField : "DescStatus",
		            	caption : "Status Transaksi",
		            	allowEditing : false
		            },
		            {
	                    caption: "Action",
	                    allowEditing:false,
	                    cellTemplate: function(cellElement, cellInfo) {
	                    	var LinkAccess = "";
	                    	if ($('#access').val() != 4) {
	                    		LinkAccess = '<a href="#" id="'+cellInfo.data.NoTransaksi+'" class = "Change" onClick="ChangeStatus('+cellInfo.data.NoTransaksi+')"><span class="date badge badge-important">Update Status</span></a><br>';
	                    		if (cellInfo.data.DescStatus != "Di Proses") {
	                    			LinkAccess += '<a href="#" id="'+cellInfo.data.NoTransaksi+'" class = "Change" onClick="UploadBukti('+cellInfo.data.NoTransaksi+')"><span class="date badge badge-important">Lihat Bukti Pembayaran</span></a><br>';
	                    		}
	                    		
	                    	}
	                    	if ($('#access').val() == 4) {
	                    		LinkAccess = '<a href="#" id="'+cellInfo.data.NoTransaksi+'" class = "Change" onClick="UploadBukti('+cellInfo.data.NoTransaksi+')"><span class="date badge badge-important">Upload Bukti Pembayaran</span></a><br>';

	                    		// LinkAccess = '<a href="#" id="'+cellInfo.data.NoTransaksi+'" class = "Change" onClick="UploadBukti('+cellInfo.data.NoTransaksi+')"><span class="date badge badge-important">Upload Bukti Pembayaran</span></a><br>';
	                    	}
		                    cellElement.append(LinkAccess);
		                }
	                },
		        ],
		        onEditingStart: function(e) {
		            GetData(e.data.ItemCode);
		        },
		        onInitNewRow: function(e) {
		            // logEvent("InitNewRow");
		            $('#modal_').modal('show');
		        },
		        onRowInserting: function(e) {
		            // logEvent("RowInserting");
		        },
		        onRowInserted: function(e) {
		            // logEvent("RowInserted");
		            // alert('');
		            // console.log(e.data.onhand);
		            // var index = e.row.rowIndex;
		        },
		        onRowUpdating: function(e) {
		            // logEvent("RowUpdating");
		            
		        },
		        onRowUpdated: function(e) {
		            // logEvent(e);
		        },
		        onRowRemoving: function(e) {
		        	id = e.data.ItemCode;
		        	Swal.fire({
					  title: 'Apakah anda yakin?',
					  text: "anda akan menghapus data di baris ini !",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: 'Yes, delete it!'
					}).then((result) => {
					  if (result.value) {
					  	var table = 'app_setting';
					  	var field = 'id';
					  	var value = id;

					  	$.ajax({
					        type    :'post',
					        url     : '<?=base_url()?>Mstr_Item/CRUD',
					        data    : {'ItemCode':id,'formtype':'delete'},
					        dataType: 'json',
					        success : function (response) {
					          if(response.success == true){
					            Swal.fire(
							      'Deleted!',
							      'Your file has been deleted.',
							      'success'
							    ).then((result)=>{
					              location.reload();
					            });
					          }
					          else{
					            Swal.fire({
					              type: 'error',
					              title: 'Woops...',
					              text: response.message,
					              // footer: '<a href>Why do I have this issue?</a>'
					            }).then((result)=>{
					            	location.reload();
					            });
					          }
					        }
					      });
					    
					  }
					  else{
					  	location.reload();
					  }
					})
		        },
		        onRowRemoved: function(e) {
		        	// console.log(e);
		        },
				onEditorPrepared: function (e) {
					// console.log(e);

				}
		    });

		    // add dx-toolbar-after
		    // $('.dx-toolbar-after').append('Tambah Alat untuk di pinjam ');
		}

		function bindGrid_Detail(data) {
			var kodeenable = true;
			var namaenable = true;

			if ($('#access').val() == 4) {
				kodeenable = false;
			}
			else{
				namaenable = false;
			}

			$("#gridContainer_Detail").dxDataGrid({
				allowColumnResizing: true,
		        dataSource: data,
		        keyExpr: "id",
		        showBorders: true,
		        allowColumnReordering: true,
		        allowColumnResizing: true,
		        columnAutoWidth: true,
		        showBorders: true,
		        paging: {
		            enabled: false
		        },
		        editing: {
		            mode: "row",
		            allowAdding:true,
		            allowUpdating: true,
		            allowDeleting: true,
		            texts: {
		                confirmDeleteMessage: ''  
		            }
		        },
		        // ItemCode,ItemName,QtyJual,HargaJual
		        columns: [
		            {
		                dataField: "ItemCode",
		                caption: "Kode Item",
		                allowEditing:kodeenable
		            },
		            {
		                dataField: "ItemName",
		                caption: "Nama Item",
		                allowEditing:namaenable
		            },
		            {
		                dataField: "QtyJual",
		                caption: "Qty",
		                allowEditing:true
		            },
		            {
		                dataField: "HargaJual",
		                caption: "Harga",
		                allowEditing:true
		            },
		        ],
		        onEditingStart: function(e) {
		            GetData(e.data.ItemCode);
		        },
		        onInitNewRow: function(e) {
		            // logEvent("InitNewRow");
		            $('#modal_').modal('show');
		        },
		        onRowInserting: function(e) {
		            // logEvent("RowInserting");
		        },
		        onRowInserted: function(e) {
		            // logEvent("RowInserted");
		            // alert('');
		            // console.log(e.data.onhand);
		            // var index = e.row.rowIndex;
		        },
		        onRowUpdating: function(e) {
		            // logEvent("RowUpdating");
		            
		        },
		        onRowUpdated: function(e) {
		            // logEvent(e);
		        },
		        onRowRemoving: function(e) {
		        },
		        onRowRemoved: function(e) {
		        	// console.log(e);
		        },
				onEditorPrepared: function (e) {
					// console.log(e);
					if (e.dataField == "ItemCode") {
						$(e.editorElement).dxTextBox("instance").on("valueChanged", function (args) { 

							var grid = $("#gridContainer_Detail").dxDataGrid("instance");
							var index = e.row.rowIndex;
							var result = "new description ";

							var kode = args.value;
							$.ajax({
								type    :'post',
							    url     : '<?=base_url()?>Mstr_Item/read',
							    data    : {'ItemCode':kode},
							    dataType: 'json',
							    success:function (response) {
							    	if (response.data.length > 0) {
							    		grid.cellValue(index, "ItemCode", response.data[0]["ItemCode"]);
							    		grid.cellValue(index, "ItemName", response.data[0]["ItemName"]);
							    		grid.cellValue(index, "QtyJual", 0);
							    		// grid.cellValue(index, "HargaJual", 0);
							    		grid.cellValue(index, "HargaJual", response.data[0]["Harga"]);
							    		// console.log(response.data[0][]);
							    	}
							    	else{
							    		$('#modal_').modal('toggle');
								            Swal.fire({
								              type: 'error',
								              title: 'Woops...',
								              text: response.message,
								              // footer: '<a href>Why do I have this issue?</a>'
								            }).then((result)=>{
								            	$('#modal_').modal('show');
								            });
							    	}
							    }
							});
						});
					}

					else if (e.dataField == "ItemName" && $('#access').val() == 4) {
						$(e.editorElement).dxTextBox("instance").on("valueChanged", function (args) { 

							var grid = $("#gridContainer_Detail").dxDataGrid("instance");
							var index = e.row.rowIndex;
							var result = "new description ";

							var kode = args.value;
							$.ajax({
								type    :'post',
							    url     : '<?=base_url()?>Mstr_Item/read',
							    data    : {'ItemCode':'','kriteria':kode},
							    dataType: 'json',
							    success:function (response) {
							    	if (response.data.length == 1) {
							    		grid.cellValue(index, "ItemCode", response.data[0]["ItemCode"]);
							    		grid.cellValue(index, "ItemName", response.data[0]["ItemName"]);
							    		grid.cellValue(index, "QtyJual", 0);
							    		// grid.cellValue(index, "HargaJual", 0);
							    		grid.cellValue(index, "HargaJual", response.data[0]["Harga"]);
							    		// console.log(response.data[0][]);
							    	}
							    	else{
							    		var html = '';
								        var i;
								        var j = 1;
								        for (i = 0; i < response.data.length; i++) {
								          html += '<tr>' +
								          		  '<td id = "xRowID">' + response.data[i].id + '</td>' +
								                  '<td id = "xKodeItem">' + response.data[i].ItemCode + '</td>' +
								                  '<td id = "xNamaItem">' + response.data[i].ItemName + '</td>' +
								                  '<td id = "xHarga">' + response.data[i].Harga + '</td>' +
								                  '<tr>';
								           j++;
								        }
								        $('#load_data_alat').html(html);
								        items_data = $("#gridContainer").dxDataGrid('instance')._controllers.data._dataSource._items;
								        console.log(items_data);
								        $('#ModalAlat').modal('show');
							    	}
							    }
							});
						});
					}
				}
		    });

		    // add dx-toolbar-after
		    // $('.dx-toolbar-after').append('Tambah Alat untuk di pinjam ');
		}
		function uuidv4() {
		  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		    return v.toString(16);
		  });
		}
	});
	function ChangeStatus(NoTransaksi) {
		// ModalStatus
		$("#NoTransaksi").val(NoTransaksi);
		$('#ModalStatus').modal('show');
	}
	function UploadBukti(NoTransaksi) {
		$('#xNoTransaksi').val(NoTransaksi);
		$('#UpdateNoTransaksi').val(NoTransaksi);
		$.ajax({
	        type    :'post',
	        url     : '<?=base_url()?>Trx_penjualan/ShowImage',
	        data    : {'NoTransaksi':NoTransaksi},
	        dataType: 'json',
	        success : function (response) {
	        	console.log(response.data[0]['BuktiBayar']);
	        	if (response.success == true) {
	        		// profile-img-tag
	        		if ($('#access').val() == 4) {
	        			$("#profile-img-tag").attr("src",response.data[0]['BuktiBayar']);
	        		}
	        		else{
	        			$("#profile-img-tag-view").attr("src",response.data[0]['BuktiBayar']);
	        		}
	        	}
	        }
	    });
	    if ($('#access').val() == 4) {
	    	$('#ModalFoto').modal('show');
	    }
	    else{
	    	$('#ModalShowFoto').modal('show');
	    }
	    // $('#ModalFoto').modal('show');
	}
    function readURL(input) {
	    if (input.files && input.files[0]) {
	      var reader = new FileReader();
	        
	      reader.onload = function (e) {
	          $('#profile-img-tag').attr('src', e.target.result);
	      }
	      reader.readAsDataURL(input.files[0]);
	    }
	}
	function encodeImagetoBase64(element) {
	    $('#Image').val('');
	    var file = element.files[0];
	    var reader = new FileReader();
	    reader.onloadend = function() {
	        // $(".link").attr("href",reader.result);
	        // $(".link").text(reader.result);
	    	$('#Image').val(reader.result);
	    }
	    reader.readAsDataURL(file);
	}
</script>
