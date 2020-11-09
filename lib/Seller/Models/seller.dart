import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Seller {
  String userId = '';
  String shopName = '';
  String ownerName = '';
  String email = '';
  String contact = '';
  String image = '';
  List<String> categories = [];
  DeliveryDetails deliveryDetails;
  Address address;
  Seller(
      {this.userId,
      this.shopName,
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
  
}

Map<String,dynamic> toJsonSeller(Seller seller){
  return{
    FirebaseAuth.instance.currentUser.uid : {
      "Address" : seller.address.addressLine + seller.address.city,
      "Category" : seller.categories,
      "Name" : seller.ownerName,
      "ShopName" : seller.shopName,
      "delivery" : {
        "Allowed" : seller.deliveryDetails.delivery,
        "MinAmount" : seller.deliveryDetails.minAmt
      },
      "phone_no" : seller.contact,
      "shopImage" : "url"
    }
  }
}