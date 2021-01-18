import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key key}) : super(key: key);

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
              Image.asset("assets/img/logo.png",height: 100,),
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
        onTap: () {},
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("Your Profile"),
      ),

      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        title: Text("Your Cart"),
      ),


      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("Logout"),
      ),
    ]);
  }
}
