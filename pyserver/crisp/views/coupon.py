from rest_framework import (
    serializers,
    viewsets,
    filters,
)

from ..core.models import Coupon, CouponChange, Sale

class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sale
        fields = ('id', 'date', 'customer', 'payment_method', 'price', 'discount')


class SingleCouponChangeSerializer(serializers.ModelSerializer):
    class Meta:
        model = CouponChange
        fields = ('sale', 'value_change', 'date')

    sale = serializers.SerializerMethodField()

    def get_sale(self, coupon_change):
        sale = Sale.objects.filter(coupon_items=coupon_change).first()
        return SaleSerializer(sale).data


class SingleCouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = ('id', 'changes')
    changes = SingleCouponChangeSerializer(many=True)


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

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return SingleCouponSerializer
        return CouponSerializer
