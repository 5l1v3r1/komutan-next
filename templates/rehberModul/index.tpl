{% extends 'yapi.tpl' %}
{% block title %}Komutan - Rehber/Milis Wiki{% endblock title %}
{% block content %}
<h2>Rehber/Milis Wiki</h2>
<br>
<div class="panel panel-warning">
  <div class="panel-heading">
         <h3 class="panel-title pull-left">Doküman Listesi</h3>
            <a class="btn-sm btn-warning pull-right guncelle"><i class="fa fa-refresh" aria-hidden="true"></i></a>
            <a class="btn-sm btn-warning pull-right" href="dokumanSil"><i class="fa fa-trash" aria-hidden="true"></i></a>
            <a class="btn-sm btn-warning pull-right" href="dokumanDuzenle"><i class="fa fa-edit" aria-hidden="true"></i></a>
            <a class="btn-sm btn-warning pull-right" href="dokumanEkle"><i class="fa fa-plus" aria-hidden="true"></i></a>
        <div class="clearfix"></div>    
  </div>
  <div class="panel-body">
        <div class="tablo"> 
                <div class="input-group">
                    <input type="text" class="form-control" id="myInput">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
                  </div>
                <br>
<table id="example" class="table table-striped table-bordere" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Başlık</th>
                <th>Yazar</th>
                <th>Tarih</th>
                <th style="display: none;"></th>
            </tr>
        </thead>
        <tbody>
{% for dokuman, metadata in dokumanlar.items %}
            <tr>
                <td><a href="{{dokuman}}">{{metadata.Başlık}}</a></td>
                <td>{{metadata.Yazar}}</td>
                <td>{{metadata.Tarih}}</td>
                <td style="display: none;">{% if metadata.anahtar_kelimeler %} {{metadata.anahtar_kelimeler}} {% endif %}</td>
            </tr>
{% endfor %}
	</tbody>
</table>
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
    "pageLength": 6,
    "sDom": '<"top">rt<"bottom"p><"clear">',
    "aoColumns": [ 
            null,
            { "bSearchable": false,},
            {"bSearchable": false},
            {"bSortable": false},        
            ],
        "language": {
                        "sZeroRecords":    "Hiç eşleşen dokuman bulunamadı...",
            "sLoadingRecords": "Dokümanlar yükleniyor...",
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

$('.guncelle').click(function(){ 
     $.get("gitGuncelle/", function(data, status){
        alert(data)
     });
});
</script>
{% endblock customjs %}
{% block customcss %}
<link href="/static/css/dataTables.fixedHeader.css">
{% endblock customcss %}
