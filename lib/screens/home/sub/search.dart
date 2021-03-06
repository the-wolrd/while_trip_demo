import 'package:flutter/material.dart';
import '../../../screens/menu/menu_screen.dart';

class SearchScreen extends StatefulWidget {

  final String location;

  SearchScreen({this.location});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = TextEditingController();

  List<String> results = [
    '서귀포 서핑샵',
    '윈드 1947 카트 테마파크',
    '제주 감귤 체험 농장',
    '아다지오 커피 전문점',
    '제주 승마장',
  ];

  List<String> recentSearch = [
    '서핑보드 렌트',
    '스킨스쿠버',
    '승마 체험장',
    '오션뷰 카페',
    '카페',
    '마리오 카트',
    'PC방',
    '스쿼시',
    '마라톤',
    '당구장'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _topBar(),
            _searchBox(),
            Expanded(child: _recentSearchAndresultPart()),
          ],
        ),
      ),
    );
  }

  Widget _recentSearchAndresultPart(){
    return Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: results.length + recentSearch.length,
                itemBuilder: (context, index){
                  if(index < recentSearch.length){
                    if(_searchController.text == null || _searchController.text == ''){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey[300],),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(recentSearch[index], style: TextStyle(color: Colors.grey, fontSize: 15.0),),
                            ),
                            Expanded(child: Container(),),
                            Text('04.12', style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: (){},
                            )
                          ],
                        ),
                      );
                    }
                    else{
                      if(recentSearch[index].contains(_searchController.text )){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(recentSearch[index], style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Expanded(child: Container(),),
                              Text('04.12', style: TextStyle(color: Colors.black, fontSize: 12.0),),
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){},
                              )
                            ],
                          ),
                        );
                      }
                      else{
                        return Container();
                      }
                    }

                  }
                  else{
                    if(_searchController.text == null || _searchController.text == ''){
                      return Container();
                    }
                    else{
                      if(results[index - recentSearch.length].contains(_searchController.text)){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey[300],),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(results[index - recentSearch.length]),
                              ),
                            ],
                          ),
                        );
                      }
                      else{
                        return Container();
                      }
                    }

                  }
                }),
          ),

        ]
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
            child: Center(child: Text(widget.location, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),)),
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuScreen()));
            },
          )
        ],
      ),
    );
  }
  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: (_) {
                setState(() {});
              },
              style: TextStyle(color: Colors.black),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.lightBlueAccent,
              controller: _searchController,
              decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "검색"),
            ),
          )),
    );
  }
}
