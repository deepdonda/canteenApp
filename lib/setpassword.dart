import 'dart:convert';
import 'package:canteen/widgets/header_container.dart';
import 'package:flutter/material.dart';
import 'package:canteen/login.dart';
import 'package:canteen/widgets/btn_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class setpasswordPage extends StatefulWidget {
  @override
  _setpasswordPageState createState() => _setpasswordPageState();
}

// ignore: camel_case_types
class _setpasswordPageState extends State<setpasswordPage> {
  var email, password, otp;
  var token, temp;
  final storage = new FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Set Password"),
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
                            labelText: "Email",
                            icon: Icon(Icons.email),
                          ),
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
                          labelText: "Otp",
                          icon: Icon(Icons.lock),
                        ),
                        onChanged: (val) {
                          otp = val;
                        },
                        validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter otp';
                            } else if (RegExp(
                                    r'^[0-9]{4}$')
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid otp';
                            }
                          }
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "password",
                            icon: Icon(Icons.vpn_key),
                          ),
                          obscureText: true,
                          onChanged: (val) {
                            password = val;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter password';
                            } else if (RegExp(
                                    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}')
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid password';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget1(
                            btnText: "Reset Password",
                            onClick: () async {
                              if (_formKey.currentState.validate()) {
                                // ignore: await_only_futures

                                var response = await http.post(
                                    "https://appcanteen.herokuapp.com/reset-password-done",
                                    body: jsonEncode({
                                      "email": email,
                                      "otp": otp,
                                      "p1": password
                                    }),
                                    headers: {
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    });

                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  var val = json.decode(response.body);
                                  if (val["message"] != null) {
                                    Fluttertoast.showToast(
                                        msg: val["message"],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.greenAccent,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    setState(() {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginPage()));
                                    });
                                  }
                                  if (val["msg"] != null) {
                                    Fluttertoast.showToast(
                                        msg: val["msg"],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.orange,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    setState(() {});
                                  }
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
                      const Divider(
                        color: Colors.orange,
                        height: 30,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.center,
                        child: Text("Already a member ? "),
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            onClick: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()));
                            },
                            btnText: "Login",
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////////
// ignore: must_be_immutable
class ButtonWidget1 extends StatefulWidget {
  var btnText = "";
  var onClick;
  ButtonWidget1({this.btnText, this.onClick});

  @override
  _ButtonWidgetState1 createState() => _ButtonWidgetState1();
}

class _ButtonWidgetState1 extends State<ButtonWidget1> {
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
