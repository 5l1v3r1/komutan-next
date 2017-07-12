{% extends 'yapi.tpl' %}
{% block title %}Komutan - Rehber/Milis Wiki{% endblock title %}
{% block content %}
<h2>Rehber/Milis Wiki</h2>
<br>
<div class="panel panel-warning">
  <div class="panel-heading">
         <h3 class="panel-title"><a href="/rehberModul">Doküman Listesi</a> > {{html.metadata.Başlık}}</h3>
  </div>
  <div class="panel-body">
<div class="well" style="overflow-y: auto; height: 60vh;">
{{html|safe}}
</div>
</div>
</div>
{% endblock content %}
{% block customcss %}
<link href="/static/css/pygments.css" rel="stylesheet">
{% endblock customcss %}
{% block customjs %}
<script>
$("table").addClass( "table table-striped table-bordered" );
</script>
{% endblock customjs %}