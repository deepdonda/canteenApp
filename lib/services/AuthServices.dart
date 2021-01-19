import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
class Authservices
{
    Dio dio= new Dio();
    login(email,password) async{
      //print(email+" "+password);
      try{
        return await dio.post("https://appcanteen.herokuapp.com/login",
        data:{"email" : email,"p1":password},
        options:Options(contentType: Headers.formUrlEncodedContentType));

      }on DioError catch(e)
      {
        //print(e.response);
        Fluttertoast.showToast(msg:e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity:ToastGravity.BOTTOM,
        backgroundColor:Colors.red,
        textColor:Colors.white,
        fontSize:16.0

        );
      }
    }
    register(name,email,password,number) async
    {
      try{
        return await dio.post("https://appcanteen.herokuapp.com/register",
        data:{"email" : email,"p1":password,"phone":number,"name":name},
        options:Options(contentType: Headers.formUrlEncodedContentType));

      }on DioError catch(e)
      {
        //print(e.response);
        Fluttertoast.showToast(msg:e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity:ToastGravity.BOTTOM,
        backgroundColor:Colors.red,
        textColor:Colors.white,
        fontSize:16.0

        );
      }
    }
}