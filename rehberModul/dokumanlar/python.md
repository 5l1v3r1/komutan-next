---
Başlık: Python renklendirme denemesi
Yazar: Furkan Kalkan
Tarih: 12/07/2017
---

# Python Renklendirme Denemesi

GFM (Github Flavored Markdown) kullanarak örnek Python syntax renklendirmesi

```python
import random
n = random.randint(1, 99)
tahmin = int(raw_input("1 ile 99 arası sayı giriniz: "))
while n != "tahmin":
    print
    if tahmin < n:
        print "Tahmininiz aklımdan tuttuğum sayıdan küçük"
        tahmin = int(raw_input("1 ile 99 arası sayı giriniz: "))
    elif tahmin > n:
        print "Tahmininiz aklımdan tuttuğum sayıdan büyük"
        tahmin = int(raw_input("1 ile 99 arası sayı giriniz: "))
    else:
        print "Tebrikler, aklımdaki sayıyı bildiniz ! "
        break
    print

```
