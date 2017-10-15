{% extends 'yapi.tpl' %}
<!-- Kullanıcı  giriş yapmamış ise yönlendir. -->
{% block title %}Komutan - Sistem Kullanım Bilgisi{% endblock %}
{% if user.is_anonymous %}
<meta http-equiv="refresh" content="0; url=/giris"/>
{% else %}
{% block content %}
<h2>Sistem Kullanım Bilgileri</h2>
<br>
<br>
<form id="bilgiForm" class="form-inline" role="form">
{% csrf_token %}
<div class="col-md-6">
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Sistem Bilgisi</h3>
  </div>
  <div class="panel-body">
  	<div id="sistem_bilgisi"></div>
    <input type="text" hidden name="betik" value="sistem_bilgisi.sh">
  </div>
</div>
</div>
<div class="col-md-6">
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Sistem kullanımı</h3>
  </div>
  <div class="panel-body">
  	<div id="chart_div" style="width:100%; height: 200px;"></div>
  </div>
</div>
</div>	
</body>
{% endblock content %}  
{% endif %}
{% block customjs %}
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['gauge']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
        ]);

        var options = {
          width: 400, height: 200,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };

        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));

        chart.draw(data, options);
      }
    </script>

<script>
	formVerisi = $('#bilgiForm').serialize();	
		
	xmlhttp = new XMLHttpRequest();

	function reqListener () {
		//$('.cikti').html('Komut çalışmaya başladı.');
	}

	function updateProgress (oEvent) {
  		var cikti = oEvent.target.responseText.split("~-~-~")
  		console.log(cikti)
  		var cikti =  JSON.parse(cikti.pop())
        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['CPU', 0],
          ['MEM', 0],
        ]);  		
  		data.setValue(0, 1, cikti.CPU);
  		data.setValue(1, 1, cikti.MEM);
  		var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
  		var options = {
          width: 400, height: 200,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };
        chart.draw(data, options);
        $("#sistem_bilgisi").html("<b>Sistem: </b>" + cikti.SISTEM + "<br><b>Uptime: </b>" + cikti.UPTIME)
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
		display: none;
	}
</style>
{% endblock customcss %}
