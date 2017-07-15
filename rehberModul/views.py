from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from markdown2 import markdown_path as parseMarkdown
from .models import GitDepo
import os, git, distutils.dir_util

@login_required()
def rehberGoster(request):
	dokumanlar = {}
	dosyalar = os.listdir(os.curdir + '/rehberModul/dokumanlar/')
	for dosya in dosyalar:
		if ".md" in dosya:
			meta = parseMarkdown(os.curdir + '/rehberModul/dokumanlar/' + dosya, extras=["metadata"]).metadata
			if meta:		
				dokumanlar[dosya] = meta
			else:
				dokumanlar[dosya] = {"Başlık":dosya}
	return render(request, 'rehberModul/index.tpl',{"dokumanlar":dokumanlar})

@login_required()
def dokumanGoster(request, dokuman):
	if dokuman in os.listdir(os.curdir + '/rehberModul/dokumanlar/'):
		html = parseMarkdown(os.curdir + '/rehberModul/dokumanlar/' + dokuman, extras=["metadata", "fenced-code-blocks","tables","break-on-newline"],)
	return render(request, 'rehberModul/goster.tpl', {"html":html})

@login_required()
def gitGuncelle(request):
	depolar = GitDepo.objects.all()
	for depo in depolar:
		git.Repo.clone_from(depo.adres,'rehberModul/dokumanlar/geciciDepo')
		distutils.dir_util.remove_tree('rehberModul/dokumanlar/geciciDepo/.git')
		distutils.dir_util.copy_tree('rehberModul/dokumanlar/geciciDepo','rehberModul/dokumanlar/')
		distutils.dir_util.remove_tree('rehberModul/dokumanlar/geciciDepo/')
	return HttpResponse("Rehber Deposu güncellendi ! \nYeni dokumanları görebilmek için sayfayı yenileyiniz. ",'text/plain; charset=utf-8')

@login_required()
def dokumanEkle(request):
	if(request.method=='POST'):
		dokuman = request.POST['dokumanAdi']
		kod = request.POST['markdownKodu']
		f = open(os.curdir + '/rehberModul/dokumanlar/' + dokuman,'w')
		f.writelines(kod)
		return render(request, 'rehberModul/dokumanekle.tpl', {"basarili":True})
	return render(request, 'rehberModul/dokumanekle.tpl')
