import 'dart:convert';
//import 'package:canteen/cartcard.dart';
import 'package:canteen/navbar.dart';
import 'package:canteen/ordercard.dart';
//import 'package:canteen/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var routes = <String, WidgetBuilder>{
  "/order": (BuildContext context) => OrderPage(),
};

var items = [], response, token, count, val = [], total = 0;

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    //getdata();
    setState(() {
      response = null;
      val = [];
      items = [];
      total = 0;
      getdata();
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    response = null;
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
      "https://appcanteen.herokuapp.com/user/getalluserorders2",
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(response);
      print(response.body);
      val = json.decode(response.body);
      items = val;
      items=items;
      print(
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(val);
      //print(val.length);
      // if (val.length > 0) {
      //   items = val[0]['items'];
      //   total = val[0]['total'];
      // }
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
             
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: response != null
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 2.6),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var item = items[index];
                          // item=item["items"];
                          //print("###################");
                          print(item);
                          //var url = item['foodimage'];
                          int colors = 0000000;
                          if (item["status"] == "placed") {
                            colors = 0xFFB71C1C;
                          }
                          else if (item["status"] == "preparing") {
                            colors = 0xFFFF9800;
                          }
                          else if (item["status"] == "completed") {
                            colors = 0xFF4CAF50;
                          }

                          return orderCard(context, colors, item);
                        })
                    : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
        onRefresh: refreshList,
      ),
    );
  }
}
