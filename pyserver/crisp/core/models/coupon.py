from django.db import models


class CouponChange(models.Model):
    coupon = models.ForeignKey('Coupon', related_name='changes')
    sale = models.ForeignKey('Sale', null=True, related_name='coupon_items')
    value_change = models.DecimalField(max_digits=8, decimal_places=2)
    date = models.DateTimeField(auto_now_add=True)


class Coupon(models.Model):
    pass
    # value?
