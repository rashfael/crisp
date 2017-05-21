from django.db import models


class Product(models.Model):
    id = models.CharField(max_length=255, primary_key=True)
    name = models.CharField(max_length=255)
    productGroup = models.ForeignKey('ProductGroup')
    supplier = models.ForeignKey('Supplier')
    supplierProductId = models.CharField(max_length=255)
    printerline1 = models.CharField(max_length=255)
    printerline1 = models.CharField(max_length=255)
    cost = models.DecimalField(max_digits=8, decimal_places=2)
    sale = models.DecimalField(max_digits=8, decimal_places=2)
    # stock
    # arrivals
    # transfers
