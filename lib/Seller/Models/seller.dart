import 'package:flutter/material.dart';

class Seller {
  String shopName = '';
  String ownerName = '';
  String email = '';
  String contact = '';
  String image = '';
  List<String> categories = [];
  DeliveryDetails deliveryDetails;
  Address address;
  Seller(
      {this.shopName,
      this.ownerName,
      this.email,
      this.contact,
      this.image,
      this.categories,
      this.deliveryDetails,
      this.address});
}

class Address {
  String city;
  String addressLine;
  Address({this.city, this.addressLine});
}

class DeliveryDetails {
  bool delivery = false;
  String minAmt;
  TimeOfDay delStart = TimeOfDay.now();
  TimeOfDay delEnd = TimeOfDay.now();
}
