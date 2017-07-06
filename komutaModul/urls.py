"""
Komuta Merkezi URL Yapılandırması
"""
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.komutaModulGoster),
    url(r'^betikCalistir/$', views.betikCalistir),
    url(r'^parametreKaydet/$', views.parametreKaydet),
    url(r'^gitGuncelle/$', views.gitGuncelle),
    url(r'^betikEkle/$', views.betikEkle),
    url(r'^betikDuzenle/$', views.betikDuzenle),
    url(r'^betikSil/$', views.betikSil),
]    
