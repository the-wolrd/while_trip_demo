import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/widget/while_progress_indicator.dart';

class MyFavoriteScreen extends StatefulWidget {

  final UserModel user;

  MyFavoriteScreen({this.user});

  @override
  _MyFavoriteScreenState createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {

  List<Map<String, dynamic>> activities = [
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _topBar(),
            _content()
          ],
        ),
      ),
    );
  }

  Widget _content(){
    return FutureBuilder(
      future: networkFunction.getFavoritesFromUserKey(widget.user.userKey),
      builder: (context, storesSnapshot){
        if(!storesSnapshot.hasData){
          return WhileProgressIndicator();
        }
        else if(storesSnapshot.hasError){
          return Center(child:Text('에러가 발생하였습니다...\n문의 넣어주시면 빠른 시일내에 해결해드리겠습니다.'));
      }else{
          return _listActivity(storesSnapshot.data);
      }

      }
    );
  }

  Widget _listActivity(List<StoreModel> stores){

    if(stores.isEmpty){
      return Center(child: Text('등록된 즐겨찾기가 없습니다.'));
    }
    else{
      return Expanded(
        child: ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index){

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(false?-50.0:0, 0, 0),
                          child: SizedBox(
                            height: 140.0,
                            width: size.width + 50.0,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120.0,
                                    child: Image.asset('assets/stores/item1.png', height: 120.0,fit: BoxFit.fitHeight,)),
                                SizedBox(
                                  width: size.width - 120.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(stores[index].storeName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                                            Expanded(child: Container(),),
                                            IconButton(
                                              icon: Icon(Icons.star, color: Colors.lightBlueAccent,),
                                              onPressed: (){},
                                            )
                                          ],
                                        ),
                                        Text(stores[index].location, style: TextStyle(color: Colors.grey, fontSize: 15.0),),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.red, size: 10.0,),
                                            Icon(Icons.star, color: Colors.red, size: 10.0,),
                                            Icon(Icons.star, color: Colors.red, size: 10.0,),
                                            Icon(Icons.star, color: Colors.red, size: 10.0,),
                                            Text('4.7(15명)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                          ],
                                        ),
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
                          transform: Matrix4.translationValues(false?size.width-50.0:size.width, 0, 0),
                          child: SizedBox(
                            width: 50.0,
                            height:140.0,
                            child: Container(
                              color: Colors.red,
                              child: Center(child: Text('삭제', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey, thickness: 1.0,)
                ],
              );
            }),
      );
    }

  }

  Widget _topBar(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: Center(child: Text('관심목록', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),)),
          ),
          // 같은 사이즈의 IconButton을 넣어 중앙 배열이 되도록 함.
          IconButton(
            icon: const Icon(Icons.star, color: Colors.transparent,), onPressed: null,
          )
        ],
      ),
    );
  }
}
