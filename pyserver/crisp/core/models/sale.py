from django.db import models
from django.conf import settings

class SaleItem(models.Model):
    product = models.ForeignKey('Product')
    sale = models.ForeignKey('Sale', related_name='sale_items')
    # includes item discount, global discount, and amount
    price = models.DecimalField(max_digits=8, decimal_places=2)
    discount = models.DecimalField(max_digits=8, decimal_places=5)
    amount = models.IntegerField()


class ReturnItem(models.Model):
    returned_item = models.ForeignKey('SaleItem')
    sale = models.ForeignKey('Sale', related_name='return_items')
    price = models.DecimalField(max_digits=8, decimal_places=2)
    amount = models.IntegerField()


class Sale(models.Model):
    EC = 'ec'
    BAR = 'cash'
    PAYMENT_METHOD_CHOICES = (
        (EC, 'ec'),
        (BAR, 'cash')
    )
    customer = models.ForeignKey('Customer')
    user = models.ForeignKey(settings.AUTH_USER_MODEL)
    payment_method = models.CharField(max_length=4, choices=PAYMENT_METHOD_CHOICES)
    price = models.DecimalField(max_digits=8, decimal_places=2)  # includes discount
    discount = models.DecimalField(max_digits=8, decimal_places=5)
    date = models.DateTimeField(auto_now_add=True)
