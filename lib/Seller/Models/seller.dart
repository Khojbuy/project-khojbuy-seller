import 'package:firebase_auth/firebase_auth.dart';

class Seller {
  String userId = '';
  String shopName = '';
  String ownerName = '';
  String email = '';
  String contact = '';
  String image = '';
  List<String> categories = [];
  DeliveryDetails deliveryDetails;
  String address;
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

  Seller.fromSnapshot(DataSnapshot snapshot) {
    userId = snapshot.key;
    shopName = snapshot.value["ShopName"];
    address = snapshot.value["Address"];
    categories = snapshot.value["Category"].toList();
    deliveryDetails.delivery = snapshot.value["delivery"].value["Allowed"];
    deliveryDetails.minAmt = snapshot.value["delivery"].value["MinAmount"];
    contact = snapshot.value["phone_no"];
    image = snapshot.value["shopImage"];
  }

  toJsonSeller(Seller seller) {
    return {
      FirebaseAuth.instance.currentUser.uid: {
        "Address": seller.address,
        "Category": seller.categories,
        "Name": seller.ownerName,
        "ShopName": seller.shopName,
        "delivery": {
          "Allowed": seller.deliveryDetails.delivery,
          "MinAmount": seller.deliveryDetails.minAmt
        },
        "phone_no": seller.contact,
        "shopImage": seller.image
      }
    };
  }
}

class DeliveryDetails {
  bool delivery = false;
  String minAmt;
}
