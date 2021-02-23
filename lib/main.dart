import 'dart:convert';
import 'package:canteen/navbar.dart';
import 'package:canteen/splash.dart';
import 'package:flutter/material.dart';
import 'package:canteen/foodcard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
};

void main() => runApp(MyApp());
var items, response, token,val;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  IO.Socket socket;

  @override
  void initState() {
    
    super.initState();
   // establishConnection();
    //print(DateTime.now().toString().replaceAll(' ', '_'));
    gettoken();
    
    
  }
  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    //getdata();
    setState(() {
      response = null;
      val = [];
      items = [];
      getdata();
    });

    return null;
  }

  void gettoken() async {
    
    token = await storage.read(key: "token");
    getdata();
   

    //RsetState(() {});
  }
  void establishConnection() async {
    print("");
    try {
      socket = IO.io("https://appcanteen.herokuapp.com/", <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      print("hello");
      socket.onConnect((_) {
        print('connected');
        
      });
      //print("");
      socket.on('foodcrudbyadmin', (data) {
        print("here");
        print(data);
        //var json = jsonDecode(data);
        setState(() {   
          response = null;
      val = [];
      items = [];
      getdata();      
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
  void getdata() async {
    
    response = await http.get(
      "https://appcanteen.herokuapp.com/user/getallfooditem",
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      val = json.decode(response.body);
     // print(val);
      items = val["msg"];
     // print(items);
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
      //Now we are going to open a new file
      // where we will create the layout of the Drawer
      drawer: Drawer(
          child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Navbar(),
      )),
      // body: Center(child: Text("home page"),),
      body:RefreshIndicator (
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
              Expanded(
                  child: response != null
                      ? GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.68),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            var item = items[index];
                            var url = item['foodimage'];
                            String qty="" + item['foodqty'].toString();
                            if(item['foodqty']<0)
                            {
                                qty="available";
                            }
                            return foodCard(url, item['foodname'],
                                item['foodprice'], qty, item);
                          })
                      : Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
         onRefresh: refreshList,
      ),
    );
  }
}
