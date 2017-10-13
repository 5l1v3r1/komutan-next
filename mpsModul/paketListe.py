import os
paketvt = "/depo/paketler/paket.vt"
talimatdizin = "/root/talimatname/"
ektalimatdizin = "/root/talimatlar/"

def talimatOku(paket):
	if os.path.isfile(talimatdizin + "genel/" + paket + "/talimat"):
		return open(talimatdizin + "genel/" + paket + "/talimat").readlines()[0:2]
	elif os.path.isfile(talimatdizin + "temel/" + paket + "/talimat"):
		return open(talimatdizin + "temel/" + paket + "/talimat").readlines()[0:2]
	elif os.path.isfile(talimatdizin + "onsistem/" + paket + "/talimat"):
		return open(talimatdizin + "onsistem/" + paket + "/talimat").readlines()[0:2]
	elif os.path.isfile(talimatdizin + "temel-ek/" + paket + "/talimat"):
		return open(talimatdizin + "temel-ek/" + paket + "/talimat").readlines()[0:2]
	else:
		return ["","#"]
		
with open(paketvt) as paketler:
	paketler = paketler.readlines()
lst = []
f = open("/tmp/paketliste","w")
for paket in paketler:
	isim = paket.split()[0]
	surum = paket.split()[2].split('#')[1].split('-')[0]
	aciklama = talimatOku(isim)[0].replace('#','').replace(':','').replace('=','').replace('Description','').replace('\n','')
	url = talimatOku(isim)[1].replace('# URL: ','').replace('#URL: ','').replace('# URL : ','').replace('\n','')
	kurulu = os.path.isdir("/var/lib/pkg/DB/" + isim)
	f.write(isim + "|" + surum + "|" + url + "|" + aciklama + "|" + str(kurulu) + "\n")
f.close()
	
