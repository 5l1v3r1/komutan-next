{% extends 'yapi.tpl' %}
{% block title %}Komutan - Milis Yazılım Merkezi{% endblock title %}
{% block content %}
<h2>Komuta Merkezi</h2>
<br>
<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title"><a href="/komutaModul"><u>Komuta Merkezi</u></a> > Betik ekle</h3>
  </div>
  <div class="panel-body">
{% if not basarili %}
	<form class="form-horizontal" action="" method="POST">	
		<div class="form-group">
		  <label class="control-label col-sm-2" for="betikAdi">Betik adı:</label>
		  <div class="col-sm-10">
			<input type="text" class="form-control" id="betikAdi" name="betikAdi">
		  </div>
		</div>
		<div class="form-group">		
		  <label class="control-label col-sm-2" for="betikKodu">Betik kodu:</label>
		  <div class="col-sm-10">
			<div class="alert alert-dismissible alert-warning">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>UYARI !</h4> 
					Lütfen betik kodunuzu yazarken bu tür durumları göz önünde bulundurunuz:
					<ul>
						<li>Betiğiniz veri girişine ihtiyaç duyuyorsa betiğinizi verileri parametreler yoluyla alacak şekilde düzenleyin ve koddaki ilk satırı kendinize göre düzenleyiniz. Aksi takdirde ilk satırı siliniz.</li>
						<li>Betiğiniz içerisinde sonsuz döngüye neden olabilecek komutlar kullanmayınız, aksi takdirde betik sonlanmadığı için çıktı alamayacaksınız.</li>
						<li>Betiğiniz içerisinde kullandığınız ncurses tabanlı yazılımların çıktıları (örn. wget) düzgün görüntülenmeyebilir. </li>
					</ul>
			</div>				  
			<textarea class="form-control" id="betikKodu" name="betikKodu">#-p1:Parametre 1:değer1|--parametre2:Parametre 2:değer2|-par3:Parametre 3:
</textarea>
		  </div>
		</div>
		{% csrf_token %}	
		<button type="submit" class="btn btn-success pull-right">Gönder</button>	
	</form>
  </div>
{% else %} 
<h1 class="text-center text-success"><i class="fa fa-check" aria-hidden="true"></i></h1>
<p class="text-center">Betiğiniz başarıyla depoya eklendi.</p>
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
