import 'package:canteen/pages/models/Product.dart';
import 'package:flutter/material.dart';
//import 'package:shop_app/constants.dart';
//
//import 'package:canteen/pages/models/Product.dart';
import 'package:canteen/pages/screens/details/details_screen.dart';

import 'categorries.dart';
import 'dart:convert';
import 'item_card.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
    static const kTextColor = Color(0xFF535353);
  static const kTextLightColor = Color(0xFFACACAC);

  static const kDefaultPaddin = 20.0;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var api = "https://appcanteen.herokuapp.com/admin/getallfooditem";

  List<Product> products=[];
  var res;

   @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await http.get(api);
    var val= jsonDecode(res.body)["msg"];
    print(val.toString());   
   for(var i=0;i<val.length;i++)
   {
      products.add(
        Product(
        id: val[i]['_id'],
        foodname: val[i]['foodname'],
        foodprice: val[i]['foodprice'],
        foodqty: val[i]['foodqty'],
        description: "hello",
        foodimage:"https://appcanteen.herokuapp.com/backend/uploads/"+val[i]['foodimage'],
        color: Colors.white),
      );
      
   
   
   
  }
  setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Body.kDefaultPaddin),
          child: Text(
            "Women",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        //Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Body.kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Body.kDefaultPaddin,
                  crossAxisSpacing: Body.kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: products[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}
