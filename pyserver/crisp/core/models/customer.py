from django.db import models


class Customer(models.Model):
    name = models.CharField(max_length=255)
    forename = models.CharField(max_length=255, blank=True)
    title = models.CharField(max_length=255, blank=True)
    street = models.CharField(max_length=255, blank=True)
    zip = models.CharField(max_length=255, blank=True)
    place = models.CharField(max_length=255, blank=True)
    tel = models.CharField(max_length=255, blank=True)
    email = models.CharField(max_length=255, blank=True)
    birthday = models.DateField(null=True)
    customer_since = models.DateTimeField(auto_now_add=True)
    notes = models.TextField(blank=True)
