import 'dart:convert';

//import 'package:canteen/loading.dart';
import 'package:canteen/cartcard.dart';
import 'package:canteen/navbar.dart';
// import 'package:canteen/services/AuthServices.dart';
import 'package:canteen/splash.dart';
import 'package:flutter/material.dart';
// import 'package:canteen/foodcard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
var routes = <String, WidgetBuilder>{
  "/cart": (BuildContext context) => CartPage(),

};

var items,response,token ;
 


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  a() async{
    setState((){});
  }
  Future<Null> refreshList() async {
   // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
     getdata();
    });
     

    return null;
  }
  @override
  void initState() {
    super.initState();
    gettoken();
    // getdata();
  }
  void gettoken() async {
    token = await storage.read(key: "token");
    getdata();
  }
  void getdata() async {
    
      // print(response);
     response = await http.get(
      "https://appcanteen.herokuapp.com/user/getcart",
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
       var val = json.decode(response.body);
      // items =  val["msg"];
      items=val[0]['items'];
      
       //print(items);
       setState(() {
     
    });
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodZone",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //Now we are going to open a new file
      // where we will create the layout of the Drawer
      drawer: Drawer(
         child: Container(
           decoration: BoxDecoration(color: Colors.white),
          child: Navbar(),
         )
        
      ),
      // body: Center(child: Text("home page"),),
      body: RefreshIndicator(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                 
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0x55d2d2d2),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search... ",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20.0),
                      ),
                    )),
                    RaisedButton(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.orange,
                    ),
                  ],
                ),
                
              ),
              SizedBox(
                height: 20.0,
              ),
              //Now let's build the food menu
              //I'm going to create a custom widget
              // ListView(
              //   shrinkWrap: true,
              //   children:  <Widget>[
              //     Expanded(
              //     child: response != null
              //     ? GridView.builder(
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.68),
              //       itemCount: items.length,
              //       itemBuilder: (context, index) {
              //         var item = items[index];
              //         print(item);
              //         var url ="https://appcanteen.herokuapp.com/backend/uploads/"+item['foodimage'];
              //         return CartCard(url, item['foodname'], item['foodprice'],item['foodqty']);
              //       }
              //     )
              //     :CircularProgressIndicator(
              //       backgroundColor: Colors.green,
              //     ),
              //   ),
              //   ]
              // )
              Expanded(
                child: response != null
                ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.68),
                  itemCount: items.length,
                  
                  itemBuilder: (context, index) {
                    var item = items[index];
                  
                    return CartCard(item['foodimage'], item['foodname'], item['foodprice'],item['foodqty'],item);
                    //setState(() {});
                    
                  }
                  
                )
                :SplashScreen()
              )
            ],
          ),
        ),
        onRefresh: refreshList,
      ),

      
    );
  }
}
