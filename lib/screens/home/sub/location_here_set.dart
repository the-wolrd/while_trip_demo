import 'package:flutter/material.dart';

class LocationHereSet extends StatefulWidget {
  @override
  _LocationHereSetState createState() => _LocationHereSetState();
}

class _LocationHereSetState extends State<LocationHereSet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Text('현재 위치로 설정'),));
  }
}
