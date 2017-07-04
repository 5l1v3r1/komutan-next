{% extends 'yapi.tpl' %}
{% block title %}Komutan - Milis Yazılım Merkezi{% endblock title %}
{% block content %}
<h2>Milis Yazılım Merkezi</h2>
<br>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title"><a href="/mpsModul">Milis Yazılım Merkezi</a> > Paket kur</h3>
  </div>
  <div class="panel-body">
	<pre class="well cikti"><code>{{ cikti | safe }}</code></pre>
  </div>
</div>
{% endblock content %}

{% block customcss %}
	<style>
		.cikti{
			height: 50vh;
			display: block;
			margin-top: 15px
		}
	</style>
{% endblock customcss %}
