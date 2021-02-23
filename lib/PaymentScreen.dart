import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:canteen/order.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Constants.dart';

class PaymentScreen extends StatefulWidget {
  final String amount;
  final String useremail, userid, contact, orderid,oldorderid;
 

  PaymentScreen(
      {this.amount, this.useremail, this.userid, this.contact, this.orderid,this.oldorderid});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  String _loadHTML() {
    // print(widget.amount);
    // print(widget.useremail);
    // print(widget.userid);
    // print(widget.contact);
    
    
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$PAYMENT_URL'><input type='hidden' name='orderID' value='ORDER_${DateTime.now().millisecondsSinceEpoch}'/>" +
        "<input  type='hidden' name='userid' value='${widget.userid}' />" +
        "<input  type='hidden' name='amount' value='${widget.amount}' />" +
        "<input type='hidden' name='useremail' value='${widget.useremail}' />" +
        "<input type='hidden' name='contact' value='${widget.contact}' />" +
        "<input type='hidden' name='orderid' value='${widget.orderid}' />" +
        "</form> </body> </html>";
  }

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(responseJSON);
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      final checksumResult = responseJSON["status"];
      final paytmResponse = responseJSON["data"];
      if (paytmResponse["STATUS"] == "TXN_SUCCESS") {
        if (checksumResult == 0) {
          _responseStatus = STATUS_SUCCESSFUL;
        } else {
          _responseStatus = STATUS_CHECKSUM_FAILED;
        }
      } else if (paytmResponse["STATUS"] == "TXN_FAILURE") {
        _responseStatus = STATUS_FAILED;
      }
      this.setState(() {});
    });
  }

  FlutterSecureStorage storage = FlutterSecureStorage();
  var token;
  void gettoken() async {
    token = await storage.read(key: "token");
    //getdata();
  }

  a() async {
    // ignore: await_only_futures
    await gettoken();

    var response = await http.post(
        "https://appcanteen.herokuapp.com/user/paymentdone",
        body: jsonEncode({'id': widget.oldorderid}),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json; charset=UTF-8',
        });
    //setState(() {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var val = json.decode(response.body);
      if (val['msg'] != null) {
        Fluttertoast.showToast(
            msg: val["msg"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
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
  }

  Widget getResponseScreen() {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        a();
        return PaymentSuccessfulScreen();
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailedScreen();
    }
    return PaymentSuccessfulScreen();
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              debuggingEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webController = controller;
                _webController.loadUrl(
                    new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                        .toString());
              },
              onPageFinished: (page) {
                if (page.contains("/process")) {
                  if (_loadingPayment) {
                    this.setState(() {
                      _loadingPayment = false;
                    });
                    setState(() {});
                  }
                }
                if (page.contains("/callback")) {
                  getData();
                }
              },
            ),
          ),
          (_loadingPayment)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(),
          (_responseStatus != STATUS_LOADING)
              ? Center(child: getResponseScreen())
              : Center()
        ],
      )),
    );
  }
}

/////////////////////////////////////$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
class PaymentSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset("assets/img/image1.png", width: 100)]),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Payment successful !!",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20)),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.green,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OrderPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class PaymentFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                    "assets/img/image2.jpg",
                    width: 100)
              ]),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Payment was not successful",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB71C1C),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please try again Later!",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB71C1C),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Color(0xFFB71C1C),
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OrderPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CheckSumFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Oh Snap!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
