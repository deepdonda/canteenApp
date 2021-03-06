//import 'package:canteen/cart.dart';
import 'dart:convert';

//import 'package:canteen/cart.dart';
import 'package:canteen/pickUp.dart';
import 'package:http/http.dart' as http;
import 'package:canteen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Colors
const iPrimarryColor = Color(0xFFF9FCFF);
const iAccentColor = Color(0xFFFFB44B);
const iAccentColor2 = Color(0xFFFFEAC9);
var a;

// ignore: must_be_immutable
class Invoice extends StatelessWidget {
  var todo;
  Invoice({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(todo);
    a = todo;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                invoiceHeader(),
                InvoiceBody(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget invoiceHeader() {
    return Container(
      width: 600,
      height: 300,
      color: Color(0xFF4D4F52),
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Invoice",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              topHeaderText(todo["_id"]),
              SizedBox(
                height: 6,
              ),

              topHeaderText(todo["orderdate"]),
              SizedBox(
                height: 6,
              ),

              topHeaderText(todo["status"]),
              SizedBox(
                height: 6,
              ),
              topHeaderText(todo["paymentstatus"]),
              //paymentstatus
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    "https://raw.githubusercontent.com/developFlexUI/invoice-flutter-ui/main/assets/icons/icons8-receipt.png",
                    height: 50,
                  ),
                  addressColumn()
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Column addressColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Delivery address",
          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        SizedBox(
          height: 10,
        ),
        Text("FoodZone , Ddu",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text("Nadiad",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
      ],
    );
  }

  Text topHeaderText(String label) {
    return Text(label,
        style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }
}

////////////////
class InvoiceBody extends StatefulWidget {
  @override
  _InvoiceBodyState createState() => _InvoiceBodyState();
}

class _InvoiceBodyState extends State<InvoiceBody> {
  String result = "Scan";
  FlutterSecureStorage storage = FlutterSecureStorage();
  var token;
  void gettoken() async {
    token = await storage.read(key: "token");
    //getdata();
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalAmount = 64;
    double height = 300;

    return Container(
      height: height,
      width: 600,
      padding: EdgeInsets.only(
        top: 10,
        left: 0,
        right: 0,
      ),
      color: iPrimarryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            addItemAction(),
            SizedBox(
              height: 20,
            ),
            Column(
                children: List.generate(
              a["items"].length,
              (index) => Column(
                children: [
                  invoiceItem(
                      a["items"][index]["foodqty"],
                      a["items"][index]["foodimage"],
                      a["items"][index]["foodprice"],
                      a["items"][index]["foodname"]),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )),
            invoiceTotal(totalAmount),
            SizedBox(height: 20),
            a["status"] != "picked up"
                ? FlatButton(
                    color: iAccentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Scan", //////////////////////////
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    onPressed: () async {
                      //////////////////////////////////////////////////////////////////////////////////
                      await _scanQR();
                      if (result == a["_id"]) {
                        // ignore: await_only_futures
                        await gettoken();

                        var response = await http.post(
                            "https://appcanteen.herokuapp.com/user/qrcode",
                            body: jsonEncode({'id': result}),
                            headers: {
                              "Authorization": "Bearer $token",
                              'Content-Type': 'application/json; charset=UTF-8',
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PickUP(items: a)));
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
                        Fluttertoast.showToast(
                            msg: "Invalid Qr code",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  )
                : Center()
          ],
        ),
      ),
    );
  }

  Row invoiceTotal(int totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              "Total : ",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              a["total"].toString() + " ₹",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        )
      ],
    );
  }

  Container invoiceItem(
      int quantity, String imagePath, int price, String itemDesc) {
    int totalValue = quantity * price;

    return Container(
      height: 50,
      width: 600,
      padding: EdgeInsets.symmetric(
        horizontal: 27,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 11),
                blurRadius: 11,
                color: Colors.black.withOpacity(0.06))
          ],
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemDesc,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            quantity.toString(),
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "X",
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            //width: 20,
            child: Text(
              "$price" + " ₹",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "=",
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$totalValue" + " ₹",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Row addItemAction() {
    return Row(
      children: [
        Text("Items", style: TextStyle(color: Colors.black, fontSize: 18)),
        SizedBox(
          width: 50,
        ),
        // FlatButton(
        //   color: iAccentColor2,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        //   child: Row(
        //     children: [Icon(Icons.add), Text("Add items")],
        //   ),
        //   onPressed: () {},
        // )
      ],
    );
  }
}
