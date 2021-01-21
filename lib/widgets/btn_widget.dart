import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  var btnText = "";
  var onClick;
  ButtonWidget({this.btnText, this.onClick});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        height: 40,
        width: 120,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10),
          color: Colors.orangeAccent,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.btnText,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
