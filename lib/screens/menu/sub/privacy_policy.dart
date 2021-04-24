import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/constants.dart';


class PrivacyPolicy extends StatefulWidget{
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();

  final TabController _tabController = TabController(length: 4, vsync: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Expanded(
          child: Text('ds'),

        ),
      ),
    );
  }
}
