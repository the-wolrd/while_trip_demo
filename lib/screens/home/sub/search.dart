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
            _recentSearch()
          ],
        ),
      ),
    );
  }

  Widget _topBar(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0, bottom: 20.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Text(widget.location, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
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
  Widget _searchBox(){
    return Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (_){
              setState(() {});
            },
            style: TextStyle(color: Colors.black),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.lightBlueAccent,
            controller: _searchController,
            decoration: new InputDecoration(
                icon:Icon(
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
        ));
  }
  Widget _recentSearch(){
    return Text('a');
  }
}
