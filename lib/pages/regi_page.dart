import 'package:canteen/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:canteen/pages/login_page.dart';
import 'package:canteen/utils/color.dart';
import 'package:canteen/widgets/btn_widget.dart';
import 'package:canteen/widgets/herder_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  var email, password, name, number;
  var token, temp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                          labelText: "Full name",
                          icon: Icon(Icons.person),
                        ),
                        onChanged: (val) {
                          name = val;
                        }),
                    TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.email),
                        ),
                        onChanged: (val) {
                          email = val;
                        }),
                    TextField(
                        decoration: InputDecoration(
                          labelText: "password",
                          icon: Icon(Icons.vpn_key),
                        ),
                        obscureText: true,
                        onChanged: (val) {
                          password = val;
                        }),
                    TextField(
                      keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          icon: Icon(Icons.call),
                        ),
                        onChanged: (val) {
                          number = val;
                        }),
                    // _textInput(hint: "Fullname", icon: Icons.person),
                    // _textInput(hint: "Email", icon: Icons.email),
                    // _textInput(hint: "Phone Number", icon: Icons.call),
                    // _textInput(hint: "Password", icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTER",
                          onClick: () {
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
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            });
                            if (temp != null) {
                              //Navigator.pop(context);
                            }
                          },
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
                    Text("Already a member ? "),
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
                    // RichText(
                    //   text: TextSpan(children: [
                    //     TextSpan(
                    //         text: "Already a member ? ",
                    //         style: TextStyle(color: Colors.black)),
                    //     TextSpan(
                    //         text: "Login",
                    //         style: TextStyle(color: orangeColors)),
                    //   ]),
                    // )
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
