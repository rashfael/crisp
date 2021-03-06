# -*- coding: utf-8 -*-
# Generated by Django 1.11.1 on 2017-05-21 12:41
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Coupon',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.CreateModel(
            name='CouponChange',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('value_change', models.DecimalField(decimal_places=2, max_digits=8)),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('coupon', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Coupon')),
            ],
        ),
        migrations.CreateModel(
            name='Customer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('forename', models.CharField(max_length=255)),
                ('title', models.CharField(max_length=255)),
                ('street', models.CharField(max_length=255)),
                ('zip', models.CharField(max_length=255)),
                ('place', models.CharField(max_length=255)),
                ('tel', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255)),
                ('birthday', models.DateField()),
                ('customer_since', models.DateTimeField(auto_now_add=True)),
                ('notes', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.CharField(max_length=255, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=255)),
                ('supplierProductId', models.CharField(max_length=255)),
                ('printerline1', models.CharField(max_length=255)),
                ('cost', models.DecimalField(decimal_places=2, max_digits=8)),
                ('sale', models.DecimalField(decimal_places=2, max_digits=8)),
            ],
        ),
        migrations.CreateModel(
            name='ProductGroup',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Sale',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('payment_method', models.CharField(choices=[('ec', 'ec'), ('bar', 'bar')], max_length=3)),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('discount', models.DecimalField(decimal_places=5, max_digits=8)),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Customer')),
            ],
        ),
        migrations.CreateModel(
            name='SaleItem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('discount', models.DecimalField(decimal_places=5, max_digits=8)),
                ('amount', models.IntegerField()),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Product')),
                ('sale', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Sale')),
            ],
        ),
        migrations.CreateModel(
            name='Supplier',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('name2', models.CharField(max_length=255)),
                ('street', models.CharField(max_length=255)),
                ('zip', models.CharField(max_length=255)),
                ('place', models.CharField(max_length=255)),
                ('tel', models.CharField(max_length=255)),
                ('tel2', models.CharField(max_length=255)),
                ('fax', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255)),
                ('notes', models.TextField()),
            ],
        ),
        migrations.AddField(
            model_name='product',
            name='productGroup',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.ProductGroup'),
        ),
        migrations.AddField(
            model_name='product',
            name='supplier',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Supplier'),
        ),
        migrations.AddField(
            model_name='couponchange',
            name='sale',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.Sale'),
        ),
    ]
