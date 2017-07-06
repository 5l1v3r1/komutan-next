{% extends 'yapi.tpl' %}
{% block title %}Komutan - Komuta Merkezi{% endblock title %}
{% block content %}
<h2>Komuta Merkezi</h2>
<br>
<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title"><a href="/komutaModul"><u>Komuta Merkezi</u></a> > Betik sil</h3>
  </div>
  <div class="panel-body">
{% if not basarili %}
	<form class="form-horizontal" action="" method="POST">	
		<div class="form-group">
		  <label class="control-label col-sm-2" for="betik">Betik:</label>
		  <div class="col-sm-10">
					<select class="form-control" name="betikAdi" id="betik" >
					<option>---</option>
					{% for betik in betikler %}
						<option>{{betik}}</option>
					{% endfor %}
					</select>
		  </div>
		</div>
		{% csrf_token %}	
		<button type="submit" class="btn btn-success pull-right kaydet">Sil</button>	
	</form>
  </div>
{% else %} 
<h1 class="text-center text-success"><i class="fa fa-check" aria-hidden="true"></i></h1>
<p class="text-center">Seçtiğiniz betik başarıyla silindi.</p>
{% endif %}
</div>
{% endblock content %}
