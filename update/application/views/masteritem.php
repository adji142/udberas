<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'daftarmesin';
?>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"> <a href="<?php echo base_url(); ?>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Master Item</a> </div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title"> 
			            <h5>Master Item</h5>
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
	        	<div id="title_modal">Tambah Item
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
	        	</div>
	        </h5>
	    </div>
	    <div class="modal-body">
	    	<form class="form-horizontal" enctype='application/json' id="post_">
	    		<div class="control-group">
	    			<label class="control-label">Kode Item</label>
	    			<div class="controls">
	    				<input type="text" name="ItemCode" id="ItemCode" required="" placeholder="Kode Item">
	    				<input type="hidden" name="formtype" id="formtype" value="add">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Nama Item</label>
	    			<div class="controls">
	    				<input type="text" name="ItemName" id="ItemName" required="" placeholder="Nama Item">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Satuan</label>
	    			<div class="controls">
	    				<input type="text" name="Satuan" id="Satuan" required="" placeholder="Satuan">
	    			</div>
	    		</div>
	    		<div class="control-group">
	    			<label class="control-label">Harga</label>
	    			<div class="controls">
	    				<input type="text" name="Harga" id="Harga" required="" placeholder="Harga">
	    			</div>
	    		</div>
	    		<div class="control-group">
                    <label class="control-label">Foto</label>
                    <div class="controls">
                        <input type="file" id="bannerimage" name="bannerimage" />
			              <img src="" id="profile-img-tag" width="200" />
			              <span class="help-block">Max Resolution 800 x 600</span>
			              <textarea id="Image" name="Image" style="display: none;"></textarea>
			              <!-- display: none; -->
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
		var _URL = window.URL || window.webkitURL;
        $(document).ready(function () {
        	var where_field = '';
        	var where_value = '';
        	var table = 'users';

	        $.ajax({
	          type: "post",
	          url: "<?=base_url()?>Mstr_Item/Read",
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
					$('#Satuan').val(v.Satuan);
					$('#Image').val(v.Image);
					$('#Harga').val(v.Harga);
					$('#formtype').val("edit");
		          });
	          }
	        });
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
					$('#Satuan').val(v.Satuan);
					$('#Image').val(v.Image);
					$('#Harga').val(v.Harga);
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
		                dataField: "ItemCode",
		                caption: "Kode Item",
		                allowEditing:false
		            },
		            {
		                dataField: "ItemName",
		                caption: "Nama Item",
		                allowEditing:false
		            },
		            {
		                dataField: "Harga",
		                caption: "Harga",
		                allowEditing:false
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
	});
</script>
