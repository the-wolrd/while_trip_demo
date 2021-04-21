import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text('dasdasd'),
              pinned: true,
              floating: true,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(text: 'Page 1'),
                  Tab(text: 'Page 2'),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _pageView(),
            _pageView(),
          ],
        ),
      ),
    );
  }

  ListView _pageView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text('List Item $index'),
          ),
        );
      },
    );
  }

  ListView _pages(int count) {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Center(
              child: Text(
            'dsa',
            textScaleFactor: 4,
          ));
        });
  }
}
