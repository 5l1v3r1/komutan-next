"""
Rehber URL Yapılandırması
"""
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.rehberGoster),
    url(r'^gitGuncelle/$', views.gitGuncelle),
    url(r'^dokumanEkle/$', views.dokumanEkle),
    url(r'^(?P<dokuman>[-_.\w]+)$', views.dokumanGoster),
]    