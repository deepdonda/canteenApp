import 'dart:convert';

import 'package:canteen/navbar.dart';
import 'package:canteen/services/AuthServices.dart';
import 'package:canteen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

var routes = <String, WidgetBuilder>{
  "/MyProfilecart": (BuildContext context) => MyProfilePage(),
};

var items, response, token;

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  var email, password, name, number;
  var token, temp;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    gettoken();
    //getdata();
  }

  void gettoken() async {
    token = await storage.read(key: "token");
    getdata();
    // setState(() {

    //     });
  }

  void getdata() async {
    // print(response);
    response = await http.get(
      "https://appcanteen.herokuapp.com/user/myprofile",
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var val = json.decode(response.body);
      items = val['user'];
      //print(items);
      name = items['name'];
      email = items['email'];
      number = items['contact'];

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
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(bottom: 30),
        child:response != null ? Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Form(
                  key: _formKey,
                  child: Expanded(
                      // mainAxisSize: MainAxisSize.max,
                      child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Full name",
                            icon: Icon(Icons.person),
                          ),
                          onChanged: (val) {
                            name = val;
                          },
                          initialValue: items['name'],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Name';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            icon: Icon(Icons.email),
                          ),
                          initialValue: items['email'],
                          onChanged: (val) {
                            email = val;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Email';
                            } else if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid email';
                            }
                          }),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            icon: Icon(Icons.call),
                          ),
                          initialValue: items['contact'],
                          onChanged: (val) {
                            number = val;
                            //print(number);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter phone number';
                            } else if (RegExp(
                                    r'^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$')
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid Phone number';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            btnText: "Edit profile",
                            onClick: () async {
                              if (_formKey.currentState.validate()) {
                                items['name'] = name;
                                items['email'] = email;
                                items['contact'] = number;
                                //print(items);
                                gettoken();

                                var response = await http.post(
                                    "https://appcanteen.herokuapp.com/user/editprofile",
                                    body: jsonEncode(items),
                                    headers: {
                                      "Authorization": "Bearer $token",
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    });
                                //setState(() {});

                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  var val = json.decode(response.body);
                                  Fluttertoast.showToast(
                                      msg: val["msg"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.orange,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  //gettoken();
                                  getdata();
                                 // setState(() {});
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.orange,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                print("not ok");
                              }

                              if (temp != null) {
                                //Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            )
          ],
        ):Center( child:CircularProgressIndicator()),
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  var btnText = "";
  var onClick;
  ButtonWidget({this.btnText, this.onClick});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        height: 40,
        width: 200,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10),
          color: Colors.orangeAccent,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.btnText,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
