"""
Milis Yazılım Merkezi URL Yapılandırması
"""
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.mpsModulGoster),
    url(r'^kur/(?P<paket>[-\w]+)/$', views.paketKurGoster),
    url(r'^kur/(?P<paket>[-\w]+)/islem/$', views.paketKur),
    url(r'^sil/(?P<paket>[-\w]+)/$', views.paketSilGoster),
    url(r'^sil/(?P<paket>[-\w]+)/islem/$', views.paketSil),
]    
