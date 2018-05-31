# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2018-05-27 20:26
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_returnitem_returned_item'),
    ]

    operations = [
        migrations.AlterField(
            model_name='arrival',
            name='date',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AlterField(
            model_name='arrival',
            name='product',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='arrivals', to='core.Product'),
        ),
        migrations.AlterField(
            model_name='couponchange',
            name='coupon',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='changes', to='core.Coupon'),
        ),
        migrations.AlterField(
            model_name='couponchange',
            name='date',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AlterField(
            model_name='couponchange',
            name='sale',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='coupon_items', to='core.Sale'),
        ),
        migrations.AlterField(
            model_name='customer',
            name='customer_since',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AlterField(
            model_name='product',
            name='product_group',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='core.ProductGroup'),
        ),
        migrations.AlterField(
            model_name='product',
            name='supplier',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='core.Supplier'),
        ),
        migrations.AlterField(
            model_name='returnitem',
            name='returned_item',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='core.SaleItem'),
        ),
        migrations.AlterField(
            model_name='sale',
            name='customer',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='sale_customer', to='core.Customer'),
        ),
        migrations.AlterField(
            model_name='sale',
            name='date',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AlterField(
            model_name='sale',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='saleitem',
            name='product',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='product_sale', to='core.Product'),
        ),
    ]