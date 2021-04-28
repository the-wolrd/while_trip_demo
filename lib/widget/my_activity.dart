import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/screens/home/sub/register_store.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/widget/business_transfer_page.dart';
import 'package:while_trip_demo/widget/while_progress_indicator.dart';

class MyActivityScreen extends StatefulWidget {
  final UserModel user;

  MyActivityScreen({this.user});

  @override
  _MyActivityScreenState createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  bool setOption = false;

//  List<Map<String, dynamic>> activities = [
//    {
//      'storeName': '서귀포 서핑샵',
//      'location': '서귀포시 중문동',
//      'score': 4.8,
//      'reviewNum': 172,
//      'content': '1일',
//      'price_final': '79,900원',
//      'price_origin': '229,000원',
//      'img_path': 'item1.png',
//    },
//    {
//      'storeName': '윈드 1947\n카트 테마파크',
//      'location': '서귀포시 토평공단로',
//      'score': 4.7,
//      'reviewNum': 258,
//      'content': '1인용-기본(3회전)',
//      'price_final': '25,000원',
//      'price_origin': '',
//      'img_path': 'item2.png',
//    },
//    {
//      'storeName': '제주 감귤\n체험 농장',
//      'location': '서귀포시 색달동',
//      'score': 4.8,
//      'reviewNum': 69,
//      'content': '1인',
//      'price_final': '29,000원',
//      'price_origin': '49,000원',
//      'img_path': 'item3.png',
//    },
//    {
//      'storeName': '아다지오\n커피 전문점',
//      'location': '서귀포시 종문동',
//      'score': 4.3,
//      'reviewNum': 25,
//      'content': '',
//      'price_final': '',
//      'price_origin': '',
//      'img_path': 'item4.png',
//    },
//    {
//      'storeName': '제주 승마장',
//      'location': '한림읍 월림리',
//      'score': 4.6,
//      'reviewNum': 326,
//      'content': '1인(3시간)',
//      'price_final': '60,000원',
//      'price_origin': '80,000원',
//      'img_path': 'item5.png',
//    }
//  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _topBar(),
          widget.user.isBusiness ? _isBusiness() : _isNotBusiness(),
        ],
      ),
      floatingActionButton: (widget.user.isBusiness && setOption)
          ? FloatingActionButton(
              backgroundColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterStore(
                            user: widget.user,
                            refreshAcitivities: () {
                              setOption = false;
                              setState(() {});
                            })));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : Container(),
    ));
  }

  Widget _isNotBusiness() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '비즈니스 계정이 아닙니다.\n지금 등록하시겠습니까?',
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BusinessTransferPage(user: widget.user)));
            },
            child: Text(
              '비즈니스 계정\n전환하기',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _isBusiness() {
    return FutureBuilder(
        future: networkFunction.getActivitiesFromUserKey(widget.user.userKey),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return WhileProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
                child: Text('에러가 발생하였습니다...\n문의 넣어주시면 빠른 시일내에 해결해드리겠습니다.'));
          } else {
            return _listActivity(snapshot.data);
          }
        });
  }

  Widget _listActivity(List<StoreModel> stores) {
    if (stores.isEmpty) {
      return Center(child: Text('액티비티를 등록해주세요.'));
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(
                              setOption ? -50.0 : 0, 0, 0),
                          child: SizedBox(
                            height: 140.0,
                            width: size.width + 50.0,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120.0,
                                    child: Image.asset(
                                      'assets/stores/item1.png',
                                      height: 120.0,
                                      fit: BoxFit.fitHeight,
                                    )),
                                SizedBox(
                                  width: size.width - 120.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          stores[index].storeName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          stores[index].location,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                        ),
                                        _scoreStar(),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                                onTap: () {
//                                                  StoreModel store =
//                                                  StoreModel.fromMap({
//                                                    'storeKey':
//                                                    'sov15ng4vh1wan199vs9Shv0w9',
//                                                    'ownerKey': '123456789',
//                                                    'profileImgs': [],
//                                                    'field': '서핑',
//                                                    'storeName': '서귀포 서핑샵',
//                                                    'location': '서귀포시 중문관광로 94',
//                                                    'detail': '1층',
//                                                    'lat': 33.253894,
//                                                    'lon': 126.417486,
//                                                    'info':
//                                                    '제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑! 태평양에서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!',
//                                                    'reviews': [],
//                                                    'prices': [
//                                                      {
//                                                        'name': '서핑 강의 + 3시간 이용권',
//                                                        'origin': '229,000원',
//                                                        'final': '229,000원'
//                                                      },
//                                                      {
//                                                        'name': '서핑 강의 + 6시간 이용권',
//                                                        'origin': '349,000원',
//                                                        'final': '349,000원'
//                                                      },
//                                                      {
//                                                        'name': '3시간 자유이용권',
//                                                        'origin': '149,000원',
//                                                        'final': '149,000원'
//                                                      }
//                                                    ],
//                                                    'specificInfo':
//                                                    '제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑!\n태평양세서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!\n- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)',
//                                                    'refundInfo':
//                                                    '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)',
//                                                    'cautionInfo':
//                                                    '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)',
//                                                    'homeLink':
//                                                    'https://www.instagram.com/jeju_surfing/',
//                                                    'storePhone': '010-1234-5678',
//                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterStore(
                                                                  store: stores[
                                                                      index],
                                                                  user: widget
                                                                      .user,
                                                                  refreshAcitivities:
                                                                      () {
                                                                    setOption =
                                                                        false;
                                                                    setState(
                                                                        () {});
                                                                  })));
                                                },
                                                child: Text(
                                                  '관리 및 편집',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(
                              setOption ? size.width - 50.0 : size.width, 0, 0),
                          child: InkWell(
                            onTap: () {
                              _removeActivities(stores[index].storeKey);
                            },
                            child: SizedBox(
                              width: 50.0,
                              height: 140.0,
                              child: Container(
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    '삭제',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  )
                ],
              );
            }),
      );
    }
  }

  void _removeActivities(String storeKey) async {
    await networkFunction.removeStore(storeKey);
    setOption = false;
    setState(() {});
  }

  Widget _scoreStar() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.red,
          size: 10.0,
        ),
        Icon(
          Icons.star,
          color: Colors.red,
          size: 10.0,
        ),
        Icon(
          Icons.star,
          color: Colors.red,
          size: 10.0,
        ),
        Icon(
          Icons.star,
          color: Colors.red,
          size: 10.0,
        ),
        Text(
          '4.7(15명)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ],
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
                child: Text(
              'MY 액티비티',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            )),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                setOption = !setOption;
              });
            },
            child: Text(widget.user.isBusiness? setOption ? '완료' : '편집' : '',
                style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
