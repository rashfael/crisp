from rest_framework import (
    serializers,
    viewsets,
    filters,
)

from ..core.models import Customer
from .sale import SaleSerializer


class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ('name', 'forename', 'title', 'street', 'zip', 'place', 'tel', 'email', 'birthday', 'customer_since', 'notes', 'sales')
    sales = SaleSerializer(many=True, read_only=True, source='sale_customer')


class CustomerView(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer
    filter_backends = (filters.SearchFilter, filters.OrderingFilter)
    search_fields = ('id', 'name', 'forename')
    ordering = ('id',)
