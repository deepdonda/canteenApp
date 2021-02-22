import 'dart:convert';
import 'package:canteen/main.dart';
import 'package:canteen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

var routes = <String, WidgetBuilder>{
  "/feedback": (BuildContext context) => FeedBackPage(),
};

var items, response, token;

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  var name, feedback;
  var token, temp;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    gettoken();
    response = "a";
  }

  void gettoken() async {
    token = await storage.read(key: "token");
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
        child: response != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Form(
                        key: _formKey,
                        child: Expanded(
                            child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            SizedBox(
                              height: 0,
                            ),
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
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                maxLines: null,
                                minLines: 3,
                                decoration: InputDecoration(
                                  labelText: "Message",
                                  icon: Icon(Icons.feedback_outlined),
                                ),
                                onChanged: (val) {
                                  feedback = val;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Message';
                                  } else {
                                    return null;
                                  }
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Center(
                                child: ButtonWidget(
                                  btnText: "Send FeedBack",
                                  onClick: () async {
                                    if (_formKey.currentState.validate()) {
                                      // ignore: await_only_futures
                                      await gettoken();
                                      var response = await http.post(
                                          "https://appcanteen.herokuapp.com/user/sendfeedback",
                                          body: jsonEncode({
                                            'name': name,
                                            'feedback': feedback
                                          }),
                                          headers: {
                                            "Authorization": "Bearer $token",
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          });
                                      //setState(() {});

                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        var val = json.decode(response.body);
                                        if (val['msg'] != null) {
                                          Fluttertoast.showToast(
                                              msg: val["msg"],
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        } else if (val["errormsg"] != null) {
                                          Fluttertoast.showToast(
                                              msg: val["errormsg"],
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.orange,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                        //gettoken();

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
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// ignore: must_be_immutable
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
