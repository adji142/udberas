<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
<input type="hidden" id="access" value="<?php echo $HakAkses; ?>">
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Laporan Penjualan</a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5>Laporan Penjualan</h5>
			        </div>
			        <div class="widget-content">
			        	<div class="controls controls-row">
			        		<input type="date" name="tglawal" id="tglawal" class="span3 m-wrap"> 
			        		<label class="control-label span1 m-wrap">s/d</label>
			        		<input type="date" name="tglakhir" id="tglakhir" class="span3 m-wrap"> 
			        		<button class="span3 m-wrap" name="searchbytipe" id="searchbytipe">Cari</button>
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
	          url: "<?=base_url()?>Laporan/read",
	          data: {'tglawal':$('#tglawal').val(),'tglakhir' : $('#tglakhir').val()},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
	          }
	        });
        });
        $('#searchbytipe').click(function () {
        	$.ajax({
	          type: "post",
	          url: "<?=base_url()?>Laporan/read",
	          data: {'tglawal':$('#tglawal').val(),'tglakhir' : $('#tglakhir').val()},
	          dataType: "json",
	          success: function (response) {
	          	bindGrid(response.data);
	          }
	        });
        });
        $('.close').click(function() {
        	location.reload();
        });
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
		            	dataField : "KodeItem",
		            	caption : "KodeItem",
		            	allowEditing : false
		            },
		            {
		            	dataField : "NamaItem",
		            	caption : "NamaItem",
		            	allowEditing : false
		            },
		            {
		            	dataField : "Qty",
		            	caption : "Qty",
		            	allowEditing : false
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
		function uuidv4() {
		  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		    return v.toString(16);
		  });
		}
	});
</script>
