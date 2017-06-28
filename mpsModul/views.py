from django.shortcuts import render
from django.contrib.auth.decorators import login_required
import json
from django.http import HttpResponse

@login_required()
def mpsModulGoster(request):
	return render(request, 'mpsModul/index.tpl')


@login_required()
def paketListeAl(request):	
	paketvt="/depo/paketler/paket.vt"
	with open(paketvt) as f:
		satirlar = f.readlines()
	lst = []
	for pn in satirlar:
		d = {}
		d['isim']=pn.split()[0]
		lst.append(d)
	print(lst)
	if lst:
		return HttpResponse(json.dumps(lst), content_type="application/json")
	else:
		return HttpResponse(json.dumps(lst), content_type="application/json")
	
