// import 'dart:io';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Authservices {
  Dio dio = new Dio();
  FlutterSecureStorage storage = FlutterSecureStorage();
  login(email, password) async {
    //print(email+" "+password);
    try {
      return await dio.post("https://appcanteen.herokuapp.com/login",
          data: {"email": email, "p1": password});
    } on DioError catch (e) {
      print(e.response);
      // e.response.data['msg']
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  register(name, email, password, number) async {
    try {
      return await dio.post("https://appcanteen.herokuapp.com/register", data: {
        "email": email,
        "p1": password,
        "phone": number,
        "name": name
      });
    } on DioError catch (e) {
      print(e.response);
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getfood() async {
    String token = await storage.read(key: "token");
    var response = await http.get(
      "https://appcanteen.herokuapp.com/user/getallfooditem",
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return json.decode(response.body);
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
}
