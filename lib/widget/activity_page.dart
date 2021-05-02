import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/useful/cal_score.dart';
import 'package:while_trip_demo/widget/activity_page_caution_info.dart';
import 'package:while_trip_demo/widget/activity_page_price.dart';
import 'package:while_trip_demo/widget/activity_page_refund_info.dart';
import 'package:while_trip_demo/widget/activity_page_review.dart';
import 'package:while_trip_demo/widget/activity_page_specific_info.dart';
import 'package:while_trip_demo/widget/star_score.dart';
import 'package:while_trip_demo/widget/while_progress_indicator.dart';

import 'image_view_part.dart';
import 'set_button.dart';

class ActivityPage extends StatefulWidget {
  final StoreModel store;
  final UserModel user;

  ActivityPage({this.store, this.user});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  bool _isSet;

  var _scrollController, _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  int _selected = 0 ; // 0 : 가격, 1 : 리뷰, 2 : 상세정보, 3 : 환불규정, 4 : 유의사항
  final double _topBarHeight = 50.0;
  final double _indicatorBarHeight = 60.0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selected = _tabController.index;
        print(_tabController.index);
      });
    });
    _isSet = (widget.store.ownerKey == widget.user.userKey);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            FloatingActionButton(
              backgroundColor: Colors.lightBlueAccent,
              onPressed: (){ },
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
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
                    child: !_isSet
                        ? Container()
                        :
                    IconButton(
                            icon: ImageIcon(AssetImage('assets/stars/favorite_not.png'), size: 20.0,color: Colors.grey,),
                      //icon: ImageIcon(AssetImage('assets/stars/favorite_yes.png'), size: 20.0,color: Colors.amber,),
                            onPressed: () {},
                          ),
                  )
                ],
              ),
            ),
            FutureBuilder<List<ReviewModel>>(
              future: networkFunction.getReviewsFromStoreKey(widget.store.storeKey),
              builder: (context, reviews) {
                if(!reviews.hasData){
                  return WhileProgressIndicator();
                }
                else if(reviews.hasError){
                  return Center(child:Text('데이터를 불러오는 과정에서\n에러가 발생했습니다.\n문의주시면 감사하겠습니다.',textAlign: TextAlign.center,));
                }
                return Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false, // 화면 왼쪽 상단에 뒤로가기 화살표 없애주는 것
                          expandedHeight: size.width * 1.2 + _indicatorBarHeight,
                          flexibleSpace: FlexibleSpaceBar(
                            stretchModes: [],
                            collapseMode: CollapseMode.pin,
                            background: _mainHome(reviews: reviews.data),
                          ),
                          pinned: true,
                          floating: true,
                          snap: false,
                          forceElevated: innerBoxIsScrolled,
                          bottom: TabBar(
                            onTap: (i) {
                              print(i);
                              print(_tabController.index);
                            },
                              indicatorColor: Colors.lightBlueAccent,
                            labelPadding: const EdgeInsets.all(0.0),
                            tabs: [
                              Tab(
                                  child: Center(
                                      child: Text('가격',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: _selected == 0
                                                  ? Colors.lightBlueAccent
                                                  : Colors.black)))),
                              Tab(
                                  child: Center(
                                      child: Text('리뷰',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: _selected == 1
                                                  ? Colors.lightBlueAccent
                                                  : Colors.black)))),
                              Tab(
                                  child: Center(
                                      child: Text('상세정보',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: _selected == 2
                                                  ? Colors.lightBlueAccent
                                                  : Colors.black)))),
                              Tab(
                                  child: Center(
                                      child: Text('환불규정',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: _selected == 3
                                                  ? Colors.lightBlueAccent
                                                  : Colors.black)))),
                              Tab(
                                  child: Center(
                                      child: Text('유의사항',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: _selected == 4
                                                  ? Colors.lightBlueAccent
                                                  : Colors.black)))),
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
                              _pageView(19),
                            ],
                          )
                  ),
                );
              }
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
            height: 60.0,
            width: size.width,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5.0),
                  child: Row(
                    children: [
                      Spacer(flex:1),
                      Container(
                        width: size.width*0.45,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.lightBlueAccent
                        ),
                        child: Center(child: Text('바로가기', style: TextStyle(color: Colors.white),)),
                      ),
                      Spacer(flex:1),
                      Container(
                        width: size.width*0.45,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(width: 1.0, color: Colors.lightBlueAccent),
                            color: Colors.white
                        ),
                        child: Center(child: Text('관심등록', style: TextStyle(color: Colors.lightBlueAccent),)),
                      ),
                      Spacer(flex:1),
                    ],
                  ),
                )
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

  Widget _mainHome({List<ReviewModel> reviews}) {
    return SizedBox(
      height: size.width * 1.2 + 10.0,
      //추가항목이 생기면 더 늘어날 수 도 있으니 보류
      width: size.width,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_imagesView(), _titleInfo(reviews: reviews), _storeInfo(), Container(height:10.0, color:Colors.grey[50])],
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

  Widget _titleInfo({List<ReviewModel> reviews}) {
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StarScore(score: CalScore().scoreFromReviews(reviews), height: size.width * 0.06,),
                      Text(
                        '${CalScore().scoreFromReviews(reviews)}(${widget.store.reviews.length}명)',
                        style:
                            TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
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
