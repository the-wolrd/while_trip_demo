import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/widget/select_img_from_gallery.dart';
import 'package:while_trip_demo/constant/constants.dart';

class RegisterStore extends StatefulWidget {
  final StoreModel store;

  RegisterStore({this.store});

  @override
  _RegisterStoreState createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterStore> {
  final double _leftPadding = 20.0;
  final double _titleSize = 15.0;
  final double _contentSize = 25.0;

  bool _isNew = true;

  String _field = '';
  final TextEditingController _storeName = TextEditingController();
  String _location = '';
  final TextEditingController _detail = TextEditingController();
  final TextEditingController _storePhone = TextEditingController();
  final TextEditingController _homeLink = TextEditingController();
  List<dynamic> _photos = [];
  final TextEditingController _info = TextEditingController();
  List<Map<String, dynamic>> _prices = [
//    {'name': '서핑 강의 + 3시간 이용권', 'origin': '229,000원', 'final': '229,000원'},
//    {'name': '서핑 강의 + 6시간 이용권', 'origin': '349,000원', 'final': '349,000원'},
//    {'name': '3시간 자유이용권', 'origin': '149,000원', 'final': '149,000원'}
  ];
  final TextEditingController _optionName = TextEditingController(); // not in store class
  final TextEditingController _optionPrice = TextEditingController(); // not in store class

  final TextEditingController _specificInfo = TextEditingController();
  final TextEditingController _refundInfo = TextEditingController();
  final TextEditingController _cautionInfo = TextEditingController();

  @override
  void initState() {
    if (widget.store != null) {
      _isNew = false;
      _field = widget.store.field;
      _storeName.text = widget.store.storeName;
      _location = widget.store.location;
      _detail.text = widget.store.detail;
      _storePhone.text = widget.store.storePhone;
      _homeLink.text = widget.store.homeLink;
      _photos = widget.store.profileImgs;
      _info.text = widget.store.info;
      _prices = widget.store.prices;
      _specificInfo.text = widget.store.specificInfo;
      _refundInfo.text = widget.store.refundInfo;
      _cautionInfo.text = widget.store.cautionInfo;
    }

//    _storeName.text = '서귀포 서핑샵';
//    _detail.text = '1층';
//    _storePhone.text = '010-1234-5678';
//    _homeLink.text = 'https://www.instagram.com/jeju_surfing/';
//    _info.text = '제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑! 태평양에서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!';
//    _specificInfo.text = '제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑!\n태평양세서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!\n- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)';
//    _refundInfo.text = '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)';
//    _cautionInfo.text = '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)';

    super.initState();
  }

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
                    _pricesSet(),
                    _specificInfoSet(),
                    _refundInfoSet(),
                    _cautionInfoSet(),
                    _isNew ? _registerButton() : Container()
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
      child: InkWell(
        onTap: _registerStore,
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
      ),
    );
  }

  void _registerStore() async {
    if (_field.isEmpty ||
        _storeName.text.isEmpty ||
        _location.isEmpty ||
        _detail.text.isEmpty ||
        _info.text.isEmpty ||
        _homeLink.text.isEmpty ||
        _storePhone.text.isEmpty) {
      return;
    }

    Map<String, dynamic> storeTemp = Map();

    storeTemp[KEY_STOREKEY] = DateTime.now().millisecondsSinceEpoch.toString();
    storeTemp[KEY_OWNERKEY] = '123456789';
    storeTemp[KEY_PROFILEIMGS] = _photos;
    storeTemp[KEY_FIELD] = _field;
    storeTemp[KEY_STORENAME] = _storeName.text;
    storeTemp[KEY_LOCATION] = _location;
    storeTemp[KEY_DETAIL] = _detail.text;
    storeTemp[KEY_LAT] = 33.253894;
    storeTemp[KEY_LON] = 126.417486;
    storeTemp[KEY_INFO] = _info.text;
    storeTemp[KEY_REVIEWS] = [];
    storeTemp[KEY_PRICES] = _prices;
    storeTemp[KEY_SPECIFICINFO] = _specificInfo.text;
    storeTemp[KEY_REFUNDINFO] = _refundInfo.text;
    storeTemp[KEY_CAUTIONINFO] = _cautionInfo.text;
    storeTemp[KEY_HOMELINK] = _homeLink.text;
    storeTemp[KEY_STOREPHONE] = _storePhone.text;

    await networkFunction.createStore(storeTemp);
    Navigator.pop(context);
  }

  void _updateStore() async {
    Map<String, dynamic> storeTemp = Map();

    storeTemp['storeKey'] = widget.store.storeKey;
    storeTemp['ownerKey'] = '123456789';
    storeTemp['profileImgs'] = _photos;
    storeTemp['field'] = _field;
    storeTemp['storeName'] = _storeName.text;
    storeTemp['location'] = _location;
    storeTemp['detail'] = _detail.text;
    storeTemp['lat'] = 33.253894;
    storeTemp['long'] = 126.417486;
    storeTemp['info'] = _info.text;
    //'제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑! 태평양에서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!'
    storeTemp['reviews'] = [];
    storeTemp['prices'] = _prices;
    storeTemp['specificInfo'] = _specificInfo.text;
    //'제주도 여행에서 결코 놓칠 수 없는 것, 바로 제주 바닷가에서의 서핑!\n태평양세서부터 불어오는 바람과 파도를 직접 느낄 수 있는 서귀포 앞바다에서의 서핑을 지금 바로 즐겨보세요!\n- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)'
    storeTemp['refundInfo'] = _refundInfo.text;
    // '- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)'
    storeTemp['cautionInfo'] = _cautionInfo.text;
    //'- 예약 확정 후 , 무료코드가 바우처 또는 문자로 발송됩니다.\n- 각 업체별로 사용 가능한 쿠폰이 노출됩니다.\n- 무료쿠폰 코드는 등록 즉시 사용처리되므로, 사용일에 등록 바랍니다.\n- 오등록으로 인한 코드 재발급은 불가합니다.\n- 유효기간은 0000.00.00까지이며, 코드를 등록한 시점으로부터 168시간 (7일) 동안 사용하실 수 있습니다.\n- 업체 사정으로 인해 일부 혜택이 예고 없이 변경될 수 있습니다.\- 업체별 영업시간이 변돌될 수 있어, 방문 전 업체로 문의하시기 바랍니다. (전화문의 권장)\n- 쿠폰은 3시간에 1잔 사용할 수 있으며, 동일 업체는 당일 재사용이 불가능 합니다.\n- 이용기간 내 사용하지 않은 쿠폰은 소멸됩니다.(미사용 쿠폰에 대해 부분환불, 적립 불가)'
    storeTemp['homeLink'] = _homeLink.text;
    storeTemp['storePhone'] = _storePhone.text;

    networkFunction.updateStore(storeTemp, widget.store.storeKey);
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
                style: TextStyle(fontSize: 15.0),
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
                    child: Stack(
                      children: [
                        InkWell(
                          onTap:()async{
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SafeArea(
                                    child: CachedNetworkImage(
                                      imageUrl: _photos[index - 1],
                                      placeholder: (context, _) =>
                                          Container(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                    actions:[
                                      TextButton(
                                          child: Text('삭제하기', style: TextStyle(color: Colors.red),),
                                          onPressed:()async{
                                            await networkFunction.deleteProfileImg(imgUrl: _photos[index-1]);
                                            _photos.removeAt(index-1);
                                            Navigator.pop(context);
                                            setState((){});
                                          }
                                      ),
                                      TextButton(
                                          child: Text('뒤로가기'),
                                          onPressed:(){
                                            Navigator.pop(context);
                                          }
                                      )
                                    ]
                                );
                              },
                            );
                          },
                          child: SizedBox(
                              width: 100.0,
                              height: 100.0,
                              child: CachedNetworkImage(
                                imageUrl: _photos[index - 1],
                                placeholder: (context, _) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )),
                        ),
                        Positioned(
                          top: 0.0,
                          left:0.0,
                          child: Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.black87
                              ),
                              child: Center(child: Text('$index', style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () async {
                        if(!_isNew){
                          if(_photos.length < 10){
                            // await 안붙혀도 되는데... 노란줄이 떠서 붙힘
                            await Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectFromGallery(storeKey: widget.store.storeKey, updateFunc: (String imgUrl){
                              _photos.add(imgUrl);
                              setState(() {});
                            })));
                          }
                          else{
                            await showDialog(
                                context: context,
                                builder:(context){
                                  return AlertDialog(
                                    title: Text('사진 초과'),
                                    content: Text('10장 보다 많이 등록할 수 없습니다.\n기존의 사진을 삭제해주세요!'),
                                    actions: [
                                      TextButton(
                                        child: Text('확인'),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                }
                            );
                          }
                        }
                        else{
                          await showDialog(
                              context: context,
                              builder:(context){
                                return AlertDialog(
                                  title: Text('권한 없음'),
                                  content: Text('가게 등록이 된 후에 사진 업로드가 가능합니다.\n양식에 맞춰 가게 등록을 해주세요!'),
                                  actions: [
                                    TextButton(
                                      child: Text('확인'),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              }
                          );
                        }

                      },
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Image.asset('assets/home/add_img.png'),
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

  Widget _pricesSet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle('요약'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _leftPadding),
          child: SizedBox(
            height: 50.0 * (_prices.length + 1),
            child: ListView.builder(
              itemCount: _prices.length + 1,
              itemBuilder: (context, index) {
                if (index != _prices.length) {
                  return _pricesElement('${_prices[index]['name']}',
                      '${_prices[index]['origin']}', false,
                      index: index);
                } else {
                  return _pricesElement('옵션', '금액(원)', true);
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _pricesElement(String name, String price, bool _setOption,
      {int index}) {
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
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _setOption
                    ? TextField(
                        controller: _optionName,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                            hintText: name,
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1.0))),
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
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            hintText: price,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1.0))),
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
              icon: Icon(
                _setOption ? Icons.add : Icons.remove,
                color: _setOption ? Colors.lightBlueAccent : Colors.redAccent,
              ),
              onPressed: () {
                if (_setOption) {
                  if (_optionName.text != null &&
                      _optionPrice.text != null &&
                      _optionName.text != '' &&
                      _optionPrice.text != '') {
                    _prices.add({
                      'name': _optionName.text,
                      'origin': _optionPrice.text,
                      'final': _optionPrice.text
                    });
                    setState(() {});
                  }
                } else {
                  _prices.removeAt(index);
                  setState(() {});
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
              "액티비티 ${_isNew ? '등록' : '편집'}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            )),
          ),
          TextButton(
            child: Text(
              '${_isNew ? '' : '저장'}',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            onPressed: _isNew ? (){} : _updateStore,
          ),
        ],
      ),
    );
  }
}
