from rest_framework import (
    serializers,
    viewsets,
)

from ..core.models import Supplier


class SupplierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = "__all__"


class SupplierView(viewsets.ModelViewSet):
    queryset = Supplier.objects.all()
    serializer_class = SupplierSerializer
    http_method_names = ['get', 'post', 'head']
