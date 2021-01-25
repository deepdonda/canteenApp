import 'package:canteen/main.dart';
import 'package:canteen/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:canteen/register.dart';
import 'package:canteen/widgets/btn_widget.dart';
import 'package:canteen/widgets/header_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email, password, token;
  final _formKey = GlobalKey<FormState>();

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Login"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Form(
                  key: _formKey,
                  child: (Expanded(
                    //mainAxisSize: MainAxisSize.max,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        TextFormField(
                            //controller: TextEditingController(text: email),
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
                        // _textInput(hint: "Password", icon: Icons.vpn_key),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
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
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ButtonWidget(
                              onClick: () {
                                if (_formKey.currentState.validate()) {
                                  Authservices()
                                      .login(email, password)
                                      .then((val) async {
                                    print(val);
                                    if (val.data['token'] != null) {
                                      if (val.data['blocked'] == false) {
                                        print("YOU CAN LOGIN");
                                        token = val.data['token'];
                                        await storage.write(
                                            key: "token", value: token);

                                        print(token);
                                        Fluttertoast.showToast(
                                            msg: "Login success",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.greenAccent,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        setState(() {
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (BuildContext context) =>HomePage()));
                                        });
                                      } else {
                                        print("YOU CAN NOT LOGIN");
                                        Fluttertoast.showToast(
                                            msg: "you are blocked by admin",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.orange,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        setState(() {

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        });
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: val.data['msg'],
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  });
                                } else {
                                  print("not ok");
                                }
                              },
                              btnText: "Login",
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
                          child: Text(
                            "Don't have account?",
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ButtonWidget(
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegPage()));
                              },
                              btnText: "Register",
                            ),
                          ),
                        ),
                      ],
                    ),
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
