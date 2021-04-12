import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/size.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {

  bool setOption = false;

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
            _listActivity()
          ],
        ),
      ),
    );
  }

  Widget _listActivity(){
    return Expanded(
      child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        transform: Matrix4.translationValues(setOption?-50.0:0, 0, 0),
                        child: SizedBox(
                          height: 140.0,
                          width: size.width + 50.0,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 120.0,
                                  child: Image.asset('assets/stores/${activities[index]['img_path']}', height: 120.0,fit: BoxFit.fitHeight,)),
                              SizedBox(
                                width: size.width - 120.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(activities[index]['storeName'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                                      Text(activities[index]['location'], style: TextStyle(color: Colors.grey, fontSize: 15.0),),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.red, size: 10.0,),
                                          Icon(Icons.star, color: Colors.red, size: 10.0,),
                                          Icon(Icons.star, color: Colors.red, size: 10.0,),
                                          Icon(Icons.star, color: Colors.red, size: 10.0,),
                                          Text('${activities[index]['score']}(${activities[index]['reviewNum']})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                        ],
                                      ),
                                      Expanded(child: Container(),),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('관리 및 편집', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),))
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
                        transform: Matrix4.translationValues(setOption?size.width-50.0:size.width, 0, 0),
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

  Widget _topBar(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(child: Text("MY 액티비티", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),)),
          ),
          TextButton(
            child: Text(setOption?'완료':'편집', style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold)),
            onPressed: (){
              setState(() {
                setOption = !setOption;
              });
            },
          )
        ],
      ),
    );
  }
}
