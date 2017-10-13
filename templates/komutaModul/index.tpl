{% extends 'yapi.tpl' %}
{% block title %}Komutan - Komuta Merkezi{% endblock %}
{% block content %}
<h2>Komuta Merkezi</h2> 
<br>
<div class="panel panel-success">
    <div class="panel-heading">
         <h3 class="panel-title pull-left">Betik Çalıştır</h3>
        	<a class="btn-sm btn-success pull-right guncelle"><i class="fa fa-refresh" aria-hidden="true"></i></a>
        	<a href="betikSil/" class="btn-sm btn-success pull-right"><i class="fa fa-trash" aria-hidden="true"></i></a>
        	<a href="betikDuzenle/" class="btn-sm btn-success pull-right"><i class="fa fa-edit" aria-hidden="true"></i></a>
        	<a href="betikEkle/" class="btn-sm btn-success pull-right"><i class="fa fa-plus" aria-hidden="true"></i></a>

        <div class="clearfix"></div>
    </div>
  <div class="panel-body">
	<div>
		<form id="betikForm" class="form-inline" role="form">
		{% csrf_token %}
				<div class="form-group">
					<select class="form-control" name="betik" id="betik" >
					<option>---</option>
					{% for betik in betikler %}
						<option>{{betik}}</option>
					{% endfor %}
					</select>
				</div>
			{% if parametreler %}
			{% for parametre, degerler in parametreler.items %} 
			<div class="form-group kutu">
			<span>{{ degerler.0 }}: </span>
			<input type="text" class="parametre form-control input-sm" name="{{ parametre }}" value="{{ degerler.1 }}">  
			</div>
			{% endfor %}
			{% endif %}
				<div class="form-group kutu">	 
			        <span> Root Yetkisiyle Çalıştır&nbsp;&nbsp;</span>
			        <div class="material-switch pull-right">
			            <input id="rootCheckbox" name="sudo" type="checkbox"/> 
			            <label for="rootCheckbox" class="label-success"></label>
			        </div>
				</div>
			<div class="form-group">
				<button type="button" class="btn btn-success calistir">Çalıştır</button>
			</div>
		</form>
	</div>
	<div class="row">
		<pre class="well cikti"></pre>
	</div>
  </div>
</div>
</div>		
{% endblock content %}

{% block customjs %}
<script>
	$(".calistir").attr("disabled", true);
	
	{% if betik %}
		$('#betik').val("{{ betik }}")
		$(".calistir").attr("disabled", false);
	{% endif %}
	
	$('#betik').change(function(event) {
		if (this.value != "---") {
			window.location.replace("?betik="+this.value);
			$(".calistir").attr("disabled", false);
		}else{
			$(".calistir").attr("disabled", true);
		}
	});

	$('.parametre').focusout(function(event) {
		betik = "{{ betik }}"
		parametre = $( this )[0].name
		parametreBaslik = $( this ).siblings()[0].outerText.replace(':','')
		deger = $( this ).val()
        $.post("parametreKaydet/",
        {
          csrfmiddlewaretoken: '{{ csrf_token }}',
          betik: betik,
          parametre: parametre,
          parametreBaslik : parametreBaslik,
          deger : deger
        },
        function(data,status){
            console.log(data)
        });		
	});


	$(".calistir").click(function () {
		
		formVerisi = $('#betikForm').serialize();	
		
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


	});

	$('.guncelle').click(function(){ 
		 $.get("gitGuncelle/", function(data, status){
		 	$('.cikti').show();
		 	$('.cikti').html(data);
		 });
	});
</script>
{% endblock customjs %}
{% block customcss %}
<style>
	.cikti{
		height: 50vh;
		display: none;
		margin-top: 15px
	}
	.kutu{
		height: 43.33px !important;
	}
	.parametre{
		border-radius: 15px;
		margin-top: -5px
	}
</style>
{% endblock customcss %}
