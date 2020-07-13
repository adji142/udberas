<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Transaksi Produksi</a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5>Produksi</h5>
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
	        	<div id="title_modal">Tambah Produksi
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
	    			<label class="control-label">Item Hasil Produksi</label>
	    			<div class="controls">
	    				<input list="listItem" name="KodeItemFG" id="KodeItemFG" class="form-control" autocomplete="off">
	    				<datalist id="listItem" >
	    					<?php
	                    		$rs = $this->db->query("select * from titem where isActive = 1 order by ItemCode")->result();
	                    		foreach ($rs as $key) {
	                    			echo "<option value = '".$key->ItemCode." | ".$key->ItemName."'>";
	                    		}
	                    	?>
	    				</datalist>
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Qty Hasil</label>
	    			<div class="controls">
	    				<input type="number" name="QtyFG" id="QtyFG" required="" autocomplete="off">
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
	    	<br>
	    	<h3><center>Pemakaian Bahan</center></h3>
	    	<h4><div id="error_alert"></div></h4>
	    	<div id="gridContainer_Detail">
        	
        	</div>
        	<br>
        	<button class="btn btn-primary" id="btn_Save">Save</button>
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
	          url: "<?=base_url()?>Trx_produksi/read",
	          data: {'id':''},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
	          	bindGrid_Detail(response.datadetail);
	          }
	        });
	        // NoTrx
	        var table = 'hasilproduksi';
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

			    	$('#NoTransaksi').val('3'+year+''+month+''+ans);
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

			var KodeItemFG = $('#KodeItemFG').val();
			var QtyFG = $('#QtyFG').val();

			var Status = 1;
			var row = 'bahan';
			var x = 0;

			var KodeItem;
			var NamaItem;
			var QtyJual;
			if (gridItems!= '[]') {
				$.each(gridItems,function (k,v) {
					var bahanid = uuidv4();
					if (row == 'bahan') {
						$.ajax({
							async:false,
							type: "post",
					        url: "<?=base_url()?>Trx_produksi/CRUD",
					        data: {'RowID':bahanid,NoTransaksi:$('#NoTransaksi').val(),'TglTransaksi':$('#TglTransaksi').val(),'KodeItemRM':v.KodeItemRM,'NamaItemRM':v.NamaItemRM,'QtyIssue':v.QtyIssue,'table':row},
					        dataType: "json",
					        success: function (response) {
					        	if (response.success==true) {
					        		x += 1;
						        	if (x == gridItems.length) {
						        		row = 'hasil';
						        		$.ajax({
						        			async:false,
						        			type: "post",
									        url: "<?=base_url()?>Trx_produksi/CRUD",
									        data: {'RowID':rowid,NoTransaksi:$('#NoTransaksi').val(),'TglTransaksi':$('#TglTransaksi').val(),'KodeItemFG':$('#KodeItemFG').val(),'QtyFG':$('#QtyFG').val(),'table':row},
									        dataType: "json",
									        success: function (response2) {
									        	if (response2.success == true) {
									        		$('#modal_').modal('toggle');
										    		Swal.fire({
										              type: 'success',
										              title: 'Horray...',
										              text: 'Status Berhasil Di simpan',
										              // footer: '<a href>Why do I have this issue?</a>'
										            }).then((result)=>{
										              location.reload();
										            });

									        	}
									        	else{
									        		// error_alert
									        		$('#error_alert').html("Error!!. "+response2.message+"");
									        		$('#btn_Save').text('Simpan');
		   											$('#btn_Save').attr('disabled',false);
									       //  		$('#modal_').modal('toggle');
										    		// Swal.fire({
										      //         type: 'success',
										      //         title: 'Horray...',
										      //         text: response2.message,
										      //         onOpen: function () {
										      //         	console.log("open");
										      //         	return true;
										      //         }
										      //         // footer: '<a href>Why do I have this issue?</a>'
										      //       }).then((result)=>{
										      //         $('#modal_').modal('show');
										      //         $('#btn_Save').text('Simpan');
		   											//   $('#btn_Save').attr('disabled',false);
										      //       });
										            // return true;
											        
									        	}
									        }
						        		});
						        	}
					        	}
					        	else{
					        		$('#error_alert').html("Error!!. "+response.message+"");
					        		$('#btn_Save').text('Simpan');
		   							$('#btn_Save').attr('disabled',false);
					      //   		$('#modal_').modal('toggle');
						    	// 	Swal.fire({
						     //          type: 'success',
						     //          title: 'Horray...',
						     //          text: response.message,
						     //          // footer: '<a href>Why do I have this issue?</a>'
						     //        }).then((result)=>{
						     //          $('#modal_').modal('show');
						     //          $('#btn_Save').text('Simpan');
									  // $('#btn_Save').attr('disabled',false);
						     //        });
						     //        return true;
					        	}
					        }
						});
					}
				});
			}
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
			    url     : '<?=base_url()?>Trx_produksi/TransactionUpdate',
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
		                dataField: "KodeItemFG",
		                caption: "Kode Item Hasil",
		                allowEditing:false
		            },
		            {
		                dataField: "NamaItemFG",
		                caption: "Nama Item Hasil",
		                allowEditing:false
		            },
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
		        keyExpr: "KodeItemRM",
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
		                dataField: "KodeItemRM",
		                caption: "Kode Item",
		                allowEditing:true
		            },
		            {
		                dataField: "NamaItemRM",
		                caption: "Nama Item",
		                allowEditing:false
		            },
		            {
		                dataField: "QtyIssue",
		                caption: "Qty",
		                allowEditing:true
		            }
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
					if (e.dataField == "KodeItemRM") {
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
							    		grid.cellValue(index, "KodeItemRM", response.data[0]["ItemCode"]);
							    		grid.cellValue(index, "NamaItemRM", response.data[0]["ItemName"]);
							    		grid.cellValue(index, "QtyIssue", 0);
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
