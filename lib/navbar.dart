import 'package:canteen/feedback.dart';
import 'package:canteen/login.dart';
import 'package:canteen/main.dart';
import 'package:canteen/myprofile.dart';
import 'package:canteen/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'cart.dart';

class Navbar extends StatelessWidget {
  // const Navbar({Key key}) : super(key: key);

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/logo.png",
                height: 100,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        },
        leading: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Your Home"),
      ),
      ListTile(
        onTap: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => CartPage()));
        },
        leading: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        title: Text("Your Cart"),
      ),
       ListTile(
        onTap: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => OrderPage()));
        },
        leading: Icon(
          Icons.book_outlined,
          color: Colors.black,
        ),
        title: Text("Your Orders"),
      ),
      ListTile(
        onTap: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => MyProfilePage()));
        },
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("Your Profile"),
      ),
      ListTile(
        onTap: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => FeedBackPage()));
        },
        leading: Icon(
          Icons.feedback_outlined,
          color: Colors.black,
        ),
        title: Text("Send FeedBack"),
      ),
      ListTile(
        onTap: () async {
          await storage.delete(key: "token");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
        },
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("Logout"),
      ),
      
    ]);
  }
}
