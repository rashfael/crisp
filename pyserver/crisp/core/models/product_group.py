from django.db import models


class ProductGroup(models.Model):
    name = models.CharField(max_length=255)
