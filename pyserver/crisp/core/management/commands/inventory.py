import os
import json
import datetime
import moment
from decimal import *
from django.contrib.auth.models import User
from django.core.management.base import BaseCommand, CommandError
from crisp.core.models import Coupon, CouponChange, Customer, ProductGroup, Product, Supplier, Arrival, Sale, SaleItem, ReturnItem
from collections import defaultdict, namedtuple


class Stat:
    def __init__(self):
        self.amount = 0
        self.cost = 0
        self.sale = 0


class Command(BaseCommand):
    help = 'generates inventory report'

    def add_arguments(self, parser):
        parser.add_argument('file', nargs='+')

    def handle(self, *args, **options):
        filepath = options['file'][0]
        suppliers = defaultdict(lambda: Stat())
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                if line and line != '\n':
                    id = line.rstrip()
                    try:
                        product = Product.objects.get(id=id)
                        stat = suppliers[product.supplier.name]
                        stat.amount += 1
                        stat.cost += product.cost
                        stat.sale += product.sale
                    except Product.DoesNotExist:
                        print('id not found', id)
        for supplier, stat in suppliers.items():
            print("%s,%s,%s,%s" % (supplier, stat.amount, stat.cost, stat.sale))
