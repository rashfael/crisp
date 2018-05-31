import os
import json
import datetime
import moment
from decimal import *
from django.contrib.auth.models import User
from django.core.management.base import BaseCommand, CommandError
from crisp.core.models import Coupon, CouponChange, Customer, ProductGroup, Product, Supplier, Arrival, Sale, SaleItem, ReturnItem
from django.db import transaction

def unfuckNumberLong(perhapsInt):
    if type(perhapsInt) is int:
        return perhapsInt
    else:
        return int(perhapsInt['$numberLong'])


class Command(BaseCommand):
    help = 'Imports mongodb json files'

    def add_arguments(self, parser):
        parser.add_argument('folder', nargs='+')

    @transaction.atomic
    def handle(self, *args, **options):
        folder = options['folder'][0]
        self.loadUsers(folder)
        self.loadCustomers(folder)
        self.loadProductGroups(folder)
        self.loadSuppliers(folder)
        self.loadProducts(folder)
        self.loadCoupons(folder)
        self.loadSales(folder)

    def loadCustomers(self, folder):
        filepath = os.path.join(folder, 'customers.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                # print(raw)
                customer = Customer(
                    id=raw['_id'],
                    name=raw['name'],
                    forename=raw.get('forename', ''),
                    title=raw.get('title', ''),
                    street=raw.get('street', ''),
                    zip=raw.get('zip', ''),
                    place=raw.get('place', ''),
                    tel=raw.get('tel', ''),
                    email=raw.get('email', ''),
                    notes=raw.get('notes', ''),
                )
                if (type(raw['customerSince']['$date']) is str):
                    customer.customer_since = moment.date(raw['customerSince']['$date']).date
                else:
                    # just 1970 em
                    customer.customer_since = datetime.datetime(1970, 1, 1)
                if('birthday' in raw):
                    rBirth = raw['birthday']['$date']
                    if(type(rBirth) is str):
                        customer.birthday = moment.date(rBirth).date
                    elif (int(rBirth['$numberLong']) > -10000000000000): # people arent 300 years old
                        customer.birthday = datetime.datetime(1970, 1, 1) + datetime.timedelta(milliseconds=(int(rBirth['$numberLong'])))
                # print(customer.__dict__)
                customer.save()

    def loadProductGroups(self, folder):
        filepath = os.path.join(folder, 'productGroups.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                productGroup = ProductGroup(
                    id=raw['_id'],
                    name=raw['name']
                )
                print(productGroup.__dict__)
                productGroup.save()

    def loadSuppliers(self, folder):
        filepath = os.path.join(folder, 'suppliers.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                supplier = Supplier(
                    id=raw['_id'],
                    name=raw['name'],
                    name2=raw.get('name2', ''),
                    street=raw.get('street', ''),
                    zip=raw.get('zip', ''),
                    place=raw.get('place', ''),
                    tel=raw.get('tel', ''),
                    tel2=raw.get('tel2', ''),
                    fax=raw.get('fax', ''),
                    email=raw.get('email', ''),
                    notes=raw.get('notes', ''),
                )
                print(supplier.__dict__)
                supplier.save()

    def loadProducts(self, folder):
        filepath = os.path.join(folder, 'products.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                product = Product(
                    id=raw['_id'],
                    name=raw['name'],
                    product_group=ProductGroup.objects.get(id=raw['productGroupId']),
                    supplier=Supplier.objects.get(id=raw['supplierId']),
                    supplier_product_id=raw.get('supplierProductId', ''),
                    printerline1=raw.get('printerline1', ''),
                    printerline2=raw.get('printerline2', ''),
                    cost=Decimal(raw['cost']) / Decimal(100),
                    sale=Decimal(raw['sale']) / Decimal(100),
                )
                # print(product.__dict__)
                product.save()
                if ('arrivals' in raw):
                    for rawArrival in raw['arrivals']:
                        if rawArrival['amount'] > 9000:
                            continue
                        arrival = Arrival(
                            product=product,
                            date=moment.date(rawArrival['date']['$date']).date,
                            amount=rawArrival['amount']
                        )
                        # print(arrival.__dict__)
                        arrival.save()

    def loadUsers(self, folder):
        filepath = os.path.join(folder, 'cashiers.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                user = User.objects.create_user(
                    username=raw['_id'],
                    password=raw['password']
                )
                print(user.__dict__)
                try:
                    user.save()
                except Exception as e:
                    print(e)

    def loadCoupons(self, folder):
        filepath = os.path.join(folder, 'coupons.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                coupon = Coupon(
                    id=unfuckNumberLong(raw['_id']),
                    # handle values in sales
                )
                coupon.save()

    def loadSales(self, folder):
        filepath = os.path.join(folder, 'sales.json')
        with open(filepath) as fp:
            for cnt, line in enumerate(fp):
                raw = json.loads(line)
                # print(raw)
                if (raw['customerId'] == 0):
                    continue
                sale = Sale(
                    id=raw['_id'],
                    customer=Customer.objects.get(id=raw['customerId']),
                    user=User.objects.get(username=raw['cashier']),
                    payment_method=Sale.BAR if raw['paymentMethodId'] == 1 else Sale.EC,
                    price=Decimal(raw['price']) / Decimal(100),
                    discount=Decimal(raw['discount']) / Decimal(10000),
                    date=moment.date(raw['date']['$date']).date,
                )
                # print(sale.__dict__)
                sale.save()
                for rawItem in raw['items']:
                    if rawItem['discount'] > 1000000:
                        discount = 1
                    elif rawItem['discount'] < 0:
                        discount = 0
                    else:
                        discount = Decimal(rawItem['discount']) / Decimal(10000)
                    item = SaleItem(
                        sale=sale,
                        product=Product.objects.get(id=rawItem['productId']),
                        price=Decimal(rawItem['price']) / Decimal(100),
                        discount=discount,
                        amount=rawItem['amount']
                    )
                    # print(item.__dict__)
                    item.save()

                for rawItem in raw['coupons']:
                    item = CouponChange(
                        sale=sale,
                        coupon=Coupon.objects.get(id=unfuckNumberLong(rawItem['couponId'])),
                        value_change=Decimal(rawItem['valuechange']) / Decimal(100)
                    )
                    # print(item.__dict__)
                    item.save()

                for rawItem in raw['returns']:
                    original_sale = Sale.objects.get(id=rawItem['saleId'])
                    if ('productId' in rawItem):
                        original_product = Product.objects.get(id=rawItem['productId'])
                        returned_item=SaleItem.objects.filter(sale=original_sale, product=original_product).first()
                    else:
                        returned_item=SaleItem.objects.filter(sale=original_sale).first()
                    item = ReturnItem(
                        sale=sale,
                        returned_item=returned_item,
                        price=abs(Decimal(rawItem['price']) / Decimal(100)),
                        amount=rawItem['amount']
                    )
                    # print(item.__dict__)
                    item.save()
