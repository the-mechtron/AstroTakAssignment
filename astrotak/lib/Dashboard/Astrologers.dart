import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:astrotak/AstrologerPage/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

fetchAstrologersDetails(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == 200)
    return response.body;
  else
    return {"output":[]};
}

class Astrologer extends StatefulWidget{
  _Astrologer createState() => _Astrologer();
}

class _Astrologer extends State<Astrologer>{
  @override

  final url = "http://10.0.2.2:5000/dashboard/astrologers";
  var astrologers_data;
  List<Widget> widgets = [];
  extractData() async {
    var data = await fetchAstrologersDetails(url);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      astrologers_data = jsonDecode(data)["output"];
      widgets = _astrologersWidgets();
    });
  }
  void initState(){
    extractData();
    super.initState();
  }
  List<Widget> _astrologersWidgets(){
    if(astrologers_data == null || astrologers_data == []){
      return [];
    }
    widgets = [];
    for(int i=0; i<astrologers_data.length; i++){
      var item = astrologers_data[i];
      var name = item["name"];
      var skills = item["skills"].split(',');
      var charges = item["charges"].split('/');
      var language = item["language"].split(',');
      var experience = item["experience"];
      var imageUrl = item["imageUrl"];

      widgets.add(
          MaterialButton(
            onPressed: (){
              print(name);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 160,
                    height: 160,
                    color: Colors.white,
                    child: Image.network(imageUrl,fit: BoxFit.cover),
                  ),
                  Text(name, style: GoogleFonts.koHo(fontSize: 17, fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.all(6)),
                  Text(skills[0], style: GoogleFonts.koHo(fontSize: 12, color: Colors.blueGrey),),
                  Padding(padding: EdgeInsets.all(4)),
                  Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${charges[0]} Rs. /\n min", style: GoogleFonts.koHo(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                        Container(
                          width: 90,
                          height: 20,
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
            ),
          )
      );
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: size,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Talk to an Astrologer", style: GoogleFonts.koHo(fontSize:20, fontWeight: FontWeight.bold),),
                Container(
                  height: 20,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        minimumSize: Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AstrologerPage())
                        );
                      },
                      child: Text("See All>", style: GoogleFonts.koHo(color: Colors.deepOrangeAccent),)
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            width: size,
            child: Text(
              "Leading astrologers of India are just a phone call away. Our panel of astrologers not just provides solutions to your life problems but also guide you so that you can the right path towards growth and prosperity.",
              style: GoogleFonts.koHo(fontSize: 13),
              maxLines: null,
            ),
          ),
          Container(
            width: size,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _astrologersWidgets(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}