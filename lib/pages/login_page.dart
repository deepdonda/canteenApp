import 'package:canteen/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:canteen/pages/regi_page.dart';
import 'package:canteen/utils/color.dart';
import 'package:canteen/widgets/btn_widget.dart';
import 'package:canteen/widgets/herder_container.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:canteen/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email, password, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Login"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.email),
                        ),
                        onChanged: (val) {
                          email = val;
                        }),
                    // _textInput(hint: "Password", icon: Icons.vpn_key),
                    TextField(
                        
                        decoration: InputDecoration(
                          labelText: "Password",
                          icon: Icon(Icons.vpn_key),
                        ),
                        obscureText: true,
                        onChanged: (val) {
                          password = val;
                        }),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            Authservices().login(email, password).then((val) {
                              print(val);
                              if (val.data['token'] != null) {
                                token = val.data['token'];
                                print(token);
                                Fluttertoast.showToast(
                                    msg: "Authenticated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                });
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RegPage()));
                          },
                          btnText: "LOGIN",
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.orange,
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 0,
                    ),
                    Text("Don't have an account ?"),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegPage()));
                          },
                          btnText: "Registor",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
