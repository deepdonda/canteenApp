import 'package:canteen/services/AuthServices.dart';
import 'package:canteen/widgets/header_container.dart';
import 'package:flutter/material.dart';
import 'package:canteen/login.dart';
import 'package:canteen/widgets/btn_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  var email, password, name, number;
  var token, temp;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
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
                              return "Password should contain \n\t• one number\n\t• one capital letter\n\t• minimum length 8";
                            }
                          }),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            icon: Icon(Icons.call),
                          ),
                          onChanged: (val) {
                            number = val;
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
                  
                      SizedBox(height: 20,),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            btnText: "Register",
                            onClick: () {
                              if (_formKey.currentState.validate()) {
                                Authservices()
                                    .register(name, email, password, number)
                                    .then((val) {
                                  print(val);
                                  if (val.data['message'] != null) {
                                    // token=val.data['token'];
                                    print(token);
                                    Fluttertoast.showToast(
                                        msg: val.data['message'],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    temp = "a";
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: val.data['msg'],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.orange,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                });
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
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          alignment: Alignment.center,
                          child: Text("Already a member ? "),
                        ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
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
