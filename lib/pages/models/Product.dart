import 'package:dio/dio.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Product {
   String foodname, foodimage, description,id;
   int foodprice, foodqty;
   Color color;
  Product({
    this.id,
    this.foodimage,
    this.foodname,
    this.foodprice,
    this.description,
    this.foodqty,
    this.color,
  });
  
      
      //on Dio
}
//   var val;
//       //print(email+" "+password);
//       try{
//         val= await dio.get("https://appcanteen.herokuapp.com/admin/getallfooditem",
//       Dio dio= new Dio();
//     getfood() async{
//      // print("hi");
    
//         options:Options(contentType: Headers.formUrlEncodedContentType)
//         );
//        // print(val);
//         return val;

//       }on DioError catch(e)
//       {
//         print(e);
//         Fluttertoast.showToast(msg:e.response.data['msg'],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity:ToastGravity.BOTTOM,
//         backgroundColor:Colors.red,
//         textColor:Colors.white,
//         fontSize:16.0

//         );
//       }
//     }
// // products=[];


// //cratelist();
// List<Product> products=cratelist();
// List<Product> abc=[];
// //List<Product> products=abc;


// cratelist(){
  
//  List<Product> products=[];
//   getfood().then((val){
//     val=val.data['msg'];
//    print(val);
//    print(val[0]['_id']);
 
//    print(val.length);
  
//    for(var i=0;i<val.length;i++)
//    {
   

//       products.add(
//         Product(
//         id: val[i]['_id'],
//         foodname: val[i]['foodname'],
//         foodprice: val[i]['foodprice'],
//         foodqty: val[i]['foodqty'],
//         description: "hello",
//         foodimage:"https://appcanteen.herokuapp.com/backend/uploads/"+val[i]['foodimage'],
//         color: Color(0xFF3D82AE)),
//       );
      
//    }
   
   
//   });
//   return products;
// }
// //List<Product> products=cratelist();
// //for(int i=0;i<products.length;i++)
//  // {
//    // print(products[i].foodname);
//  //  }

// // List<Product> products = [
// //   Product(
// //       id: 1,
// //       title: "Office Code",
// //       price: 234,
// //       size: 12,
// //       description: dummyText,
// //       image: "assets/images/bag_1.png",
// //       color: Color(0xFF3D82AE)),
// //   Product(
// //       id: 2,
// //       title: "Belt Bag",
// //       price: 234,
// //       size: 8,
// //       description: dummyText,
// //       image: "assets/images/bag_2.png",
// //       color: Color(0xFFD3A984)),
// //   Product(
// //       id: 3,
// //       title: "Hang Top",
// //       price: 234,
// //       size: 10,
// //       description: dummyText,
// //       image: "assets/images/bag_3.png",
// //       color: Color(0xFF989493)),
// //   Product(
// //       id: 4,
// //       title: "Old Fashion",
// //       price: 234,
// //       size: 11,
// //       description: dummyText,
// //       image: "assets/images/bag_4.png",
// //       color: Color(0xFFE6B398)),
// //   Product(
// //       id: 5,
// //       title: "Office Code",
// //       price: 234,
// //       size: 12,
// //       description: dummyText,
// //       image: "assets/images/bag_5.png",
// //       color: Color(0xFFFB7883)),
// //   Product(
// //     id: 6,
// //     title: "Office Code",
// //     price: 234,
// //     size: 12,
// //     description: dummyText,
// //     image: "assets/images/bag_6.png",
// //     color: Color(0xFFAEAEAE),
// //   ),
// // ];

// // String dummyText =
// //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
