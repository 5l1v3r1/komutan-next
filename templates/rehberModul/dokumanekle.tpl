{% extends 'yapi.tpl' %}
{% block title %}Komutan - Rehber/Milis Wiki{% endblock title %}
{% block content %}
<h2>Komuta Merkezi</h2>
<br>
<div class="panel panel-warning">
  <div class="panel-heading">
    <h3 class="panel-title"><a href="/rehberModul"><u>Rehber/Milis Wiki</u></a> > Doküman ekle</h3>
  </div>
  <div class="panel-body">
{% if not basarili %}
	<form class="form-horizontal" action="" method="POST">	
		<div class="form-group">
		  <label class="control-label col-sm-2" for="dokumanAdi">Doküman dosya adı:</label>
		  <div class="col-sm-10">
			<input type="text" class="form-control" id="dokumanAdi" name="dokumanAdi">
		  </div>
		</div>
		<div class="form-group">		
		  <label class="control-label col-sm-2" for="markdownKodu">Markdown formatında doküman içeriği:</label>
		  <div class="col-sm-10">
			<div class="alert alert-dismissible alert-warning">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>UYARI !</h4> 
					Lütfen doküman içeriğini yazarken bu tür durumları göz önünde bulundurunuz:
					<ul>
						<li>Doküman içeriğini yazarken Github Flavored Markdown (GFM) kullanınız.</li>
						<li>Dokümanınızın üstveri alanlarını eksiksiz doldurunuz. Anahtar kelimeler opsiyoneldir ve aramada sorgularını iyileştirmek için kullanılacaktır.</li>
						<li>Mevcut dokümanın üzerine yazmamak için dosya adının daha önce olmadığından emin olunuz. </li>
					</ul>
			</div>				  
			<textarea class="form-control" id="markdownKodu" name="markdownKodu">---
Başlık: Örnek Doküman
Yazar: Adınız Soyadınız
Tarih: 30/09/2017
anahtar_kelimeler: gnu linux, milis, debian, ubuntu
---

# Örnek Doküman
</textarea>
		  </div>
		</div>
		{% csrf_token %}	
		<button type="submit" class="btn btn-success pull-right">Kaydet</button>	
	</form>
  </div>
{% else %} 
<h1 class="text-center text-success"><i class="fa fa-check" aria-hidden="true"></i></h1>
<p class="text-center">Dokümanınız başarıyla depoya eklendi.</p>
{% endif %}
</div>
{% endblock content %}

{% block customcss %}
	<style>
		#markdownKodu{
			height: 40vh;
			font-family: Menlo, Monaco, Consolas, 'Courier New', monospace;
		}
	</style>
{% endblock customcss %}
