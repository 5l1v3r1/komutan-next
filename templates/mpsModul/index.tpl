{% extends 'yapi.tpl' %}
{% block title %}Komutan - Milis Yazılım Merkezi{% endblock title %}
{% block content %}
<h2>Milis Yazılım Merkezi</h2>

	<div class="container">
		<div class="row">
		  <div class="col-md-12">
			<div class="well well-lg">
			  <form class="form-horizontal" id="raporForm" name="raporForm" role="form" method=post>
			  <fieldset>
				<legend class="text-center">Milis Yazılım Merkezi</legend>
				
				<!-- paket ismi -->
				<div class="form-group">
				  <div class="col-md-2">
					<input id="paketadi" name="paketadi" type="text" placeholder="paket ismi" class="form-control">
				  </div>
				  <div class="col-md-2">
					<label>Paket Veritabanı Talimatname</label>
				  </div>
				  <div class="col-md-2">
					  <input type="submit" class="btn btn-info" name="guncelle" id="guncelle" value="GÜNCELLE"  />
					  <input type="submit" class="btn btn-info" name="pkgun" id="pkgun" value="G"  />
					  <input type="submit" class="btn btn-info" name="gitgun" id="gitgun" value="GG"  />
				  </div>
				  
				</div>
				<div class="alert alert-success" id="kurulu-bilgi1" role="alert" style="display:none;" >kurulu</div>
				<div class="alert alert-danger" id="kurulu-bilgi2" role="alert" style="display:none;" >kurulu değil</div>
				<div class="alert alert-danger" id="kurulu-bilgi3" role="alert" style="display:none;" >tanımsız paket</div>
				<div class="alert alert-success" id="pkgun-bilgi" role="alert" style="display:none;" >Paket Veritabanı Güncellendi.</div>
				<div class="alert alert-success" id="gitgun-bilgi" role="alert" style="display:none;" >Talimatname Güncellendi.</div>
				<button type="button" id="hareket-bilgi" class="btn btn-info" >
				   <span id="hareket-bilgi-durum"></span> <span class="glyphicon glyphicon-repeat fast-right-spinner"></span>
				</button>
		
				<!-- paket bilgi alanı -->
				<div class="form-group">
				  <div class="col-md-8">
					<!-- 
					<div class="well"><span id="talimat-meta">meta</span></div>  
					-->
					<textarea class="form-control text-left" id="pkbilgialan" name="pkbilgialan" placeholder="Paket bilgileri burda..." rows="5"></textarea>
				  </div>
				</div>
		
				<!-- Form actions -->
				<div class="form-group">
				  <div class="col-md-4">
					<input type="submit" class="btn btn-success" name="mpskur" id="mpskur" value="KUR" />
					<input type="submit" class="btn btn-danger" name="mpssil-sor" id="mpssil-sor" value="KALDIR" />
					<input type="submit" class="btn btn-info" name="mpsgun" id="mpsgun" value="GÜNCELLE"  />
				  </div>
				</div>
				
				
				  <!-- Modal -->
				  <div class="modal fade" id="pkkurModal" role="dialog">
					<div class="modal-dialog">
					
					  <!-- Modal content-->
					  <div class="modal-content">
						<div class="modal-header">
						  <button type="button" class="close" data-dismiss="modal">&times;</button>
						  <h4 class="modal-title">Paket Hareket Bilgisi</h4>
						</div>
						<div class="modal-body">
						  <p></p>
						</div>
						<div class="modal-footer">
						  <button type="button" id="pkharKapat" class="btn btn-default" data-dismiss="modal">Kapat</button>
						</div>
					  </div>
					  
					</div>
				  </div> 
				  
				  <!-- Modal paketsil -->
				<div class="modal fade" id="mpssil-onay" role="dialog">
					<div class="modal-dialog">
					  <!-- Modal content-->
					  <div class="modal-content">
						<div class="modal-header">
						  <button type="button" class="close" data-dismiss="modal">&times;</button>
						  <h4 class="modal-title">Paket Silme Onayı</h4>
						</div>
						<div class="modal-body">
						  <p></p>
						</div>
						<div class="modal-footer">
						  <button type="button" id="mpssil" class="btn btn-danger" data-dismiss="modal">Evet</button>
						  <button type="button" id="iptal" class="btn btn-default" data-dismiss="modal">İptal</button>
						</div>
					  </div> 
					</div>
				</div> 
				
			  </fieldset>
			  </form>
			</div>
		  </div>
		</div>
	</div>
{% endblock content %}


{% block customjs %}
<script>
	
	var ajax = new XMLHttpRequest();
	ajax.open("GET", "/paketlist", true);
	ajax.onload = function() {
		var list = JSON.parse(ajax.responseText).map(function(i) { return i.isim; });
		if (list=="hata"){
			hataGoster("paketlist boş!");
		}else{
			new Awesomplete(document.querySelector("#paketadi"),{ list: list });
		}
	};
	ajax.send();
	
	
	$(document).ready(function() {
		
		
		var bg = Cookies.get('mlsBg');
		$('body').css({"background" : 'url('+bg+')  no-repeat center center fixed', "-webkit-background-size":"cover", "-moz-background-size":"cover","-o-background-size":"cover","background-size":"cover","margin":"20px 20px 20px 20px"});
		
		$('#calismakod').hide();
		$("#yukleniyor").hide();
		$("#pkgun").hide();
		$("#gitgun").hide();
		$("#hareket-bilgi").hide();
		
		shortcut.add("ctrl+R", function() {
			//event.preventDefault();
			$("#calistir").click();
	    });
		
		$('#paketadi').dblclick( function(){ 
			$(this).val(''); 
			$('#pkbilgialan').val(''); 
		}); 
		
		$('#calistir').on('click', function(event){
			event.preventDefault();
			$("#raporalan").html("komut calisiyor....");
			$("#yukleniyor").show();
			var spans = $('#arayuz_alan').find('input');
			// Loop through all the spans inside this div
			spans.each(function(){
				console.log($(this).attr('id'),$(this).val());
			})
			var formOption = {
				url				: "/komutCalistir",
				type			: "POST",
				target	:"#raporalan",
				success			: sonucGetir
				//beforeSubmit 	: kontrolStkHarListSil
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		$('#paketadi').on('click', function(event){
			event.preventDefault();
			$('[id^="kurulu-bilgi"]').hide();
		});
		
		$('#pkgun').on('click', function(event){
			event.preventDefault();
			
			var formOption = {
				url : "/paketvtGuncelle",
				type			: "POST",
				success: function (data) {
						if(data=='tamam'){
							$("#pkgun-bilgi").fadeTo(2000, 500).slideUp(500, function(){
								$("#pkgun-bilgi").slideUp(500);
							});
						}else{
							hataGoster(data);
						}
					}
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		$('#gitgun').on('click', function(event){
			event.preventDefault();
			var formOption = {
				url : "/gitGuncelle",
				type			: "POST",
				success: function (data) {
						if(data=='tamam'){
							$("#gitgun-bilgi").fadeTo(2000, 500).slideUp(500, function(){
								$("#gitgun-bilgi").slideUp(500);
							});
						}else{
							hataGoster(data);
						}
					}
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		$('#paketadi').on('blur', function(event){
			//$('#kurulu-bilgi1').hide();
			$('[id^="kurulu-bilgi"]').hide();
			if ($('#paketadi').val() != ''){
				var bilgiver=0;
				var formOption = {
					url				: "/paketDurum",
					type			: "POST",
					success: function (data) {
						if(data=='kurulu'){
							//islemTamam("KURULU");
							//$('#kurulu-bilgi').show();
							//$('#kurulu-bilgi').fadeIn();
							$('#kurulu-bilgi1').slideDown();
							bilgiver = 1
						}else if (data=='degil'){
							$('#kurulu-bilgi2').slideDown();
							bilgiver = 1
						}else{
							//tanimsiz paket
							$('#kurulu-bilgi3').slideDown();
						}
						if (bilgiver == 1) {
							var formOption = {
								url : "/mpsFaal?faal=bilgi",
								type			: "POST",
								success: function (data) {
									$('#pkbilgialan').val(data);
									//document.getElementById("talimat-meta").textContent=data;
								}
							};
							$('#raporForm').ajaxSubmit(formOption);
						}else{
							$('#pkbilgialan').val("");
						}
					}
				};
				$('#raporForm').ajaxSubmit(formOption);
			}
		});
		
		$('#yeniKaydet').on('click', function(event){
			event.preventDefault();
			$('#kayitmodu').val('w');
			var formOption = {
				url				: "/calismaKaydet",
				type			: "POST",
				success: function (data) {
					if(data=='tamam'){
						islemTamam("Yeni Komut Kaydı Yapıldı.");
					}else{
						hataGoster(data);
					}
				}
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		$('#guncelle').on('click', function(event){
			event.preventDefault();
			$('#pkgun').click();
			$('#gitgun').click();
		});
	
		$('#mpskur').on('click', function(event){
			event.preventDefault();
			$('[id^="kurulu-bilgi"]').hide();
			document.getElementById("hareket-bilgi-durum").textContent="Kuruluyor";
			$('#hareket-bilgi').slideDown();
			var formOption = {
				url : "/mpsFaal?faal=kur",
				type			: "POST",
				success: function (data) {
					var mymodal = $('#pkkurModal');
					mymodal.find('.modal-body').html(data);
					mymodal.modal('show');	
				}
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		
		$('#mpssil').on('click', function(event){
			event.preventDefault();
			$('[id^="kurulu-bilgi"]').hide();
			document.getElementById("hareket-bilgi-durum").textContent="Siliniyor";
			$('#hareket-bilgi').slideDown();
			var formOption = {
				url : "/mpsFaal?faal=sil",
				type			: "POST",
				success: function (data) {
					var mymodal = $('#pkkurModal');
					mymodal.find('.modal-body').html(data);
					mymodal.modal('show');	
				}
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		$('#mpssil-sor').on('click', function(e) {
		  e.preventDefault();
		   $("#mpssil-onay").find('.modal-body').html($("#paketadi").val()+" paketini silmek istiyor musunuz?");
		  $("#mpssil-onay").modal('show');
		});
		
		$('#mpsgun').on('click', function(event){
			event.preventDefault();
			$('[id^="kurulu-bilgi"]').hide();
			document.getElementById("hareket-bilgi-durum").textContent="Güncelleniyor";
			$('#hareket-bilgi').slideDown();
			var formOption = {
				url : "/mpsFaal?faal=guncelle",
				type			: "POST",
				success: function (data) {
					var mymodal = $('#pkkurModal');
					mymodal.find('.modal-body').html(data);
					mymodal.modal('show');	
				}
			};
			$('#raporForm').ajaxSubmit(formOption);
		});
		
		$('#pkharKapat').on('click', function(event){
			$('#hareket-bilgi').hide();
		});
		
	});
	
	function sonucGetir(res, statusText, xhr, $form) {
		//console.log(res);
		if(res!='None'){
			$('#yukleniyor').hide();
			$("#raporalan").html("");
			$("#raporalan").html(res);
			$("#hareketrapor").tablesorter();
		}
	}
	
	function islemTamam(message) {
		// TODO: hata mesajı dön
		$.blockUI({ 
            message: message, 
            fadeIn: 500, 
            fadeOut: 500, 
            timeout: 2000, 
            showOverlay: false, 
            centerY: false, 
            css: { 
                width: '550px',
                top: '6px', 
                left: '', 
                right: '100px', 
                border: 'none', 
                padding: '10px', 
                backgroundColor: '#080', 
                '-webkit-border-radius': '6px', 
                '-moz-border-radius': '6px', 
                'border-radius': '6px',
                opacity: .6, 
            	'font-style': 'italic',
	        	'font-weight': 'normal',
	        	'font-family': 'Georgia, "Times New Roman", Times, serif',
	        	'font-size': '16px',
	        	color: '#fff'
            }
        });
	}
	
	function hataGoster(message) {
		
		console.log("HATA:" + message);
		$.blockUI({ 
            message: message, 
            fadeIn: 500, 
            fadeOut: 500, 
            timeout: 2000, 
            showOverlay: false, 
            centerY: false, 
            css: { 
                width: '550px',
                top: '6px', 
                left: '', 
                right: '100px', 
                border: 'none', 
                padding: '10px', 
                backgroundColor: '#900', 
                '-webkit-border-radius': '6px', 
                '-moz-border-radius': '6px', 
                'border-radius': '6px',
                opacity: .6, 
            	'font-style': 'italic',
	        	'font-weight': 'normal',
	        	'font-family': 'Georgia, "Times New Roman", Times, serif',
	        	'font-size': '16px',
	        	color: '#fff',
                
            }
        });
	}
	
	
</script>
{% endblock customjs %}



{% block customcss %}
<style>
	.glyphicon.fast-right-spinner {
	-webkit-animation: glyphicon-spin-r 1s infinite linear;
	animation: glyphicon-spin-r 1s infinite linear;
	}

	@-webkit-keyframes glyphicon-spin-r {
	0% {
		-webkit-transform: rotate(0deg);
		transform: rotate(0deg);
	}

	100% {
		-webkit-transform: rotate(359deg);
		transform: rotate(359deg);
	}
	}

	@keyframes glyphicon-spin-r {
	0% {
		-webkit-transform: rotate(0deg);
		transform: rotate(0deg);
	}

	100% {
		-webkit-transform: rotate(359deg);
		transform: rotate(359deg);
	}
</style>
{% endblock customcss %}
