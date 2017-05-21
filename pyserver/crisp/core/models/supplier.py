from django.db import models


class Supplier(models.Model):
    name = models.CharField(max_length=255)
    name2 = models.CharField(max_length=255, blank=True)
    street = models.CharField(max_length=255, blank=True)
    zip = models.CharField(max_length=255, blank=True)
    place = models.CharField(max_length=255, blank=True)
    tel = models.CharField(max_length=255, blank=True)
    tel2 = models.CharField(max_length=255, blank=True)
    fax = models.CharField(max_length=255, blank=True)
    email = models.CharField(max_length=255, blank=True)
    notes = models.TextField(blank=True)
