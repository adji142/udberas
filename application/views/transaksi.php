<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Transaksi</a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5>Transaksi</h5>
			        </div>
			        <div class="widget-content">
			        	<!-- <button type="button" class="btn btn-mini btn-info" data-toggle="modal" data-target="#modal_">
							  Tambah Pelayan
						</button> -->
						<div class="controls controls-row">
							<select class="span3 m-wrap" name="filtertipe" id="filtertipe">
								<option value="KARTUN">KARTUN</option>
								<option value="ABSTRAK">ABSTRAK</option>
								<option value="TROPIKAL">TROPIKAL</option>
							</select>
							<button class="span3 m-wrap" name="searchbytipe" id="searchbytipe">Cari</button>
				        </div>
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
	        	<div id="title_modal">Transaksi
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
	        	</div>
	        </h5>
	    </div>
	    <div class="modal-body">
	    	<form class="form-horizontal" enctype='application/json' id="post_">
	    		<div class="control-group">
	    			<label class="control-label">Tanggal Transaksi</label>
	    			<div class="controls">
	    				<input type="date" name="tgltransaksi" id="tgltransaksi" required="">
	    				<input type="hidden" class="span3 m-wrap" id="id" name="id">
			          <input type="hidden" class="span3 m-wrap" id="formtype" name="formtype" value="add">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">NoRef</label>
	    			<div class="controls">
	    				<input type="text" name="NoRef" id="NoRef" required="">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Merk</label>
	    			<div class="controls">
	    				<input type="text" name="Merk" id="Merk" required="" readonly="" value="DOWNSTORE">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Tipe</label>
	    			<div class="controls">
	    				<select id="tipe" name="tipe">
	    					<option value="KARTUN">KARTUN</option>
	    					<option value="ABSTRAK">ABSTRAK</option>
	    					<option value="TROPIKAL">TROPIKAL</option>
	    				</select>
	    			</div>
	    		</div>
	            <div class="control-group">
	    			<label class="control-label">Jumlah</label>
	    			<div class="controls">
	    				<input type="number" name="jml" id="jml" required="">
	    			</div>
	    		</div>
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
        	var where_field = 'Tipe';
        	var where_value = $('#filtertipe').val();
        	var table = 'ttransaksi';

	        $.ajax({
	          type: "post",
	          url: "<?=base_url()?>Apps/FindData",
	          data: {where_field:where_field,where_value:where_value,table:table},
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
		        url     : '<?=base_url()?>Apps/appendTransaksi',
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
        $('#searchbytipe').click(function () {
        	var where_field = 'Tipe';
        	var where_value = $('#filtertipe').val();
        	var table = 'ttransaksi';

	        $.ajax({
	          type: "post",
	          url: "<?=base_url()?>Apps/FindData",
	          data: {where_field:where_field,where_value:where_value,table:table},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
	          }
	        });        });
        $('.close').click(function() {
        	location.reload();
        });
        $('#pelanggan_list').on('click','tr',function () {
			var return_IDData = 1;
			var lookup_id = $(this).find("#lookup_id").text();
			var lookup_fullname = $(this).find("#lookup_fullname").text();
			
			$('#nama').val(lookup_fullname);
			$('#kdpelanggan').val(lookup_id);

			$('#Modalpelanggan').modal('toggle');
		});
		$('#Lookupsearch').click(function () {
			SearchData(false);
		});
		$('#rst_btn').click(function () {
			$('#xsrc').val('');
			SearchData();
		});
        // function
        function ClearForm() {
			$('#kd_pos').attr('disabled',true);
			$('#nm_pos').attr('disabled',true);
			$('#kel').attr('disabled',true);
		}
		function GetData(id) {
			// console.log(id);
			var where_field = 'id';
        	var where_value = id;
        	var table = 'ttransaksi';
			$.ajax({
	          type: "post",
	          url: "<?=base_url()?>Apps/FindData",
	          data: {where_field:where_field,where_value:where_value,table:table},
	          dataType: "json",
	          success: function (response) {
          		$.each(response.data,function (k,v) {
          			console.log(v.KelompokUsaha);
		            $('#tgltransaksi').val(v.Tanggal);
		            $('#NoRef').val(v.NoRef);
		            $('#Merk').val(v.Merk);
					$('#tipe').val(v.Tipe).change();
					$('#jml').val(v.Qty);

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
		        keyExpr: "id",
		        showBorders: true,
		        allowColumnReordering: true,
		        allowColumnResizing: true,
		        columnAutoWidth: true,
		        showBorders: true,
		        paging: {
		            enabled: true
		        },
		        editing: {
		            mode: "row",
		            // allowAdding:true,
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
		                dataField: "id",
		                caption: "id",
		                allowEditing:false,
		                visible : false
		            },
		            {
		                dataField: "Tanggal",
		                caption: "Tanggal Transaksi",
		                allowEditing:false
		            },
		            {
		                dataField: "NoRef",
		                caption: "No. Ref",
		                allowEditing:false
		            },
		            {
		                dataField: "Merk",
		                caption: "Merk",
		                allowEditing:false
		            },
		            {
		                dataField: "Tipe",
		                caption: "Tipe",
		                allowEditing:false
		            },
		            {
		                dataField: "Qty",
		                caption: "Jumlah",
		                allowEditing:false
		            }
		        ],
		        onEditingStart: function(e) {
		            GetData(e.data.id);
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
		        	id = e.data.id;
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
					  	var table = 'ttransaksi';
					  	var field = 'id';
					  	var value = id;

					  	$.ajax({
					        type    :'post',
					        url     : '<?=base_url()?>Apps/remove',
					        data    : {table:table,field:field,value:value},
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
	function SearchData() {
		var param = $('#nama').val();
		$('#Modalpelanggan').modal('toggle');
		$.ajax({
          type: "post",
          url: "<?=base_url()?>Lookup/LookupPelanggan",
          data: {param:param},
          dataType: "json",
          success: function (response) {
          	if (response.success == true) {
          		if (response.count == 1) {
          			$.each(response.data,function (k,v) {
			            $('#nama').val(v.NmCustomer);
						$('#kdpelanggan').val(v.id);
			          });
          		}
          		else{
          			var html = '';
			        var i;
			        for (i = 0; i < response.data.length; i++) {
			          html += '<tr>' +
			                  '<td id = "lookup_id">' + response.data[i].id+'</td>' +
			                  '<td id = "lookup_fullname">' + response.data[i].NmCustomer +'</td></tr>';
			        }
			        $('#load_data').html(html);
			        $('#Modalpelanggan').modal('show');
			        $('#Modalpelanggan').modal('toggle');
			        $('#Modalpelanggan').modal('show');
          		}
          	}
          }
        });
	}
</script>
