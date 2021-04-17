import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/network/network_function.dart';
import './sub/my_location.dart';
import '../../widget/advertise_part.dart';
import '../../widget/activity_card.dart';
import '../../screens/result/result_screen.dart';
import '../../constant/size.dart';
import '../../constant/category.dart';
import '../../screens/menu/menu_screen.dart';

import 'sub/search.dart';
import '../../widget/activity.dart';
import '../../widget/favorite.dart';
import '../../widget/history.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = '서귀포시 중문 관광로 72번길 75';

  double leftPadding = 20.0;

  List<String> imgList = [
    THEMEPARK_img,
    SURFING_img,
    BIKE_img,
    CAFE_img,
    CAMPING_img,
    CART_img,
    DRINKING_img,
    ETC_img,
    FISHING_img,
    FOOD_img,
    HORSE_img,
    MOUNTAIN_img,
    MUSIC_img,
    PARTY_img,
    PHOTO_img,
    WATER_LEISURE_img
  ];

  Map<String, String> categoryName = {
    THEMEPARK_img: '테마파크',
    SURFING_img: '서핑',
    BIKE_img: '바이크',
    CAFE_img: '카페',
    CAMPING_img: '캠핑',
    CART_img: '카트',
    DRINKING_img: 'Beer',
    ETC_img: '기타',
    FISHING_img: '낚시',
    FOOD_img: '음식',
    HORSE_img: '승마',
    MOUNTAIN_img: '등산',
    MUSIC_img: '음악',
    PARTY_img: '파티',
    PHOTO_img: '사진',
    WATER_LEISURE_img: '수상레저',
  };


  List<Map<String, dynamic>> card = [
    {
      'storeName': '서귀포 서핑샵',
      'location': '서귀포시 중문동',
      'score': 4.8,
      'reviewNum': 172,
      'content': '1일',
      'price_final': '79,900원',
      'price_origin': '229,000원',
      'img_path':'item1.png',
    },

    {
      'storeName': '윈드 1947\n카트 테마파크',
      'location': '서귀포시 토평공단로',
      'score': 4.7,
      'reviewNum': 258,
      'content': '1인용-기본(3회전)',
      'price_final': '25,000원',
      'price_origin': '',
      'img_path':'item2.png',
    },

    {
      'storeName': '제주 감귤\n체험 농장',
      'location': '서귀포시 색달동',
      'score': 4.8,
      'reviewNum': 69,
      'content': '1인',
      'price_final': '29,000원',
      'price_origin': '49,000원',
      'img_path':'item3.png',
    },

    {
      'storeName': '아다지오\n커피 전문점',
      'location': '서귀포시 종문동',
      'score': 4.3,
      'reviewNum': 25,
      'content': '',
      'price_final': '',
      'price_origin': '',
      'img_path':'item4.png',
    },
    {
      'storeName': '제주 승마장',
      'location': '한림읍 월림리',
      'score': 4.6,
      'reviewNum': 326,
      'content': '1인(3시간)',
      'price_final': '60,000원',
      'price_origin': '80,000원',
      'img_path':'item5.png',
    }
  ];

  @override
  Widget build(BuildContext context) {

    if (size == null) {
      size = MediaQuery.of(context).size;
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(context),
              _locationSet(),
              _banner(),
              _title(),
              _categoryList(),
              _recommendActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner(){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: AdvertisePart(),
    );
  }

  Widget _recommendActivity() {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('와일이 추천하는 여행 리스트',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          SizedBox(height: 10.0,),
          SizedBox(
            width: size.width-leftPadding,
            height: size.width,
            child: ListView.builder(
              itemCount: card.length,
                scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: StreamProvider<StoreModel>.value(
                    value: networkFunction.getAStoreModel('1d9v7seDfiv993'),

                    child: Consumer<StoreModel>(
                      builder: (context, store, _){
                        if(store == null){
                          return Container();
                        }
                        else{
                          return  ActivityCard(
                            store: store,
                          );
                        }
                      },

                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: leftPadding, vertical: 10.0),
      child: SizedBox(
        width: size.width - leftPadding * 2,
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: imgList.map((path) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                ResultScreen(keyword: categoryName[path])));
                      },
                      child: Image.asset(
                        path, height: 50.0, fit: BoxFit.fitHeight,)),
                  SizedBox(height: 10.0,),
                  Text(categoryName[path])
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        "제주도 여행은 \n와일!",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }

  Widget _locationSet() {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SetLocation()));
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding,
            top: 8.0,
            bottom: 10.0
        ),
        child: Row(
          children: [
            Text(
              location,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.arrow_drop_down,
                size: 25.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: leftPadding),
            child: Image.asset(
              'assets/home/logo_icon.png',
              height: 30.0,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          _iconButton('assets/home/search_icon.png', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen(location: location,)));
          }),
          _iconButton('assets/home/bag_icon.png', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivityScreen()));
          }),
          _iconButton('assets/home/star_icon.png', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FavoriteScreen()));
          }),
          _iconButton('assets/home/menu_icon.png', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MenuScreen()));
          }),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  Widget _iconButton(String path, Function clickEvent) {
    return InkWell(
      onTap: clickEvent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          path,
          height: 20.0,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
