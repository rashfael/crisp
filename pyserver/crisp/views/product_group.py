from rest_framework import (
    serializers,
    viewsets,
)

from ..core.models import ProductGroup


class ProductGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductGroup
        fields = "__all__"


class ProductGroupView(viewsets.ModelViewSet):
    queryset = ProductGroup.objects.all()
    serializer_class = ProductGroupSerializer
