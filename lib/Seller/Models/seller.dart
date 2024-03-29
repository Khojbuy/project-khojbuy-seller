import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String fcmToken;
getToken() async {
  fcmToken = await _firebaseMessaging.getToken();
}

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

  Future updateStoryData(
      String contact, String name, String city, String category) async {
    return await FirebaseFirestore.instance
        .collection(city)
        .doc(userId)
        .set(toJsonStory(contact, name, category))
        .then((value) {
      print('Story Data');
    }).catchError((error) {
      print(error);
    });
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

toJsonStory(String contact, String name, String category) {
  return {
    'contact': contact,
    'name': name,
    'stories': [],
    'category': category
  };
}

toJsonSeller(Seller seller) {
  getToken();
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
    'Priority': false,
    'Rating': 0,
    'Menu': [],
    'FCM': fcmToken
  };
}
