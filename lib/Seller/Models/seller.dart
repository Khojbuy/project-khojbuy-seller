class Seller {
  String shopName = '';
  String ownerName = '';
  String email = '';
  String contact = '';
  List<String> categories = [];
  bool delivery = false;
  Address address;
  Seller(
      {this.shopName,
      this.ownerName,
      this.email,
      this.contact,
      this.categories,
      this.delivery,
      this.address});
}

class Address {
  String city;
  String addressLine;
  Address({this.city, this.addressLine});
}
