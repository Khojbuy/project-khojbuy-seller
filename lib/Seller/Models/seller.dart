import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userId;
  DatabaseService({this.userId});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('SellerData');

  Future updateUserData(Seller seller) async {
    return await collectionReference
        .doc(userId)
        .set(toJsonSeller(seller))
        .then((value) {
      print("User Added");
    }).catchError((error) => print(error));
  }

  getDisplay() async {
    var document = collectionReference.doc(userId);
    document.get().then((document) {
      return document["display"];
    });
  }
}

class Seller {
  String shopName;
  String ownerName;
  String contact;
  String category;
  bool delivery;
  String addressLoc;
  String addressCity;
  String dealsIn;
  String info;

  Seller(String sName, String uName, String phnNo, String cat, bool del,
      String aloc, String aCity, String deal, String information) {
    shopName = sName;
    ownerName = uName;
    contact = phnNo;
    category = cat;
    delivery = del;

    addressLoc = aloc;
    addressCity = aCity;
    dealsIn = deal;
    info = information;
  }
}

toJsonSeller(Seller seller) {
  return {
    "PhotoURL": "url",
    "display": false,
    "AddressLocation": seller.addressLoc,
    "AddressCity": seller.addressCity,
    "Category": seller.category,
    "Name": seller.ownerName,
    "ShopName": seller.shopName,
    "Delivery": seller.delivery,
    "PhoneNo": seller.contact,
    "DealsIn": seller.dealsIn,
    "Other": seller.info,
  };
}
