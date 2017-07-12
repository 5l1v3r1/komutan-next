---
Başlık: Milis Paket Sistemi Kullanma
Yazar: Furkan Kalkan
Tarih: 11/07/2017
anahtar_kelimeler: mps, paket, program kurma, kaldırma
---

# Milis Paket Sistemi Kullanma Kılavuzu
Milis Paket Sistemi (MPS), Milis işletim sisteminin kendine özgü sıfırdan bash betik dilinde yazılmış paket yöneticisidir. MPS ile talimatnamedeki talimatları kullanarak paket üretebilir,paket kurabilir kaldırabilir ve güncelleyebilirsiniz.


## Temel Komutlar

| Komut                     | Açıklama                                   |
|---------------------------|--------------------------------------------|
| `mps guncelle`            | Sistem Günceller                           |
| `mps ara kelime`          | Paket arar                                 |
| `mps kur paketadi`        | Seçilen paketi kurar                       |
| `mps kur paketadi.mps.lz` | Paket dosyasından paket kurar              |
| `mps sil paketadi`        | Seçilen paketi kaldırır                    |
| `mps sun [sunucu]`        | Paket deposu adresi gösterir ve değiştirir |
| `mps -kk paketadi`        | Paketin kurulu olma durumunu gösterir      |
| `mps -g paketadi`         | Seçilen paketi günceller                   |
| `mps -GS`                 | Sistem genelinde güncelleme                |
