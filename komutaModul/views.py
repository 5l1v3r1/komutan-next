import os, git, distutils.dir_util
from django.shortcuts import render
from django.http import HttpResponse, StreamingHttpResponse
from django.contrib.auth.decorators import login_required
from .models import Betikler, Parametreler, GitDepo
from cekirdek.models import Baglanti
from cekirdek.utils import SSHelper as SSH


@login_required()
def komutaModulGoster(request):
	betikler = os.listdir(os.curdir + '/komutaModul/betikler/')
	if 'betik' in request.GET.keys():
		f = open(os.curdir + '/komutaModul/betikler/' + request.GET['betik'], 'r')
		parametreler = f.readline()
		betik = request.GET['betik']
		if parametreler[0] == "#":
			parametreler = parametreler.replace('#','').replace('\n','').split('|')
			d = dict()
			for parametre in parametreler:
				parametre = parametre.split(':')
				if Parametreler.objects.filter(betik__betik=betik,parametre=parametre[0]).count() == 1:
					parametre[2] = Parametreler.objects.filter(betik__betik=betik,parametre=parametre[0])[0].deger
				d.update({parametre[0]:[parametre[1],parametre[2]]})
			parametreler = d
			return render(request, 'komutaModul/index.tpl', {"betikler":betikler,"betik":betik,"parametreler":parametreler})

		else:
			return render(request, 'komutaModul/index.tpl', {"betikler":betikler,"betik":betik})
	else:
		return render(request, 'komutaModul/index.tpl', {"betikler":betikler})

@login_required()   
def betikCalistir(request):
	if(request.method=='POST'):
		print(request.POST)
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
	else:
		return HttpResponse("Bu fonksiyon sadece POST methodu ile çalışır.",'text/plain; charset=utf-8')
@login_required()
def parametreKaydet(request):
	if(request.method=='POST'):
		betik = request.POST['betik']
		parametre = request.POST['parametre']
		parametreBaslik = request.POST['parametreBaslik']
		deger = request.POST['deger']
		if Betikler.objects.filter(betik=betik).count() == 0:
			Betikler.objects.create(betik=betik)

		Betik = Betikler.objects.filter(betik=betik)[0]
		eskiKayit = Parametreler.objects.filter(betik = Betik, parametre = parametre)
		if eskiKayit.count() == 1:
			eskiKayit.delete()
		Parametre = Parametreler(betik = Betik, parametre = parametre, parametreBaslik = parametreBaslik, deger = deger)
		Parametre.save()
		return HttpResponse("Parametre Kaydedildi",'text/plain; charset=utf-8')
	else:
		return HttpResponse("Bu fonksiyon sadece POST methodu ile çalışır.",'text/plain; charset=utf-8')

@login_required()
def gitGuncelle(request):
	depolar = GitDepo.objects.all()
	for depo in depolar:
		git.Repo.clone_from(depo.adres,'komutaModul/betikler/geciciDepo')
		distutils.dir_util.remove_tree('komutaModul/betikler/geciciDepo/.git')
		distutils.dir_util.copy_tree('komutaModul/betikler/geciciDepo','komutaModul/betikler/')
		distutils.dir_util.remove_tree('komutaModul/betikler/geciciDepo/')
	return HttpResponse("Betik Deposu güncellendi ! <br>Yeni betikleri görebilmek için sayfayı yenileyiniz. ",'text/plain; charset=utf-8')
	
@login_required()
def betikEkle(request):
	if(request.method=='POST'):
		betik = request.POST['betikAdi']
		kod = request.POST['betikKodu']
		f = open(os.curdir + '/komutaModul/betikler/' + betik,'w')
		f.writelines(kod)
		return render(request, 'komutaModul/betikekle.tpl', {"basarili":True})
	return render(request, 'komutaModul/betikekle.tpl')

@login_required()
def betikDuzenle(request):
	betikler = os.listdir(os.curdir + '/komutaModul/betikler/')
	if(request.method=='POST'):
		betik = request.POST['betikAdi']
		kod = request.POST['betikKodu']
		f = open(os.curdir + '/komutaModul/betikler/' + betik,'w')
		f.writelines(kod)
		return render(request, 'komutaModul/betikduzenle.tpl', {"basarili":True})	
	if 'betik' in request.GET.keys():
		betik = request.GET['betik']
		print(request.GET.keys())
		f = open(os.curdir + '/komutaModul/betikler/' + betik, 'r')
		kod = f.read()
		return render(request, 'komutaModul/betikduzenle.tpl', {"betikler":betikler,"betik":betik,"kod":kod})
	return render(request, 'komutaModul/betikduzenle.tpl', {"betikler":betikler})


@login_required()
def betikSil(request):
	betikler = os.listdir(os.curdir + '/komutaModul/betikler/')
	if(request.method=='POST'):
		betik = request.POST['betikAdi']
		if betik in betikler: #Güvenlik tedbiri
			os.remove(os.curdir + '/komutaModul/betikler/' + betik)
			return render(request, 'komutaModul/betiksil.tpl', {"basarili":True})	
	return render(request, 'komutaModul/betiksil.tpl', {"betikler":betikler})
