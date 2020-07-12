<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Master Vendor</a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5>Master Vendor</h5>
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
	        	<div id="title_modal">Tambah Vendor
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
	        	</div>
	        </h5>
	    </div>
	    <div class="modal-body">
	    	<form class="form-horizontal" enctype='application/json' id="post_">
	    		<div class="control-group">
	    			<label class="control-label">Kode Vendor</label>
	    			<div class="controls">
	    				<input type="text" name="KodeVendor" id="KodeVendor" required="" placeholder="Kode Vendor">
	    				<input type="hidden" name="id" id="id">
	    				<input type="hidden" name="Source" id="Source" value="1">
	    				<input type="hidden" name="formtype" id="formtype" value="add">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Nama Customer</label>
	    			<div class="controls">
	    				<input type="text" name="NamaVendor" id="NamaVendor" required="" placeholder="Nama Vendor">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Alamat Vendor</label>
	    			<div class="controls">
	    				<textarea id="AlamatVendor" name="AlamatVendor" rows="3"></textarea>
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">No. Telepon Vendor</label>
	    			<div class="controls">
	    				<input type="text" name="TlpVendor" id="TlpVendor" required="" placeholder="No Tlp Vendor">
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
	            <button class="btn btn-primary" id="btn_Save">Save</button>
	    	</form>
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
	          url: "<?=base_url()?>Mstr_Vendor/read",
	          data: {'id':''},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
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
		        url     : '<?=base_url()?>Mstr_Vendor/CRUD',
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
        $('.close').click(function() {
        	location.reload();
        });
        $('#KodeVendor').focusout(function () {
			$.ajax({
	          type: "post",
	          url: "<?=base_url()?>Mstr_Vendor/read",
	          data: {'id':$('#KodeVendor').val()},
	          dataType: "json",
	          success: function (response) {
          		$.each(response.data,function (k,v) {
		            $('#KodeVendor').val(v.KodeVendor);
					$('#NamaVendor').val(v.NamaVendor);
					$('#AlamatVendor').val(v.AlamatVendor);
					$('#TlpVendor').val(v.TlpVendor);

					$('#formtype').val("edit");
					$('#id').val(v.id);
		          });
	          }
	        });
        })
		function GetData(id) {
			var where_field = 'id';
        	var where_value = id;
        	var table = 'users';
			$.ajax({
	          type: "post",
	          url: "<?=base_url()?>Mstr_Vendor/read",
	          data: {'ItemCode':id},
	          dataType: "json",
	          success: function (response) {
          		$.each(response.data,function (k,v) {
          			console.log(v.KelompokUsaha);
		            $('#KodeVendor').val(v.KodeVendor);
					$('#NamaVendor').val(v.NamaVendor);
					$('#AlamatVendor').val(v.AlamatVendor);
					$('#TlpVendor').val(v.TlpVendor);

					$('#id').val(v.id);
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
		        keyExpr: "KodeVendor",
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
		                dataField: "KodeVendor",
		                caption: "Kode Vendor",
		                allowEditing:false
		            },
		            {
		                dataField: "NamaVendor",
		                caption: "Nama Vendor",
		                allowEditing:false
		            },
		            {
		                dataField: "AlamatVendor",
		                caption: "Alamat",
		                allowEditing:false
		            },
		            {
		                dataField: "TlpVendor",
		                caption: "NoTlp",
		                allowEditing:false
		            },
		        ],
		        onEditingStart: function(e) {
		            GetData(e.data.KodeCustomer);
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
		        	id = e.data.KodeVendor;
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
					        url     : '<?=base_url()?>Mstr_Vendor/CRUD',
					        data    : {'KodeVendor':id,'formtype':'delete'},
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
	});
</script>
