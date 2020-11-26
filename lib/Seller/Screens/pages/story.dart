import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class StoryAddPage extends StatefulWidget with NavigationStates {
  @override
  _StoryAddPageState createState() => _StoryAddPageState();
}

class _StoryAddPageState extends State<StoryAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ADD A STORY"),
      ),
    );
  }
}
