import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/seller.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class ProfilePage extends StatefulWidget with NavigationStates {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Seller _seller = new Seller();
  Widget _profileText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 35.0,
          letterSpacing: 1.5,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _circleAvatar() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(_seller.image),
        ),
      ),
    );
  }

  Widget _textFormField({
    String hintText,
    IconData icon,
  }) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Colors.white30),
      ),
    );
  }

  Widget _textFormFieldCalling() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textFormField(
            hintText: _seller.shopName,
            icon: Icons.home_rounded,
          ),
          _textFormField(
            hintText: _seller.ownerName,
            icon: Icons.person_pin,
          ),
          _textFormField(hintText: _seller.email, icon: Icons.email_rounded),
          _textFormField(
            hintText: _seller.contact,
            icon: Icons.call_rounded,
          ),
          _textFormField(
              hintText: _seller.categories.join(','),
              icon: Icons.category_rounded),
          _textFormField(
              hintText: _seller.deliveryDetails.delivery.toString(),
              icon: Icons.delivery_dining),
          _textFormField(hintText: _seller.email, icon: Icons.email_rounded),
          _textFormField(
              hintText: _seller.address.addressLine + _seller.address.city,
              icon: Icons.location_city_rounded),
          Container(
            height: 55,
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Text(
            "PROFILE",
            style: TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }
}
