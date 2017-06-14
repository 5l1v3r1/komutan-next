# komutan-next
Komutan Web Yönetim Sistemi Yenileme Çalışması

## Bağımlılıklar
`
pip install django
`
## Uygulamayı deploy etme
```
git clone https://github.com/geekdinazor/komutan-next.git
cd komutan
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py createsuperuser
python3 manage.py runserver
```

## Modül ekleme
Sisteme **yeniModul** şeklinde bir modül eklemek için:

`
python3 manage.py startapp yeniModul`
`


## Yapılacaklar
- [X] Kullanıcı Girişi
- [ ] Varolan Modüllerin önyüzlerinin (frontend) oluşturulması
- [ ] admin panelinde gözükecek komutan tercihleri modülünün yazılması
- [ ] [Fabric](http://docs.fabfile.org/en/1.13/) modülü kullanılarak komut çatısının oluşturulması
- [ ] komutaModul modülünün yazılması
- [ ] mpsModul modülünün yazılması
- [ ] surecModul modülünün yazılması
- [ ] agModul modülünün yazılması
- [ ] servisModul modülünün yazılması
- [ ] komutanGuncelleModul modülünün yazılması
- [ ] ayarModul modülünün yazılması (Sistem Ayarları)
- [ ] Güvenlik önlemleri

