import 'package:flutter/material.dart';

class Product {
  String foodname, foodimage, description, id;
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
}
