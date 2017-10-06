from django.contrib import admin

from .models import (
    Coupon,
    Customer,
    ProductGroup,
    Product,
    Sale,
    Supplier
)
# Register your models here.
admin.site.register(Coupon)
admin.site.register(Customer)
admin.site.register(ProductGroup)
admin.site.register(Product)
admin.site.register(Sale)
admin.site.register(Supplier)
