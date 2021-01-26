
import 'package:canteen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
var routes = <String, WidgetBuilder>{
  "/emptycart": (BuildContext context) => EmptyCartPage(),

};

var items,response,token ;
 


class EmptyCartPage extends StatefulWidget {
  @override
  _EmptyCartPageState createState() => _EmptyCartPageState();
}

class _EmptyCartPageState extends State<EmptyCartPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodZone",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
         child: Container(
           decoration: BoxDecoration(color: Colors.white),
          child: Navbar(),
         )
        
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
              "assets/img/emptycart.png",
              
              width: 400,
              height:500,
            ),
        
              
              
              
            ],
          ),
        ),
       
      ),

      
    );
  }
}
