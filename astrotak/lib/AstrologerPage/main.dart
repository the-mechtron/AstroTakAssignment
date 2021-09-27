import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:http/http.dart' as http;

fetchAstrologersDetails(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == 200)
    return response.body;
  else
    return {"output":[]};
}

class AstrologerPage extends StatefulWidget{
  _AstrologerPage createState() => _AstrologerPage();
}

class _AstrologerPage extends State<AstrologerPage>{
  final url = "http://10.0.2.2:5000/dashboard/astrologers";
  TextEditingController editingController = TextEditingController(text: "");
  var astrologers_data;
  var filter = "Remove";
  var sort = "false";
  var widegets = [];
  extractData() async {
    var data = await fetchAstrologersDetails(url);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      astrologers_data = jsonDecode(data)["output"];
      filterSearchResults('', sort, filter);
      print(widegets.length);
    });
  }
  void initState(){
    extractData();
    super.initState();
  }
  @override
  Widget build(BuildContext context)  {
    // filterSearchResults("", false);
    // print(astrologers_data.length);
    // print(astrologers_data.length);
    var _currentSelectedItem;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  child: IconButton(
                    onPressed: (){
                      print("A");
                    },
                    color: Colors.red,
                    icon: Image.asset('assets/hamburger.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Image.asset('assets/logo.png'),
                  width: 60,
                ),
                Container(
                  width: 40,
                  child: IconButton(
                    onPressed: (){
                      print("A");
                    },
                    color: Colors.red,
                    icon: Image.asset('assets/profile.png'),
                  ),
                )
              ],
            )
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Talk to an Astrologer", style: GoogleFonts.koHo(fontSize:20, fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Container(width: 40,
                          child: PopupMenuButton(
                            // isExpanded: true,
                            icon: Container(
                              width: 40,
                              child: Image.asset('assets/filter.png'),
                            ),
                            itemBuilder: (BuildContext context){
                              return ["English","Hindi","Remove"].map((val){
                                return PopupMenuItem(value:val,child: Text(val, style: GoogleFonts.koHo(),));
                              }).toList();
                            },
                            // value: _currentSelectedItem,
                            onSelected: (value){
                              setState(() {
                                _currentSelectedItem = value;
                                setState(() {
                                  filter = value;
                                  print(filter);
                                  filterSearchResults(editingController.text.toString(), sort, filter);
                                });
                                // filterSearchResults('', value+1);
                              });
                            },
                          )
                      ),
                      Container(width: 40,
                          child: PopupMenuButton(
                            // isExpanded: true,
                            icon: Container(
                              width: 40,
                              child: Image.asset('assets/sort.png'),
                            ),
                            itemBuilder: (BuildContext context){
                                return ["Experience-High-to-Low","Experience-Low-to-High","Price-Low-to-High", "Price-High-to-Low"].map((val){
                                  return PopupMenuItem(value:val,child: Text(val, style: GoogleFonts.koHo(),));
                              }).toList();
                              },
                              // value: _currentSelectedItem,
                            onSelected: (value){
                              setState(() {
                                _currentSelectedItem = value;
                                setState(() {
                                  sort = value;
                                  filterSearchResults(editingController.text.toString(), sort, filter);
                                });
                                // filterSearchResults('', value+1);
                              });
                            },
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value, sort, filter);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              // scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ...widegets
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void filterSearchResults(String search, var sort, var filter) async {
    widegets = [];
    if(astrologers_data == null){
      return;
    }
    if(sort == "Price-Low-to-High"){
      astrologers_data.sort( (a,b) {
        int a1 = int.parse((a["charges"].split('/'))[0]);
        int b1 = int.parse((b["charges"].split('/'))[0]);
        if(a1 > b1){
          return 1;
        }
        return 0;
      });
    }
    if(sort == "Price-High-to-Low"){
      astrologers_data.sort( (a,b) {
        int a1 = int.parse((a["charges"].split('/'))[0]);
        int b1 = int.parse((b["charges"].split('/'))[0]);
        if(a1 < b1){
          return 1;
        }
        return 0;
      });
    }
    if(sort == "Experience-Low-to-High"){
      astrologers_data.sort( (a,b) {
        int a1 = a["experience"];
        int b1 = b["experience"];
        if(a1 > b1){
          return 1;
        }
        return 0;
      });
    }
    if(sort == "Experience-High-to-Low"){
      astrologers_data.sort( (a,b) {
        int a1 = a["experience"];
        int b1 = b["experience"];
        if(a1 < b1){
          return 1;
        }
        return 0;
      });
    }
    for(int i=0; i<astrologers_data.length;i++) {
      var item = astrologers_data[i];
      String name = item["name"];
      String skills = item["skills"];
      var charges = item["charges"].split('/');
      String language = item["language"];
      String imageUrl = item["imageUrl"];
      int experience = item["experience"];
      Widget widget = Container();
      if(name.contains(search) || skills.contains(search) || charges.contains(search) || language.contains(search)){
          widget =  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: 120,
                  color: Colors.white,
                  child: Image.network(imageUrl,fit: BoxFit.contain),
                ),
                Container(
                  width: 260,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name, style: GoogleFonts.koHo(fontSize: 17, fontWeight: FontWeight.bold),),
                          Text("$experience Years", style: GoogleFonts.koHo(),)
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                      Text(skills, maxLines: null, style: GoogleFonts.koHo(fontSize: 12, color: Colors.blueGrey),),
                      Padding(padding: EdgeInsets.all(4)),
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${charges[0]} Rs./min", style: GoogleFonts.koHo(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(4)),
                      Text(language, maxLines: null, style: GoogleFonts.koHo(fontSize: 12, color: Colors.blueGrey),),
                      Padding(padding: EdgeInsets.all(4)),
                      Container(
                        width: 150,
                        height: 40,
                        child: MaterialButton(
                          onPressed: (){},
                          color: Colors.deepOrangeAccent,
                          child: Text("Talk Now", style: GoogleFonts.koHo(fontSize: 12, color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      }
      if(filter == "Remove"){
        setState(() {
          widegets.add(widget);
        });
        continue;
      }
      if(language.contains(filter)){
        setState(() {
          widegets.add(widget);
        });
      }
    }
  }
}