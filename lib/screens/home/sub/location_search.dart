import 'package:flutter/material.dart';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {

  TextEditingController _searchController = TextEditingController();

  List<String> results = [
    '대전광역시 유성구 ',
    '경상북도 포항',
    '경상남도 마산',
    '광주광역시',
    '부산광역시 해운대',
  ];

  List<String> recentSearch = [
    '포항',
    '제주',
    '효자',
    '대학로 291',
  ];


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                            Text('최근 설정 : 04.12', style: TextStyle(color: Colors.grey, fontSize: 12.0),),
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
                              Text('최근 설정 : 04.12', style: TextStyle(color: Colors.black, fontSize: 12.0),),
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
            child: Center(child: Text('위치 설정하기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),)),
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: (){
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
