from .coupon import CouponChange, Coupon
from .customer import Customer
from .product_group import ProductGroup
from .product import Product
from .sale import Sale, SaleItem
from .supplier import Supplier


__all__ = [
    'Customer',
    'Supplier',
    'ProductGroup',
    'Product',
    'Coupon',
    'CouponChange',
    'Sale',
    'SaleItem'
]

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
