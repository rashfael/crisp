from django.db import models


class Customer(models.Model):
    name = models.CharField(max_length=255)
    forename = models.CharField(max_length=255)
    title = models.CharField(max_length=255)
    street = models.CharField(max_length=255)
    zip = models.CharField(max_length=255)
    place = models.CharField(max_length=255)
    tel = models.CharField(max_length=255)
    email = models.CharField(max_length=255)
    birthday = models.DateField()
    customer_since = models.DateTimeField(auto_now_add=True)
    notes = models.TextField()
