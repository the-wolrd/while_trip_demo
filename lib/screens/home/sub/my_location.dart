import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'location_here_set.dart';
import 'location_search.dart';

class SetLocation extends StatefulWidget {

  final UserModel user;

  SetLocation({this.user});

  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {

  TextEditingController _searchController = TextEditingController();
  double rating = 0.0;
  int _rangeIndex = 0; // 0: 1km, 1: 5km , 2: 10km, 3: 20km

  List<String> rangeInfo = [
    '차로 5분 이내',
    '차로 10분 이내',
    '차로 20분 이내',
    '차로 30분 이내',
  ];

  @override
  void initState() {
    super.initState();
    if(widget.user != null){
      if(widget.user.range < 1000) _rangeIndex = 0;
      else if(widget.user.range < 5000) _rangeIndex = 1;
      else if(widget.user.range < 10000) _rangeIndex = 2;
      else _rangeIndex = 3;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final double leftPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(),
            _title(),
            _searchBox(),
            _nowLocationSet(),
            _rangeSet(),
            _rangeImg()
          ],
        ),
      ),
    ));
  }

  Widget _rangeImg(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(child: Image.asset('assets/map/map_range${_rangeIndex+1}.png', width: size.width*0.9, fit: BoxFit.fitWidth,)),
    );
  }

  Widget _rangeSet() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('범위 ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
              Text(rangeInfo[_rangeIndex], style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 15.0),),
            ],
          ),
        ),
        Slider(
          value: rating,
          onChanged: (newRating){
            setState((){
              _rangeIndex = (newRating*3.1).toInt();
              rating = newRating;
            });
          },
          divisions: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Row(
            children: [
              Text('1km', style: TextStyle(color: Colors.grey),),
              Spacer(flex: 1,),
              Text('5km', style: TextStyle(color: Colors.grey)),
              Spacer(flex: 1,),
              Text('10km', style: TextStyle(color: Colors.grey)),
              Spacer(flex: 1,),
              Text('20km', style: TextStyle(color: Colors.grey)),
            ],
          ),
        )
      ],
    );
  }

  Widget _nowLocationSet(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: leftPadding, vertical: 20.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationHereSet()));
        },
        child: Container(
          width: size.width - 2*leftPadding,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.limeAccent,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0)]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text(' 현재 위치로 설정', style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationSearch()));
        },
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: Text("예) 서귀포 중문동",style: TextStyle(color: Colors.grey),),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Icon(Icons.search , color: Colors.grey,),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _title(){
    return Padding(
      padding: EdgeInsets.only(left:leftPadding, bottom: 20.0),
      child: Text('지번 또는 도로명을\n입력하세요', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
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
            child: Center(child: Text("위치 설정하기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),)),
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: (){},
          )
        ],
      ),
    );
  }
}

