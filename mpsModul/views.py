from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from cekirdek.models import Baglanti
from fabric.api import *
import os

@login_required()
def mpsModulGoster(request):
	env.host_string = Baglanti.objects.all()[0].sunucu
	env.user = Baglanti.objects.all()[0].kullanici
	env.password = Baglanti.objects.all()[0].sifre
	with hide('output','running'), cd('/tmp'):
		betikYol = os.getcwd() + '/mpsModul/paketListe.py'
		put(betikYol,'/tmp')
		sudo('python3 /tmp/paketListe.py')
		if not os.path.isdir("/tmp/gecici"):
			os.mkdir("/tmp/gecici")
		get("/tmp/paketliste", "/tmp/gecici/")
	with open("/tmp/gecici/paketliste") as f:
		satirlar = f.readlines()
	lst = []
	for pn in satirlar:
		d = {}
		d['isim'] = pn.split("|")[0]
		d['surum'] = pn.split("|")[1]
		d['url'] = pn.split("|")[2]
		d['aciklama'] = pn.split("|")[3]
		if pn.split("|")[4] == "True\n":
			d['kurulu'] = True
		elif pn.split("|")[4] == "False\n":
			d['kurulu'] = False
		lst.append(d)

	return render(request, 'mpsModul/index.tpl', {"lst":lst})

@login_required()
def paketKurGoster(request, paket):
	if paket:
		return render(request, 'mpsModul/kurlog.tpl', {"paket":paket})
	else: 
		return HttpResponse("Paket değişkeni eksik. Örnek kullanım: /mpsModul/kur/firefox",'text/plain; charset=utf-8')
	
@login_required()
def paketKur(request, paket):
	env.host_string = Baglanti.objects.all()[0].sunucu
	env.user = Baglanti.objects.all()[0].kullanici
	env.password = Baglanti.objects.all()[0].sifre
	if paket:
		with hide('output','running'), cd('/tmp'):
			cikti = sudo('mps kur ' + paket)
			cikti = cikti.replace('[0;39m','</span>')
			cikti = cikti.replace('[1;31m','<span style="color:red; font-weight:bold;">')
			cikti = cikti.replace('[1;32m','<span style="color:green; font-weight:bold;">')
			cikti = cikti.replace('[1;33m','<span style="color:orange; font-weight:bold;">')
			cikti = cikti.replace('[1;34m','<span style="color:blue; font-weight:bold;">')
			cikti = cikti.replace('[1;35m','<span style="color:purple; font-weight:bold;">')
			return HttpResponse(cikti,'text/plain; charset=utf-8')
	else: 
		return HttpResponse("Paket değişkeni eksik. Örnek kullanım: /mpsModul/kur/firefox/islem/",'text/plain; charset=utf-8')
		
@login_required()
def paketSilGoster(request, paket):
	if paket:
		return render(request, 'mpsModul/sillog.tpl', {"paket":paket})
	else: 
		return HttpResponse("Paket değişkeni eksik. Örnek kullanım: /mpsModul/sil/firefox",'text/plain; charset=utf-8')
				
@login_required()
def paketSil(request, paket):
	env.host_string = Baglanti.objects.all()[0].sunucu
	env.user = Baglanti.objects.all()[0].kullanici
	env.password = Baglanti.objects.all()[0].sifre
	if paket:
		with hide('output','running'), cd('/tmp'):
			cikti = sudo('mps -sz ' + paket)
			cikti = cikti.replace('[0;39m','</span>')
			cikti = cikti.replace('[1;31m','<span style="color:red; font-weight:bold;">')
			cikti = cikti.replace('[1;32m','<span style="color:green; font-weight:bold;">')
			cikti = cikti.replace('[1;33m','<span style="color:orange; font-weight:bold;">')
			cikti = cikti.replace('[1;34m','<span style="color:blue; font-weight:bold;">')
			cikti = cikti.replace('[1;35m','<span style="color:purple; font-weight:bold;">')
			return HttpResponse(cikti,'text/plain; charset=utf-8')
	else: 
		return HttpResponse("Paket değişkeni eksik. Örnek kullanım: /mpsModul/sil/firefox/islem",'text/plain; charset=utf-8')
