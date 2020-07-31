<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Transaksi Pembelian</a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5>Pembelian</h5>
			        </div>
			        <div class="widget-content">
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
	        	<div id="title_modal">Tambah Pembelian
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
	    			<label class="control-label">Vendor</label>
	    			<div class="controls">
	    				<input list="listCustomer" name="KodeVendor" id="KodeVendor" class="form-control" autocomplete="off">
	    				<datalist id="listCustomer" >
	    					<?php
	                    		$rs = $this->db->query("select * from tvendor where isActive = 1 order by KodeVendor")->result();
	                    		foreach ($rs as $key) {
	                    			echo "<option value = '".$key->KodeVendor." | ".$key->NamaVendor."'>";
	                    		}
	                    	?>
	    				</datalist>
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

<div class="modal hide" id="ModalItem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
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
              	<th>Row ID</th>
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
<?php
    require_once(APPPATH."views/parts/Footer.php");
?>

<script type="text/javascript">
	$(function () {
        $(document).ready(function () {
        	
        	var where_field = '';
        	var where_value = '';
        	var table = 'users';

	        $.ajax({
	          type: "post",
	          url: "<?=base_url()?>Trx_pembelian/read",
	          data: {'id':''},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
	          	bindGrid_Detail(response.datadetail);
	          }
	        });
	        // NoTrx
	        var table = 'pembelianheader';
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

			    	$('#NoTransaksi').val('2'+year+''+month+''+ans);
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
			var KodeVendor = $('#KodeVendor').val();
			var Status = 1;
			var row = 'header';

			$.ajax({
				type    :'post',
			    url     : '<?=base_url()?>Trx_pembelian/CRUD',
			    data    : {'NoTransaksi' : NoTransaksi,'TglTransaksi':TglTransaksi,'KodeVendor':KodeVendor,'Status':Status,'table':row,'RowID':rowid},
			    dataType: 'json',
			    success:function (response) {
			    	if (response.success == true) {
			    		if (gridItems != '[]') {
			    			row = 'detail';

			    			var KodeItem;
		    				var NamaItem;
		    				var QtyBeli;
		    				var HargaBeli;
		    				var x = 0;
			    			$.each(gridItems,function (k,v) {
			    				var detailid = uuidv4();
			    				console.log(gridItems);
			    				KodeItem = v.ItemCode;
			    				NamaItem = v.ItemName;
			    				QtyBeli = v.QtyBeli;
			    				HargaBeli = v.HargaBeli;

			    				$.ajax({
				    				type    :'post',
								    url     : '<?=base_url()?>Trx_pembelian/CRUD',
								    data    : {'NoTransaksi' : NoTransaksi,'table':row,'KodeItem':KodeItem,'NamaItem':NamaItem,'QtyBeli':QtyBeli,'HargaBeli':HargaBeli,'DetailRowID':detailid,'HeaderID':rowid},
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
		                dataField: "KodeVendor",
		                caption: "Kode Vendor",
		                allowEditing:false
		            },
		            {
		                dataField: "NamaVendor",
		                caption: "Nama Vendor",
		                allowEditing:false
		            }
		            // {
	             //        caption: "Action",
	             //        allowEditing:false,
	             //        cellTemplate: function(cellElement, cellInfo) {
	             //        	var LinkAccess = "";
	             //        	LinkAccess = '<a href="#" id="'+cellInfo.data.NoTransaksi+'" class = "Change" onClick="ChangeStatus('+cellInfo.data.NoTransaksi+')"><span class="date badge badge-important">Update Status</span></a><br>';
		            //         cellElement.append(LinkAccess);
		            //     }
	             //    },
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

			$("#gridContainer_Detail").dxDataGrid({
				allowColumnResizing: true,
		        dataSource: data,
		        keyExpr: "ItemCode",
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
		        columns: [
		            {
		                dataField: "ItemCode",
		                caption: "Kode Item",
		                allowEditing:true
		            },
		            {
		                dataField: "ItemName",
		                caption: "Nama Item",
		                allowEditing:false
		            },
		            {
		                dataField: "QtyBeli",
		                caption: "Qty",
		                allowEditing:true
		            },
		            {
		                dataField: "HargaBeli",
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
							    		grid.cellValue(index, "QtyBeli", 0);
							    		// grid.cellValue(index, "HargaBeli", 0);
							    		grid.cellValue(index, "HargaBeli", response.data[0]["Harga"]);
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
</script>
