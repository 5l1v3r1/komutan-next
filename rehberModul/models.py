from django.db import models

class GitDepo(models.Model):
	isim = models.CharField(max_length=50, default="Rehber Deposu ")
	adres = models.URLField(verbose_name='Git Depo Adresi')

	class Meta:
		db_table = "RehberDepo"
		verbose_name = "Git Depo Ayarı"
		verbose_name_plural = "Git Depo Ayarları"

	def __str__(self):
		return self.isim
