{% extends 'yapi.tpl' %}
<!-- Kullanıcı  giriş yapmamış ise yönlendir. -->
{% block title %}Komutan - Sistem Bilgisi{% endblock %}
{% if user.is_anonymous %}
<meta http-equiv="refresh" content="0; url=/giris"/>
{% else %}
{% block content %}
<h2>Sistem Bilgileri</h2>
<br>
<br>
<form id="bilgiForm" class="form-inline" role="form">
<div class="col-md-6">
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Sistem hakkında</h3>
  </div>
  <div class="panel-body">
    Sistem bilgileri burada.
    
  </div>
</div>
</div>
<div class="col-md-6">
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Sistem kullanımı</h3>
  </div>
  <div class="panel-body">
    Sistem kullanım bilgileri burada.
  </div>
</div>
</div>	
</body>
{% endblock content %}  
{% endif %}
{% block customjs %}
<script>
	formVerisi = $('#bilgiForm').serialize();	
		
	xmlhttp = new XMLHttpRequest();

	function reqListener () {
		//$('.cikti').html('Komut çalışmaya başladı.');
	}

	function updateProgress (oEvent) {
  
		$('.cikti').html(oEvent.target.responseText);
	}

	url = '/komutaModul/betikCalistir/';
	xmlhttp.addEventListener('load', reqListener);
	xmlhttp.addEventListener('progress', updateProgress, false);
	xmlhttp.open("post", url, true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.send(formVerisi);
	$('.cikti').show();
</script>
{% endblock customjs %}

{% block customcss %}
<style>
	.cikti{
		height: 50vh;
		display: none;
		margin-top: 15px
	}
</style>
{% endblock customcss %}
