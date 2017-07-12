{% extends 'yapi.tpl' %}
{% block title %}Komutan - Milis Yazılım Merkezi{% endblock title %}
{% block content %}
<h2>Milis Yazılım Merkezi</h2>
<br>
<div class="panel panel-info">
  <div class="panel-heading">
         <h3 class="panel-title pull-left">Paket işlemleri</h3>
        	<a class="btn-sm btn-info pull-right guncelle"><i class="fa fa-refresh" aria-hidden="true"></i></a>
        	<a class="btn-sm btn-info pull-right sunucuEkle"><i class="fa fa-server" aria-hidden="true"></i></a>

        <div class="clearfix"></div>    
  </div>
  <div class="panel-body">
		<div class="tablo">		
				<div class="input-group">
					<input type="text" class="form-control" id="myInput">
					<span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
				  </div>
				<br>
				<table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>Paket Adı</th>
								<th>Sürüm</th>
								<th>Paket Açıklaması</th>
								<th>Durumu</th>
							</tr>
						</thead>
						<tbody>
							{% for paket in lst %}
							<tr>
								<td><a href="{{ paket.url }}">{{ paket.isim }}</a></td>
								<td>{{ paket.surum }}</td>
								<td>{{ paket.aciklama }}</td>
								{% if  paket.kurulu %}
								<td><a href="sil/{{ paket.isim }}" class="btn btn-success" data-toggle="tooltip" data-placement="bottom" title="Paketi silmek için tıklayınız.">Kurulu</a></td>
								{% else %}
								<td><a href="kur/{{ paket.isim }}" class="btn btn-danger" data-toggle="tooltip" data-placement="bottom" title="Paketi kurmak için tıklayınız.">Kurulu değil</a></td>
								{% endif %}
							</tr>
							{% endfor %}
						</tbody>
					</table>
		</div>			
  </div>
</div>
{% endblock content %}

{% block customjs %}
<script src="/static/js/jquery.dataTables.js"></script>
<script src="/static/js/dataTables.bootstrap.js"></script>
<script src="/static/js/dataTables.fixedHeader.min.js"></script>
<script>
	
$(document).ready(function() {
    var table = $('#example').DataTable(
    {
	"pageLength": 4,
    "sDom": '<"top">rt<"bottom"p><"clear">',
    "aoColumns": [ 
            null,
            { "bSearchable": false,"bSortable": false },
            {"bSortable": false},
            { "bSearchable": false }
    	],
     	"language": {
						"sZeroRecords":    "Hiç eşleşen paket bulunamadı...",
            "sLoadingRecords": "Paketler yükleniyor...",
            "sProcessing":     "İşleniyor...",
            "oPaginate": {
                "sFirst":    "İlk",
                "sLast":     "Son",
                "sNext":     "Sonraki Sayfa",
                "sPrevious": "Önceki Sayfa"
            }            
        }
    }
    );
    $('#myInput').on( 'keyup', function () {
    table.search( this.value ).draw();
} );
$('[data-toggle="tooltip"]').tooltip(); 
} );

</script>
{% endblock customjs %}



{% block customcss %}
<link href="/static/css/dataTables.fixedHeader.css">
{% endblock customcss %}
