from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from markdown2 import markdown_path as parseMarkdown
import os

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
	html = parseMarkdown(os.curdir + '/rehberModul/dokumanlar/' + dokuman + ".md", extras=["metadata", "fenced-code-blocks","tables","break-on-newline"],)
	return render(request, 'rehberModul/goster.tpl', {"html":html})