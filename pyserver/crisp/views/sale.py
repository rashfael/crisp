from rest_framework import (
    serializers,
    viewsets,
    filters,
)

from ..core.models import (Sale, SaleItem)


class SaleItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = SaleItem
        fields = ('id', 'product', 'price', 'discount', 'amount')
        read_only_fields = ('id',)

class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sale
        fields = ('id', 'date', 'customer', 'payment_method', 'price', 'discount', 'sale_items')
        read_only_fields = ('id', 'date')
    sale_items = SaleItemSerializer(many=True)

    def create(self, validated_data):
        sale_items_data = validated_data.pop('sale_items')
        sale = Sale.objects.create(**validated_data)
        for sale_item_data in sale_items_data:
            SaleItem.objects.create(sale=sale, **sale_item_data)
        return sale


class SaleView(viewsets.ModelViewSet):
    queryset = Sale.objects.all()
    serializer_class = SaleSerializer
    filter_backends = (filters.SearchFilter,)
    search_fields = ('id',)
