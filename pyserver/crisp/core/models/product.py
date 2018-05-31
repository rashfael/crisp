from django.db import models
from django.utils import timezone


class Arrival(models.Model):
    product = models.ForeignKey('Product', related_name='arrivals', on_delete=models.PROTECT)
    date = models.DateTimeField(default=timezone.now)
    amount = models.IntegerField()


class Product(models.Model):
    id = models.CharField(max_length=255, primary_key=True)
    name = models.CharField(max_length=255)
    product_group = models.ForeignKey('ProductGroup', on_delete=models.PROTECT)
    supplier = models.ForeignKey('Supplier', on_delete=models.PROTECT)
    supplier_product_id = models.CharField(max_length=255, blank=True)
    printerline1 = models.CharField(max_length=255, blank=True)
    printerline2 = models.CharField(max_length=255, blank=True)
    cost = models.DecimalField(max_digits=8, decimal_places=2)
    sale = models.DecimalField(max_digits=8, decimal_places=2)
    # stock
    # arrivals
    # transfers
