from rest_framework import (
    serializers,
    viewsets,
    filters,
)

from ..core.models import Coupon, CouponChange


class CouponChangeSerializer(serializers.ModelSerializer):
    class Meta:
        model = CouponChange
        fields = ('sale', 'value_change', 'date')


class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = ('id', 'changes')
    changes = CouponChangeSerializer(many=True)


class CouponView(viewsets.ModelViewSet):
    queryset = Coupon.objects.all()
    serializer_class = CouponSerializer
    filter_backends = (filters.SearchFilter, filters.OrderingFilter)
    search_fields = ('id',)
    ordering = ('-id',)
    http_method_names = ['get']
