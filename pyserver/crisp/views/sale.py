from rest_framework import (
    serializers,
    viewsets,
)

from ..core.models import (Sale, SaleItem)


class SaleItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = SaleItem
        fields = "__all__"


class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sale
        fields = "__all__"
    sale_items = SaleItemSerializer(many=True)


class SaleView(viewsets.ModelViewSet):
    queryset = Sale.objects.all()
    serializer_class = SaleSerializer
