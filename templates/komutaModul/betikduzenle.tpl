{% extends 'yapi.tpl' %}
{% block title %}Komutan - Komuta Merkezi{% endblock title %}
{% block content %}
<h2>Komuta Merkezi</h2>
<br>
<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title"><a href="/komutaModul"><u>Komuta Merkezi</u></a> > Betik düzenle</h3>
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
		<div class="form-group">		
		  <label class="control-label col-sm-2" for="betikKodu">Betik kodu:</label>
		  <div class="col-sm-10">
			<div class="alert alert-dismissible alert-warning">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>UYARI !</h4> 
					Lütfen betik kodunuzu düzenlerken bu tür durumları göz önünde bulundurunuz:
					<ul>
						<li>Betiğiniz veri girişine ihtiyaç duyuyorsa betiğinizi verileri parametreler yoluyla alacak şekilde düzenleyin ve koddaki ilk satırı kendinize göre düzenleyiniz. Aksi takdirde ilk satırı siliniz.</li>
						<li>Betiğiniz içerisinde sonsuz döngüye neden olabilecek komutlar kullanmayınız, aksi takdirde betik sonlanmadığı için çıktı alamayacaksınız.</li>
						<li>Betiğiniz içerisinde kullandığınız ncurses tabanlı yazılımların çıktıları (örn. wget) düzgün görüntülenmeyebilir. </li>
					</ul>
			</div>				  
			<textarea class="form-control" id="betikKodu" name="betikKodu">{% if kod %}{{kod}}{% endif %}</textarea>
		  </div>
		</div>
		{% csrf_token %}	
		<button type="submit" class="btn btn-success pull-right kaydet">Kaydet</button>	
	</form>
  </div>
{% else %} 
<h1 class="text-center text-success"><i class="fa fa-check" aria-hidden="true"></i></h1>
<p class="text-center">Seçtiğiniz betik başarıyla değiştirildi.</p>
{% endif %}
</div>
{% endblock content %}

{% block customcss %}
	<style>
		#betikKodu{
			height: 40vh;
			font-family: Menlo, Monaco, Consolas, 'Courier New', monospace;
		}
	</style>
{% endblock customcss %}

{% block customjs %}
<script>
	$(".kaydet").attr("disabled", true);
	
	{% if betik %}
		$('#betik').val("{{ betik }}")
		$(".kaydet").attr("disabled", false);
	{% endif %}
	
	$('#betik').change(function(event) {
		if (this.value != "---") {
			window.location.replace("?betik="+this.value);
			$(".kaydet").attr("disabled", false);
		}else{
			$(".kaydet").attr("disabled", true);
		}
	});
</script>	
{% endblock customjs %}
