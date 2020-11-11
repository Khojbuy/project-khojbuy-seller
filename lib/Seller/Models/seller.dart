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

  Seller(String sName, String uName, String phnNo, List<String> cat, bool del,
      String minA, String aloc, String aCity) {
    userId = FirebaseAuth.instance.currentUser.uid;
    shopName = sName;
    ownerName = uName;
    contact = phnNo;
    categories = cat;
    delivery = del;
    minAmt = minA;
    addressLoc = aloc;
    addressCity = aCity;
  }

  toJsonSeller(Seller seller) {
    return {
      "AddressLocation": seller.addressLoc,
      "AddressCity": seller.addressCity,
      "Category": seller.categories.toList(),
      "Name": seller.ownerName,
      "ShopName": seller.shopName,
      "Delivery": seller.delivery,
      "MinAmt": seller.minAmt,
      "PhoneNo": seller.contact,
    };
  }
}
