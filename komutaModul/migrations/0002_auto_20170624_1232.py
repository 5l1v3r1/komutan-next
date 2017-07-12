# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-24 12:32
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('komutaModul', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='GitDepo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('isim', models.CharField(default='Depo', max_length=50, verbose_name='Betiğin aldığı parametre')),
                ('adres', models.URLField(verbose_name='Git Depo Adresi')),
            ],
            options={
                'verbose_name_plural': 'Git Depo Ayarları',
                'verbose_name': 'Git Depo Ayarı',
                'db_table': 'BetikDepo',
            },
        ),
        migrations.AlterModelOptions(
            name='parametreler',
            options={'ordering': ('parametre',), 'verbose_name': 'Parametre', 'verbose_name_plural': 'Parametreler'},
        ),
        migrations.AlterField(
            model_name='betikler',
            name='betik',
            field=models.CharField(default='', max_length=50, verbose_name='Betiğin Dosya Adı'),
        ),
        migrations.AlterField(
            model_name='parametreler',
            name='deger',
            field=models.CharField(default='', max_length=50, verbose_name='Parametrenin aldığı varsayılan değer'),
        ),
        migrations.AlterField(
            model_name='parametreler',
            name='parametre',
            field=models.CharField(default='', max_length=12, verbose_name='Betiğin aldığı parametre'),
        ),
        migrations.AlterField(
            model_name='parametreler',
            name='parametreBaslik',
            field=models.CharField(default='', editable=False, max_length=50),
        ),
        migrations.AlterModelTable(
            name='parametreler',
            table='BetikParametreler',
        ),
    ]
