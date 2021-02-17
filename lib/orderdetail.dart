import 'package:canteen/navbar.dart';
import 'package:flutter/material.dart';

// class ScreenConfig {
//   static double deviceWidth;
//   static double deviceHeight;
//   static double designHeight = 1300;
//   static double designWidth = 600;
//   static init(BuildContext context) {
//     deviceWidth = MediaQuery.of(context).size.width;
//     deviceHeight = MediaQuery.of(context).size.height;
//   }

//   // Designer user 1300 device height,
//   // so I have to normalize to the device height
//   static double getProportionalHeight(height) {
//     return (height / designHeight) * deviceHeight;
//   }

//   static double getProportionalWidth(width) {
//     return (width / designWidth) * deviceWidth;
//   }
// }

// Colors
const iPrimarryColor = Color(0xFFF9FCFF);
const iAccentColor = Color(0xFFFFB44B);
const iAccentColor2 = Color(0xFFFFEAC9);
var a;
const demoData = [
  {
    "imagePath": "assets/images/image-1.png",
    "price": 5,
    "quantity": 2,
    "itemDesc": "Gingerbread Cake with orange cream chees"
  },
  {
    "imagePath": "assets/images/image-3.png",
    "price": 10,
    "quantity": 4,
    "itemDesc": "Sauteed Onion and Hotdog with Ketchup"
  },
  {
    "imagePath": "assets/images/image-2.png",
    "price": 14,
    "quantity": 1,
    "itemDesc": "Supreme Pizza Recipe"
  }
];


class Invoice extends StatelessWidget {
  var todo;
  Invoice({Key key, @required this.todo}) : super(key: key);

  
 
  @override
  Widget build(BuildContext context) {
     print(todo);
     a=todo;

    //ScreenConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodZone",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //Now we are going to open a new file
      // where we will create the layout of the Drawer
      drawer: Drawer(
          child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Navbar(),
      )),
      // body: Center(child: Text("home page"),),
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
            //Now let's build the food menu
            //I'm going to create a custom widget
          ],
        ),
      ),
    );
  }

  Widget invoiceHeader() {
    return Container(
      width: 600,
      //ScreenConfig.deviceWidth,
      height: 300,
      //ScreenConfig.getProportionalHeight(374),
      color: Color(0xFF4D4F52),
      padding: EdgeInsets.only(
        top: 10,
        // ScreenConfig.getProportionalHeight(50),
        left: 20,
        //ScreenConfig.getProportionalWidth(40),
        right: 20,
        // ScreenConfig.getProportionalWidth(40)
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
                  //ScreenConfig.getProportionalHeight(56)
                ),
              ),
              SizedBox(
                height: 10,
                // ScreenConfig.getProportionalHeight(20),
              ),
              topHeaderText(todo["_id"]),
              SizedBox(
                height: 10,
                //ScreenConfig.getProportionalHeight(20),
              ),
              // TODO: form get actual date and format it accondingly
              topHeaderText(todo["orderdate"]),
              SizedBox(
                height: 10,
                //ScreenConfig.getProportionalHeight(20),
              ),
              // TODO: form get actual date and format it accondingly
              topHeaderText(todo["status"]),
            ],
          ),
          SizedBox(
            height: 40,
            //ScreenConfig.getProportionalHeight(20),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    "https://raw.githubusercontent.com/developFlexUI/invoice-flutter-ui/main/assets/icons/icons8-receipt.png",
                    height: 50,
                    //ScreenConfig.getProportionalHeight(78),
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
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "KK 234 rd 23 st",
        ),
        SizedBox(
          height: 10,
        ),
        Text("Kimihurura")
      ],
    );
  }

  Text topHeaderText(String label) {
    return Text(label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 15,
          // ScreenConfig.getProportionalHeight(23)
        ));
  }
}

////////////////
class InvoiceBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var totalAmount = 64;
    double height = 300;
    //ScreenConfig.deviceHeight - ScreenConfig.getProportionalHeight(374);
    return Container(
      height: height,
      width: 600,
      padding: EdgeInsets.only(
        top: 10,
        // ScreenConfig.getProportionalHeight(50),
        left: 0,
        //ScreenConfig.getProportionalWidth(40),
        right: 0,
        // ScreenConfig.getProportionalWidth(40)
      ),
      // padding: EdgeInsets.symmetric(
      //     horizontal: 40,
      //    // ScreenConfig.getProportionalWidth(40)
      //    ),
      color: iPrimarryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
              //ScreenConfig.getProportionalHeight(27),
            ),
            addItemAction(),
            SizedBox(
              height: 20,
              //ScreenConfig.getProportionalHeight(40),
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
                    height: 20,
                    //ScreenConfig.getProportionalHeight(24),
                  )
                ],
              ),
            )),
            invoiceTotal(totalAmount),
            SizedBox(height: 20
                // ScreenConfig.getProportionalHeight(56),
                ),
            FlatButton(
              color: iAccentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                height: 50,
                //ScreenConfig.getProportionalHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download),
                    SizedBox(
                      width: 21,
                      //ScreenConfig.getProportionalWidth(21),
                    ),
                    Text(
                      "Download now",
                      style: TextStyle(
                          fontSize: 20,
                          // ScreenConfig.getProportionalHeight(27),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onPressed: () {},
            )
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
              "Total: ",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontSize: 20,
                //ScreenConfig.getProportionalHeight(32)
              ),
            ),
            SizedBox(
              width: 50,
              //ScreenConfig.getProportionalWidth(50),
            ),
            Text(
              a["total"].toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                //ScreenConfig.getProportionalHeight(32)
              ),
            )
          ],
        )
      ],
    );
  }

  Container invoiceItem(
      int quantity, String imagePath, int price, String itemDesc) {
    int totalValue = quantity*price;

    return Container(
      height: 50,
      width: 600,
      //ScreenConfig.getProportionalHeight(170),
      padding: EdgeInsets.symmetric(
        horizontal: 27,
        // ScreenConfig.getProportionalWidth(27)
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
            quantity.toString(),
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold),
          ),
          // Image.network(
          //     "https://storage.googleapis.com/canteen-assets/1-25-2021-19-1-56-6.jpg",
          //     width: 10,
          //     ),
          Text(
            "\$$price",
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 100,
            //ScreenConfig.getProportionalWidth(145),
            child: Text(
              itemDesc,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            "\$$totalValue",
            style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Row addItemAction() {
    return Row(
      children: [
        Text("Items",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18 //ScreenConfig.getProportionalHeight(30)
                )),
        SizedBox(
          width: 50, //ScreenConfig.getProportionalWidth(50),
        ),
        FlatButton(
          color: iAccentColor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [Icon(Icons.add), Text("Add items")],
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
