"""crisp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.contrib.auth.models import User
from rest_framework import routers, serializers, viewsets

from .views import (
    CouponView,
    CustomerView,
    ProductGroupView,
    ProductView,
    SaleView,
    SupplierView,
)

router = routers.DefaultRouter()
router.register(r'coupons', CouponView, base_name='coupon')
router.register(r'customers', CustomerView, base_name='customer')
router.register(r'product-groups', ProductGroupView, base_name='product-group')
router.register(r'products', ProductView, base_name='product')
router.register(r'sales', SaleView, base_name='sale')
router.register(r'suppliers', SupplierView, base_name='supplier')

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]
