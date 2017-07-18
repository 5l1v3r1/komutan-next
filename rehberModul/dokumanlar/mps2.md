---
Başlık: Milis Paket Sistemi Kullanma-2
Yazar: Mahmut Şamil
Tarih: 18/07/2017
anahtar_kelimeler: mps, paket, program kurma, kaldırma
---

# API Parametreler

Milis Paket Sistemi (MPS) Bash tabanlıdır ve modüler şekilde tasarlanmıştır. Yani her bir işlevi yerine getiren bağımsız bir modül vardır ve bir modül diğer modülleri geliştirmek için kullanılabilir. 
Bu modüller sistemde kayıtlı parametreleri kullanılarak döngülü olarak çağırılırlar. 
Modülleri çağıran parametrelere "API Parametreler" adı verilir ve tire işaretiyle başladığından son kullanıcı parametrelerinden ayrılırlar. 
Bu parametreleri geliştirme dışında ileri kullanım ya da hata ayıklama amacı ile de kullanabilirsiniz.

Aşağıda bazı API Parametreleri ve kullanımlarını görebilirsiniz:

| Komut                     | Açıklama                                   |
|---------------------------|--------------------------------------------|
| `mps -G`                  | İkili paket veritabanini gunceller                          |
| `mps -GG`          | Git sunucusundan talimatname ve sistem günceller                                |
| `mps -k paketadi.mps.lz` | Yereldeki paketi bagimliliksiz kurar            |                  |
| `mps -S paketadi`        | İlgili paketin ana bağımlılıklarını siler.(masaüstü veya blok programları kaldırmak için)                   |
| `mps -kl`        | Kurulu paket listesini verir |
| `mps -kk paketadi`        | İlgili paketin kurulu olma durumunu verir |
| `mps -sun`        | Güncel paket deposu adresini gösterir |
| `mps sun [sunucu]`        | Paket deposu adresi gösterir ve değiştirir |
| `mps -kk paketadi`        | Paketin kurulu olma durumunu gösterir      |
| `mps -g paketadi`         | Seçilen paketi günceller                   |
| `mps -go paketadi`         | İlgili paketi tüm bağımlılıklarıyla günceller                  |
| `mps -GS`                 | Sistem genelinde güncelleme                |
| `mps -d paketadi`                 | İlgili paketin talimat dosyasına göre bağımlıksız derler,paketler               |
| `mps -derle paketadi`                 | İlgili paketin talimat dosyasına göre bağımlıklarıyla derler,paketler             |
| `mps odkp paketadi`                 | İlgili paketin talimat dosyasına göre bağımlıkları kontrol eder kurar olmayanı paketler             |
| `mps -tro`                 | Paket veritabanı için durum noktası oluşturur             |

