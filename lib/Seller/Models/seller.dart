class Seller {
  String shopName = '';
  String ownerName = '';
  String email = '';
  String contact = '';
  String image = '';
  List<String> categories = [];
  bool delivery = false;
  Address address;
  Seller(
      {this.shopName,
      this.ownerName,
      this.email,
      this.contact,
      this.image,
      this.categories,
      this.delivery,
      this.address});
}

class Address {
  String city;
  String addressLine;
  Address({this.city, this.addressLine});
}
