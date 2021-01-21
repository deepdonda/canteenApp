import 'package:flutter/material.dart';


// ignore: must_be_immutable
class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
     
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 110,bottom: 20),
            child: Center(
              child: Image.asset(
                "assets/img/logo.png",
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.orange,fontSize: 30,fontWeight: FontWeight.bold,),
          )),
          
        ],
        
      ),
    );
  }
}