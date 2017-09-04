from django.shortcuts import render
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.template import loader
from django.http import HttpResponse, StreamingHttpResponse
from .utils import SSHelper as SSH
from .models import Tema, Baglanti
import os
# Tercihlere göre otomatik tema CSS oluştur.
def dinamikCSS(request):
	arkaplan = Tema.objects.all()[0].arkaplan.replace(settings.BASE_DIR,'')
	koyuYazi = Tema.objects.all()[0].koyuYazı
	template = loader.get_template('style.css')
	context = {
		'arkaplan': arkaplan,
		'koyuYazi': koyuYazi
	}

	return HttpResponse(template.render(context, request), content_type="text/css")
	


# Kullanıcıyı ilk karşılayan ana menüyü göster.
@login_required()
def sistemBilgiGoster(request):
	return render(request, 'bilgi.tpl')

@login_required()   
def betikCalistir(request):
	if(request.method=='POST'):
		betik = request.POST['betik']
		parametreler = ""
		for key in request.POST.keys():
			if  "-" in key :
				parametreler += " " + key + " " + request.POST[key]
		if betik:	
			sunucu = Baglanti.objects.all()[0].sunucu
			kullanici = Baglanti.objects.all()[0].kullanici
			sifre = Baglanti.objects.all()[0].sifre
			
			ssh = SSH(hostname=sunucu, username=kullanici, password=sifre)
			betikYol = os.getcwd() + '/komutaModul/betikler/' + betik
			print(betikYol)
			ssh.put(betikYol,'/tmp/'+betik)
			if 'sudo' in request.POST.keys():
				stream = ssh.sudo("bash " + "/tmp/" + betik + parametreler)
			else:
				stream = ssh.run("bash " + "/tmp/" + betik + parametreler)
			response = StreamingHttpResponse(stream, status=200, content_type='text/event-stream')
			response['Cache-Control'] = 'no-cache'
			return response
