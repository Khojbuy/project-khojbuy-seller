import 'package:firebase_auth/firebase_auth.dart';

class Seller {
  String userId;
  String shopName;
  String ownerName;
  String contact;
  List<String> categories;
  bool delivery;
  String minAmt;
  String addressLoc;
  String addressCity;

  Seller() {
    userId = FirebaseAuth.instance.currentUser.uid;
    //create constructor
  }

  toJsonSeller(Seller seller) {
    return {
      FirebaseAuth.instance.currentUser.uid: {
        "AddressLocation": seller.addressLoc,
        "AddressCity": seller.addressCity,
        "Category": seller.categories.toList(),
        "Name": seller.ownerName,
        "ShopName": seller.shopName,
        "Delivery": seller.delivery,
        "MinAmt": seller.minAmt,
        "PhoneNo": seller.contact,
      }
    };
  }
}
