from django.db import models


class SaleItem(models.Model):
    product = models.ForeignKey('Product')
    sale = models.ForeignKey('Sale')
    price = models.DecimalField(max_digits=8, decimal_places=2)
    discount = models.DecimalField(max_digits=8, decimal_places=5)
    amount = models.IntegerField()


class Sale(models.Model):
    EC = 'ec'
    BAR = 'bar'
    PAYMENT_METHOD_CHOICES = (
        (EC, 'ec'),
        (BAR, 'bar')
    )
    name = models.CharField(max_length=255)
    customer = models.ForeignKey('Customer')
    payment_method = models.CharField(max_length=3, choices=PAYMENT_METHOD_CHOICES)
    price = models.DecimalField(max_digits=8, decimal_places=2)
    discount = models.DecimalField(max_digits=8, decimal_places=5)
    date = models.DateTimeField(auto_now_add=True)
