import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/widget/activity_page_caution_info.dart';
import 'package:while_trip_demo/widget/activity_page_price.dart';
import 'package:while_trip_demo/widget/activity_page_refund_info.dart';
import 'package:while_trip_demo/widget/activity_page_review.dart';
import 'package:while_trip_demo/widget/activity_page_specific_info.dart';

import 'image_view_part.dart';
import 'set_button.dart';

class ActivityPage extends StatefulWidget {
  final StoreModel store;
  final bool isSet;

  ActivityPage({this.store, this.isSet = false});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with SingleTickerProviderStateMixin{
  var _scrollController, _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  double _selected =
      0.0; // 총 5개. 가격(0~0.8), 리뷰(0.8~1.6) , 상세정보(1.6~2.4), 환뷸 규정(2.4~3.2), 유의사항(3.2~4.0)
  final double _topBarHeight = 50.0;
  final double _indicatorBarHeight = 60.0;

  final ScrollController _hideBottomController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    _pageController.addListener(onPageChanged);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _hideBottomController.dispose();
    super.dispose();
  }

  void onPageChanged() {
    setState(() {
      _selected = _pageController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(Icons.phone, color: Colors.cyanAccent,),
        ),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            SizedBox(
              height: _topBarHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('취소'),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      widget.store.storeName,
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                  TextButton(
                    onPressed: () {
                      print(kToolbarHeight);
                    },
                    child: widget.isSet
                        ? Text('완료')
                        : IconButton(
                            icon: Icon(
                              Icons.star_border,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                  )
                ],
              ),
            ),
            Expanded(
              // child: CustomScrollView(
              //   controller: _hideBottomController,
              //   slivers: [
              //     SliverAppBar(
              //       automaticallyImplyLeading: false,
              //       pinned: true,
              //       collapsedHeight: _indicatorBarHeight,
              //       bottom: PreferredSize(
              //         preferredSize: Size.fromHeight(0.0),
              //         child: Column(
              //           children: [
              //             Container(
              //               height: 5.0,
              //               color: Colors.grey[300],
              //             ),
              //             _optionIndicator(),
              //             Container(
              //               height: 5.0,
              //               color: Colors.grey[300],
              //             ),
              //           ],
              //         ),
              //       ),
              //       expandedHeight: size.width * 1.2 + _indicatorBarHeight,
              //       flexibleSpace: FlexibleSpaceBar(
              //         stretchModes: [],
              //         collapseMode: CollapseMode.pin,
              //         background: _mainHome(),
              //       ),
              //     ),
              //     SliverToBoxAdapter(
              //         child: SizedBox(
              //       height: size.height,
              //       child: PageView(
              //         scrollDirection: Axis.horizontal,
              //         controller: _pageController,
              //         children: [
              //           _pages(13, '안녕'),
              //           _pages(18, '하세요'),
              //           _pages(25, '반갑'),
              //           _pages(35, '습니다'),
              //           _pages(5, 'ㅇㄴㅁㅇ'),
              //
              //         ],
              //       ),
              //     )),
              //   ],
              // ),
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: size.width * 1.2 + _indicatorBarHeight,
                        flexibleSpace: FlexibleSpaceBar(
                                stretchModes: [],
                                collapseMode: CollapseMode.pin,
                                background: _mainHome(),
                              ),
                      pinned: true,
                      floating: true,
                      snap: false,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        tabs: [
                          Tab(text: 'Page 1'),
                          Tab(text: 'Page 2'),
                          Tab(text: 'Page 3'),
                          Tab(text: 'Page 4'),
                        ],
                        controller: _tabController,
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    _pageView(1),
                    _pageView(10),
                    _pageView(100),
                    _pageView(23),

                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
            height: 60.0,
            width: size.width,
            child: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                    width: size.width,
                    height: 60.0,
                    color: Colors.white,
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            title: Text('바로 가기')),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            title: Text('즐겨찾기 등촉')),
                      ],
                      currentIndex: 0,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  ListView _pageView(int count) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Text('List Item $index'),
        );
      },
    );
  }


  Widget _optionIndicator() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: _indicatorBarHeight - 10.0,
          color: Colors.white,
          child: Row(
            children: [
              _barOption(0, '가격', width: size.width * 0.2),
              _barOption(1, '리뷰', width: size.width * 0.2),
              _barOption(2, '상세 정보', width: size.width * 0.2),
              _barOption(3, '환불 규정', width: size.width * 0.2),
              _barOption(4, '유의사항', width: size.width * 0.2),
            ],
          ),
        ),
        Positioned(
            bottom: 0.0,
            left: size.width * 0.2 * _selected,
            child: _indicator())
      ],
    );
  }

  Widget _indicator() {
    return Container(
      height: 5.0,
      width: size.width * 0.2,
      color: Colors.lightBlueAccent,
    );
  }

  Widget _mainHome() {
    return SizedBox(
      height: size.width * 1.2 + _indicatorBarHeight,
      //추가항목이 생기면 더 늘어날 수 도 있으니 보류
      width: size.width,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_imagesView(), _titleInfo(), _storeInfo()],
        ),
      ),
    );
  }

  Widget _imagesView() {
    return SizedBox(
        width: size.width,
        height: size.width * 0.6,
        child: ImageViewPart(
          imgUrls: [1, 2, 3, 4],
          imageHeight: size.width * 0.6,
        ));
  }

  Widget _titleInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          SizedBox(
            height: size.width * 0.3,
            width: size.width - 40.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width * 0.03,
                ),
                SizedBox(
                  height: size.width * 0.12,
                  child: Text(
                    widget.store.storeName,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.005,
                ),
                SizedBox(
                  height: size.width * 0.06,
                  child: Text(
                    '${widget.store.location} ${widget.store.detail}',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.005,
                ),
                SizedBox(
                  height: size.width * 0.06,
                  child: Text(
                    '4.8(${widget.store.reviews.length})',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.02,
                ),
              ],
            ),
          ),
          Positioned(
            top: size.width * 0.03,
            right: 0,
            child: SetButton(setFunc: () {}),
          )
        ],
      ),
    );
  }

  Widget _storeInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
          height: size.width * 0.3,
          width: size.width - 40.0,
          child: Center(
            child: Text(
              widget.store.info,
              style: TextStyle(
                fontSize: 14.0,
              ),
              overflow: TextOverflow.clip,
            ),
          )),
    );
  }

  Widget _barOption(int index, String text, {@required double width}) {
    return InkWell(
      onTap: () {
        setState(() {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        });
      },
      child: SizedBox(
          width: width,
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color:
                    (_selected >= 0.8 * index && _selected < 0.8 * (index + 1))
                        ? Colors.lightBlueAccent
                        : Colors.black),
          ))),
    );
  }
}
