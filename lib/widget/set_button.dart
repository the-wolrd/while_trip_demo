import 'package:flutter/material.dart';

Widget SetButton({@required Function setFunc}){
  return InkWell(
    onTap: setFunc,
    child: Container(
      height: 30.0,
      width: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.grey,
      ),
      child: Center(child: Text('편집',style: TextStyle(color: Colors.white),)),
    ),
  );
}