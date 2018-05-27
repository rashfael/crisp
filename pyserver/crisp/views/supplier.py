from rest_framework import (
    serializers,
    viewsets,
    pagination,
)

from ..core.models import Supplier, Sale, SaleItem
from django.db.models import Avg, Count, Min, Sum
from django.db.models.functions import TruncMonth

class SupplierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = "__all__"


class LargeResultsSetPagination(pagination.CursorPagination):
    page_size = 1000
    page_size_query_param = 'page_size'
    max_page_size = 10000


class SingleSupplierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = ('id', 'name', 'name2', 'street', 'zip', 'place', 'tel', 'tel2', 'fax', 'email', 'notes', 'total_sales', 'monthly_sales')
    total_sales = serializers.SerializerMethodField()
    monthly_sales = serializers.SerializerMethodField()

    def get_total_sales(self, supplier):
        return SaleItem.objects.filter(product__supplier=supplier).aggregate(Sum('price'))['price__sum']

    def get_monthly_sales(self, supplier):
        return SaleItem.objects.filter(product__supplier=supplier).annotate(month=TruncMonth('sale__date')).values('month').annotate(Sum('price')).order_by('-month')


class SupplierView(viewsets.ModelViewSet):
    queryset = Supplier.objects.all()
    serializer_class = SupplierSerializer
    ordering = ('id',)
    pagination_class = LargeResultsSetPagination

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return SingleSupplierSerializer
        return SupplierSerializer
