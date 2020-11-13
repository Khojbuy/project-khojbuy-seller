import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userId;
  DatabaseService({this.userId});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('SellerData');

  Future updateUserData(Seller seller) async {
    return await collectionReference.doc(userId).set(toJsonSeller(seller));
  }
}

class Seller {
  String shopName;
  String ownerName;
  String contact;
  String category;
  bool delivery;
  String minAmt;
  String addressLoc;
  String addressCity;

  Seller(String sName, String uName, String phnNo, String cat, bool del,
      String minA, String aloc, String aCity) {
    shopName = sName;
    ownerName = uName;
    contact = phnNo;
    category = cat;
    delivery = del;
    minAmt = minA;
    addressLoc = aloc;
    addressCity = aCity;
  }
}

toJsonSeller(Seller seller) {
  return {
    "AddressLocation": seller.addressLoc,
    "AddressCity": seller.addressCity,
    "Category": seller.category,
    "Name": seller.ownerName,
    "ShopName": seller.shopName,
    "Delivery": seller.delivery,
    "MinAmt": seller.minAmt,
    "PhoneNo": seller.contact,
  };
}
