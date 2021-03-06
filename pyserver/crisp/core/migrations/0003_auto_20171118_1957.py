# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2017-11-18 19:57
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_auto_20171031_1420'),
    ]

    operations = [
        migrations.CreateModel(
            name='Arrival',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('amount', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='ReturnItem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('amount', models.IntegerField()),
                ('sale', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='return_items', to='core.Sale')),
            ],
        ),
        migrations.RenameField(
            model_name='product',
            old_name='productGroup',
            new_name='product_group',
        ),
        migrations.RemoveField(
            model_name='product',
            name='supplierProductId',
        ),
        migrations.AddField(
            model_name='product',
            name='printerline2',
            field=models.CharField(blank=True, max_length=255),
        ),
        migrations.AddField(
            model_name='product',
            name='supplier_product_id',
            field=models.CharField(blank=True, max_length=255),
        ),
        migrations.AlterField(
            model_name='product',
            name='printerline1',
            field=models.CharField(blank=True, max_length=255),
        ),
        migrations.AlterField(
            model_name='saleitem',
            name='sale',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sale_items', to='core.Sale'),
        ),
        migrations.AddField(
            model_name='arrival',
            name='product',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Product'),
        ),
    ]
