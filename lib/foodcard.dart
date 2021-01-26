import 'package:flutter/material.dart';
import 'dart:convert';
//import 'dart:js';
//import 'package:canteen/cart.dart';
//import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
var response,token ;
FlutterSecureStorage storage = FlutterSecureStorage();
void gettoken() async {
    token = await storage.read(key: "token");
         
  }

Widget foodCard(String img, String title, int price,int qty,var item) {
  return Container(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.only(top:8,left: 8,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              img,
              height: 120.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Flexible(
              child: Text(
                title ,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A192F),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Flexible(
              child: Text(
                "Quantity = "+qty.toString(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF0A192F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    price.toString()+" Rs",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF0A192F),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () async {
                      gettoken();
                      print(item);
                      var response = await http.post("https://appcanteen.herokuapp.com/user/addtocart",
                      body: jsonEncode(
                       {"_id":item['_id'],"unlimited":item['unlimited'],"foodprice":item['foodprice'],
                       "foodimage":item['foodimage'],'foodname':item['foodname'],'foodqty':1}),
                                   
                      headers: {"Authorization": "Bearer $token",
                      'Content-Type': 'application/json; charset=UTF-8',}
                      );
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
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something went wrong!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Color(0xFF0A192F),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
