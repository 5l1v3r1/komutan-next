"""
Rehber URL Yapılandırması
"""
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.rehberGoster),
    url(r'^(?P<dokuman>[-_\w]+).md$', views.dokumanGoster),
]    