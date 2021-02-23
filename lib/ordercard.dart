import 'package:canteen/PaymentScreen.dart';
import 'package:canteen/orderdetail.dart';
//import 'package:canteen/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var response, token;
FlutterSecureStorage storage = FlutterSecureStorage();
void gettoken() async {
  token = await storage.read(key: "token");
}

Widget orderCard(BuildContext context, int colors, var item) {
  // item=items["items"];
  //var colors=colors;
 // print(item);
  return Container(
    
    //height: 500,
    child: Card(
      // color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "OrderId:" + item["_id"],
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A192F),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Flexible(
                child: Text(
                  "Order Date:" + item["orderdate"],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A192F),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Flexible(
                child: Text(
                  "Status = " + item['status'],
                  style: TextStyle(
                    color: Color(colors),
                    fontSize: 15.0,
                    // color: Color(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Expanded(

                        child: Text(
                          "Total:" + item["total"].toString() + " ₹",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF0A192F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    SizedBox(width: 100,),
                    item["paymentstatus"] != "paid" ?FlatButton(
                    color: iAccentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment_sharp),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Pay", 
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    onPressed: () async {    
                          String a=DateTime.now().toString();
                          a=a.replaceAll('-', '');
                         a=a.replaceAll(' ', '');
                         a=a.replaceAll(':', '');
                         String orderid=item["_id"] + a;
                         
                         print(orderid);

                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PaymentScreen(amount: item["total"].toString(),useremail:item["useremail"],userid:item["userid"],contact:item["contact"],orderid:orderid,oldorderid:item["_id"])));
                    },
                  ):Center()
                ],
              ),
              SizedBox(
                height: 0.0,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Invoice(todo: item)));
          },
        ),
      ),
    ),
  );
}
