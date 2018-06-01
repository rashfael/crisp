from rest_framework import (
    serializers,
    viewsets,
    filters,
    exceptions,
    status
)
from rest_framework.decorators import action
from rest_framework.response import Response

from ..core.models import Product, Arrival, SaleItem, Sale
from .sale import SaleSerializer


class ArrivalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Arrival
        fields = ('date', 'amount')


class SingleProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ('id', 'name', 'product_group', 'supplier', 'supplier_product_id', 'printerline1', 'printerline2', 'cost', 'sale', 'arrivals', 'sales')
    arrivals = ArrivalSerializer(many=True, read_only=True)
    sales = serializers.SerializerMethodField()

    def get_sales(self, product):
        sales = Sale.objects.filter(sale_items__product=product)
        return SaleSerializer(sales, many=True).data


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ('id', 'name', 'product_group', 'supplier', 'supplier_product_id', 'printerline1', 'printerline2', 'cost', 'sale')
    id = serializers.CharField(required=False, allow_null=True)

    def create(self, validated_data):
        if 'id' not in validated_data:
            ids = Product.objects.all().order_by('id').values('id')
            candidate = 1
            lowerIndex = 0
            id = None
            while candidate < 999999 and lowerIndex < len(ids):  # die at max id
                if len(ids[lowerIndex]['id']) != 6:  # discard non-barcode ids
                    lowerIndex += 1
                    continue
                if ids[lowerIndex]['id'] != str(candidate).zfill(6):
                    id = str(candidate).zfill(6)
                    break
                lowerIndex += 1
                candidate += 1
            if not id:
                raise exceptions.ValidationError('no id found')
            validated_data['id'] = id
        product = Product.objects.create(**validated_data)
        return product


class ProductView(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    filter_backends = (filters.SearchFilter, filters.OrderingFilter)
    search_fields = ('id', 'name', 'supplier_product_id', 'supplier__name')
    ordering = ('id',)

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return SingleProductSerializer
        return ProductSerializer

    @action(methods=['post'], detail=True)
    def arrival(self, request, pk=None):
        product = self.get_object()
        serializer = ArrivalSerializer(data=request.data)
        if serializer.is_valid():
            arrival = Arrival.objects.create(product=product, **serializer.data)
            arrival.save()
            serializer = ArrivalSerializer(arrival)
            return Response(serializer.data)
        else:
            return Response(serializer.errors,
                            status=status.HTTP_400_BAD_REQUEST)
