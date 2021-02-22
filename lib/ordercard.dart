

import 'package:canteen/orderdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
var response,token ;
FlutterSecureStorage storage = FlutterSecureStorage();
void gettoken() async {
    token = await storage.read(key: "token");
         
  }

Widget orderCard( BuildContext context,int colors,var item) {
 // item=items["items"];
  //var colors=colors;
  return Container(
    //height: 500,
    child: Card(
      
     // color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(top:8,left: 8,right: 8),
        child: InkWell(
          child: Column(

            
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Flexible(
                child: Text(
                  "Order number:"+item["_id"],
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
                  "Order Date:"+item["orderdate"],
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
                  "Status = "+item['status'],
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
                
                children: [
                  Expanded(
                    child: Text(
                      "Total:"+item["total"].toString()+" Rs",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF0A192F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                ],
              )
            ],
          ),
          onTap:(){
             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Invoice(todo:item)));
                                    
           
          },
        ),
      ),
    ),
  );
}
