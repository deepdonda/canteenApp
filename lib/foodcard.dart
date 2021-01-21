import 'package:flutter/material.dart';

Widget foodCard(String img, String title, int price,int qty) {
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
                    onPressed: () {},
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
