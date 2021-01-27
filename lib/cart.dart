import 'dart:convert';
import 'package:canteen/cartcard.dart';
import 'package:canteen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var routes = <String, WidgetBuilder>{
  "/cart": (BuildContext context) => CartPage(),
};

var items = [], response, token, count,val=[];

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  a() async {
    setState(() {});
  }

  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    //getdata();
    setState(() {
      response=null;
      items = [];
      getdata();
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    response=null;
    gettoken();
    //getdata();
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
      val = json.decode(response.body);
      //print(val);
      //print(val.length);
      if(val.length>0)
      {
        items = val[0]['items'];
      }
      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodZone",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
          child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Navbar(),
      )),
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
              Expanded(
                child: response != null
                    ? val.length > 0
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.68),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              var item = items[index];
                              var url = item['foodimage'];
                              return CartCard(url, item['foodname'],
                                  item['foodprice'], item['foodqty'], item);
                            })
                        : Image.asset(
                            "assets/img/emptycart.png",
                            width: 400,
                            height: 500,
                          )
                    : Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
        onRefresh: refreshList,
      ),
    );
  }
}