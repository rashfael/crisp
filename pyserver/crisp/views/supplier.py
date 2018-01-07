from rest_framework import (
    serializers,
    viewsets,
    pagination,
)

from ..core.models import Supplier


class SupplierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = "__all__"


class LargeResultsSetPagination(pagination.CursorPagination):
    page_size = 1000
    page_size_query_param = 'page_size'
    max_page_size = 10000


class SupplierView(viewsets.ModelViewSet):
    queryset = Supplier.objects.all()
    serializer_class = SupplierSerializer
    http_method_names = ['get', 'post', 'head']
    ordering = ('id',)
    pagination_class = LargeResultsSetPagination
