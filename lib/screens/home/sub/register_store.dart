import 'dart:io';

import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/size.dart';
import 'package:while_trip_demo/network/network_function.dart';

class RegisterStore extends StatefulWidget {
  @override
  _RegisterStoreState createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterStore> {
  final double _leftPadding = 20.0;
  final double _titleSize = 15.0;
  final double _contentSize = 25.0;

  String _field = '서핑';
  TextEditingController _storeName = TextEditingController();
  String _location = '대학로 291';
  TextEditingController _detail = TextEditingController();
  TextEditingController _storePhone = TextEditingController();
  TextEditingController _homeLink = TextEditingController();
  List<dynamic> _photos = [1, 2, 3, 4, 5];
  TextEditingController _info = TextEditingController();
  List<Map<String, dynamic>> _summaries = [
    {'name': '서핑 강의 + 3시간 이용권', 'origin': '229,000원', 'final': '229,000원'},
    {'name': '서핑 강의 + 6시간 이용권', 'origin': '349,000원', 'final': '349,000원'},
    {'name': '3시간 자유이용권', 'origin': '149,000원', 'final': '149,000원'}
  ];
  TextEditingController _optionName = TextEditingController();
  TextEditingController _optionPrice = TextEditingController();
  TextEditingController _specificInfo = TextEditingController();
  TextEditingController _refundInfo = TextEditingController();
  TextEditingController _cautionInfo = TextEditingController();

  @override
  void dispose() {
    _storeName.dispose();
    _detail.dispose();
    _storePhone.dispose();
    _homeLink.dispose();
    _info.dispose();
    _optionName.dispose();
    _optionPrice.dispose();
    _specificInfo.dispose();
    _refundInfo.dispose();
    _cautionInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            _topBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldContentSet(),
                    _storeNameSet(),
                    _locationSet(),
                    _detailSet(),
                    _storePhoneSet(),
                    _homeLinkSet(),
                    _photosSet(),
                    _infoSet(),
                    _summariesSet(),
                    _specificInfoSet(),
                    _refundInfoSet(),
                    _cautionInfoSet(),
                    _registerButton()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: _leftPadding),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.lightBlueAccent),
        child: Center(
            child: Text(
          '등록',
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }

  Widget _fieldContentSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('업태'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
            height: 40.0,
            width: size.width - 2 * _leftPadding,
            decoration: _contentBoxDecoration(),
            child: Row(
              children: [
                Text(
                  _field,
                  style: TextStyle(fontSize: _contentSize),
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {},
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _storeNameSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('상호 또는 업체명'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
            height: 40.0,
            width: size.width - 2 * _leftPadding,
            child: TextField(
                controller: _storeName,
                style: TextStyle(fontSize: _contentSize),
                decoration: _contentInputDecoration()),
          ),
        )
      ],
    );
  }

  Widget _locationSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('업체 주소'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
            height: 40.0,
            width: size.width - 2 * _leftPadding,
            decoration: _contentBoxDecoration(),
            child: Row(
              children: [
                Text(
                  _location,
                  style: TextStyle(fontSize: _contentSize),
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _detailSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('상세 주소'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
            height: 40.0,
            width: size.width - 2 * _leftPadding,
            child: TextField(
                controller: _detail,
                style: TextStyle(fontSize: _contentSize),
                decoration: _contentInputDecoration()),
          ),
        )
      ],
    );
  }

  Widget _storePhoneSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('업체 연락처'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
            height: 40.0,
            width: size.width - 2 * _leftPadding,
            child: TextField(
                controller: _storePhone,
                style: TextStyle(fontSize: _contentSize),
                decoration: _contentInputDecoration()),
          ),
        )
      ],
    );
  }

  Widget _homeLinkSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('업체 링크'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
            height: 40.0,
            width: size.width - 2 * _leftPadding,
            child: TextField(
                controller: _homeLink,
                style: TextStyle(fontSize: 20.0),
                decoration: _contentInputDecoration()),
          ),
        )
      ],
    );
  }

  Widget _photosSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('업체 사진 (최대 10장)'),
        Padding(
          padding: EdgeInsets.only(left: _leftPadding, top: 5.0, bottom: 5.0),
          child: SizedBox(
            height: 110.0,
            width: size.width - _leftPadding,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _photos.length + 1,
              itemBuilder: (context, index) {
                if (index != 0) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      color: Colors.lightBlueAccent,
                      child: Center(
                        child: Text('${index}'),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      color: Colors.grey,
                      child: Center(
                        child: Text('+'),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _infoSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('소개 (1,000자 이내)'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
              width: size.width - 2 * _leftPadding, child: _boxContent(_info)),
        )
      ],
    );
  }

  Widget _summariesSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('요약'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _leftPadding),
          child: SizedBox(
            height: 50.0 * (_summaries.length + 1),
            child: ListView.builder(
              itemCount: _summaries.length + 1,
              itemBuilder: (context, index) {
                if (index != _summaries.length) {
                  return _summariesElement('${_summaries[index]['name']}',
                      '${_summaries[index]['origin']}', false, index: index);
                } else {
                  return _summariesElement('옵션', '금액(원)', true);
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _summariesElement(String name, String price, bool _setOption, {int index}) {
    return SizedBox(
      width: size.width - 2 * _leftPadding,
      height: 50.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.0,
            width: size.width * 0.5,
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey[300])),
            child: Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _setOption
                    ? TextField(
                        controller: _optionName,
                        style: TextStyle(color: Colors.grey[300]),
                  decoration: InputDecoration(
                      hintText: name,
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 1.0))),
                      )
                    : Text(name),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.04,
          ),
          Container(
            height: 40.0,
            width: size.width * 0.34 - 2 * _leftPadding,
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey[300])),
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: _setOption
                    ? TextField(
                  controller: _optionPrice,
                  style: TextStyle(color: Colors.grey[300]),
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                      hintText: price,
                      hintStyle: TextStyle(color: Colors.grey, ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 1.0))),
                )
                    : Text(price),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          SizedBox(
            width: size.width * 0.1,
            height: 50.0,
            child: IconButton(
              icon: Icon(_setOption ? Icons.add : Icons.remove, color: _setOption? Colors.lightBlueAccent:Colors.redAccent,),
              onPressed: () {
                if(_setOption){
                  _summaries.add({

                  });
                }
                else {
                  _summaries.removeAt(index);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _specificInfoSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('상세 정보 (1,000자 이내)'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
              width: size.width - 2 * _leftPadding,
              child: _boxContent(_specificInfo)),
        )
      ],
    );
  }

  Widget _refundInfoSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('환불 규정 (1,000자 이내)'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
              width: size.width - 2 * _leftPadding,
              child: _boxContent(_refundInfo)),
        )
      ],
    );
  }

  Widget _cautionInfoSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('유의 사항 (1,000자 이내)'),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: _leftPadding, vertical: 5.0),
          child: Container(
              width: size.width - 2 * _leftPadding,
              child: _boxContent(_cautionInfo)),
        )
      ],
    );
  }

  TextField _boxContent(TextEditingController _controller) {
    return TextField(
        maxLines: 10,
        controller: _controller,
        style: TextStyle(fontSize: 12.0),
        decoration: InputDecoration(
            hintText: '내용 입력',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300], width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 1.0))));
  }

  InputDecoration _contentInputDecoration() {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300], width: 1.0)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent)));
  }

  BoxDecoration _contentBoxDecoration() {
    return BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 1.0, color: Colors.grey[300])));
  }

  Widget _contentTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15.0, bottom: 5.0, left: _leftPadding, right: _leftPadding),
      child: Text(
        '*$title',
        style: TextStyle(color: Colors.grey, fontSize: _titleSize),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: [
          TextButton(
            child: Text(
              '취소',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
                child: Text(
              "액티비티 등록",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            )),
          ),
          TextButton(
            child: Text(
              '저장',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            onPressed: () {
              Map<String, dynamic> storeTemp = Map();

              storeTemp['storeKey'] = 'asdfasdf';
              storeTemp['ownerKey'] = '123456789';
              storeTemp['profileImgs'] = [
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fytn.co.kr%2F_ln%2F0117_202005201300019997&psig=AOvVaw2rLbAZOt0T-DxHN9oKsXI4&ust=1618734599473000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOi18bruhPACFQAAAAAdAAAAABAD',
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fsorrento1979.tistory.com%2F452&psig=AOvVaw2rLbAZOt0T-DxHN9oKsXI4&ust=1618734599473000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOi18bruhPACFQAAAAAdAAAAABAg'
              ];
              storeTemp['field'] = '서핑';
              storeTemp['storeName'] = '서귀포 서핑샵';
              storeTemp['location'] = '서귀포시 중문관광로 94';
              storeTemp['detail'] = '1층';
              storeTemp['lat'] = 33.253894;
              storeTemp['long'] = 126.417486;
              storeTemp['info'] =
                  '제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑! 태평양에서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!';
              storeTemp['reviews'] = [];
              storeTemp['summarys'] = [
                {
                  'title': '서핑 강의 + 3시간 이용권',
                  'origin_price': '229,000원',
                  'final_price': '229,000원'
                },
                {
                  'title': '서핑 강의 + 6시간 이용권',
                  'origin_price': '349,000원',
                  'final_price': '349,000원'
                },
                {
                  'title': '3시간 자유이용권',
                  'origin_price': '149,000원',
                  'final_price': '149,000원'
                }
              ];
              storeTemp['specificInfo'] =
                  '제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑!\n태평양세서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!\n- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)';
              storeTemp['refundInfo'] =
                  '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)';
              storeTemp['cautionInfo'] =
                  '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)';
              storeTemp['homeLink'] = 'https://www.jmsurf.com/';
              storeTemp['storePhone'] = '01012345678';

              networkFunction.createStore(storeTemp);
            },
          ),
        ],
      ),
    );
  }
}
