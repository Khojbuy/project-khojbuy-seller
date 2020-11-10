import 'package:firebase_auth/firebase_auth.dart';

class Seller {
  String userId = '';
  String shopName = '';
  String ownerName = '';
  String contact = '';
  String image = '';
  String categories = "";
  DeliveryDetails deliveryDetails;
  String address;
  Seller(
      {this.userId,
      this.shopName,
      this.ownerName,
      this.contact,
      this.image,
      this.categories,
      this.deliveryDetails,
      this.address});

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
  String minAmt = "0";

  DeliveryDetails({this.delivery = false, this.minAmt = "0"});
}
