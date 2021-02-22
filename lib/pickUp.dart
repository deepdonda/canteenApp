import 'package:canteen/navbar.dart';
import 'package:flutter/material.dart';

const iPrimarryColor = Color(0xFFF9FCFF);
const iAccentColor = Color(0xFFFFB44B);
const iAccentColor2 = Color(0xFFFFEAC9);
var a;

// ignore: must_be_immutable
class PickUP extends StatelessWidget {
  var items;
  PickUP({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    a = items;
    print(items);

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset("assets/img/image1.png", width: 100)]),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Order conformed!!",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20)),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(a["_id"],
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20))),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                InvoiceBody(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InvoiceBody extends StatefulWidget {
  @override
  _InvoiceBodyState createState() => _InvoiceBodyState();
}

class _InvoiceBodyState extends State<InvoiceBody> {
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
            //addItemAction(),
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
                    height:10,
                  )
                ],
              ),
            )),
            invoiceTotal(totalAmount),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row invoiceTotal(int totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Total: ",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
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

  // Row addItemAction() {
  //   return Row(
  //     children: [
  //       Text("Items", style: TextStyle(color: Colors.black, fontSize: 18)),
  //       SizedBox(
  //         width: 50,
  //       ),
  //       FlatButton(
  //         color: iAccentColor2,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
  //         child: Row(
  //           children: [Icon(Icons.add), Text("Add items")],
  //         ),
  //         onPressed: () {},
  //       )
  //     ],
  //   );
  // }
}
