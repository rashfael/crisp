from rest_framework import (
    serializers,
    viewsets,
    filters,
)
from rest_framework.decorators import action
from rest_framework.response import Response
from django.db.models import Avg, Count, Min, Sum

from ..core.models import (Sale, SaleItem, ReturnItem, Coupon, CouponChange)


class CouponItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = CouponChange
        fields = ('coupon', 'value_change', 'date')


class SaleItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = SaleItem
        fields = ('id', 'product', 'price', 'discount', 'amount', 'product_name')
        read_only_fields = ('id', 'product_name')
    product_name = serializers.SerializerMethodField()

    def get_product_name(self, sale_item):
        return sale_item.product.name


class ReturnItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReturnItem
        fields = ('returned_item', 'price', 'amount', 'sale', 'product', 'product_name')
        read_only_fields = ('sale', 'product', 'product_name')

    product = serializers.SerializerMethodField()
    product_name = serializers.SerializerMethodField()

    def get_product(self, return_item):
        return return_item.returned_item.product.id

    def get_product_name(self, return_item):
        return return_item.returned_item.product.name


class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sale
        fields = ('id', 'date', 'customer', 'payment_method', 'price', 'discount', 'return_items', 'sale_items', 'coupon_items', 'customer_name', 'user')
        read_only_fields = ('id', 'date', 'user')
    sale_items = SaleItemSerializer(many=True)
    coupon_items = CouponItemSerializer(many=True)
    return_items = ReturnItemSerializer(many=True)
    customer_name = serializers.SerializerMethodField()
    user = serializers.PrimaryKeyRelatedField(read_only=True, default=serializers.CurrentUserDefault())

    def get_customer_name(self, sale):
        return ' '.join([sale.customer.forename, sale.customer.name])

    def create(self, validated_data):
        sale_items_data = validated_data.pop('sale_items')
        return_items_data = validated_data.pop('return_items')
        coupon_items_data = validated_data.pop('coupon_items')
        sale = Sale.objects.create(user=self.context['request'].user, **validated_data)
        for return_item_data in return_items_data:
            ReturnItem.objects.create(sale=sale, **return_item_data)
        for sale_item_data in sale_items_data:
            SaleItem.objects.create(sale=sale, **sale_item_data)
        for coupon_item_data in coupon_items_data:
            CouponChange.objects.create(coupon=coupon_item_data['coupon'], sale=sale, value_change=coupon_item_data['value_change'])
        return sale


class SaleView(viewsets.ModelViewSet):
    queryset = Sale.objects.all()
    serializer_class = SaleSerializer
    filter_backends = (filters.SearchFilter, filters.OrderingFilter)
    search_fields = ('id',)
    ordering = ('-id',)
    # filter_fields = ('sale_items__product')
    http_method_names = ['get', 'post', 'head']

    @action(methods=['get'], detail=False)
    def statistics(self, request, pk=None):
        start = request.query_params['start']
        end = request.query_params['end']
        totals = Sale.objects.filter(date__range=[start, end]).aggregate(Sum('price'))
        stats = SaleItem.objects.filter(sale__date__range=[start, end]).values('product__id', 'product__name', 'product__supplier__id').annotate(Sum('price'), Sum('amount'))
        return Response({
            'totals': totals,
            'sales': stats
        })
        # product = self.get_object()
        # serializer = ArrivalSerializer(data=request.data)
        # if serializer.is_valid():
        #     arrival = Arrival.objects.create(product=product, **serializer.data)
        #     arrival.save()
        #     serializer = ArrivalSerializer(arrival)
        #     return Response(serializer.data)
        # else:
        #     return Response(serializer.errors,
        #                     status=status.HTTP_400_BAD_REQUEST)
