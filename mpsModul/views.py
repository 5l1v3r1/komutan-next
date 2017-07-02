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
		print(pn.split("|"))
		d['isim'] = pn.split("|")[0]
		d['surum'] = pn.split("|")[1]
		d['url'] = pn.split("|")[2]
		d['aciklama'] = pn.split("|")[3]
		if pn.split("|")[4] == "True":
			d['kurulu'] = True
		elif pn.split("|")[4] == "False":
			d['kurulu'] = False
		lst.append(d)

	return render(request, 'mpsModul/index.tpl', {"lst":lst})
	
