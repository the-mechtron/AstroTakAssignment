import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

fetchHoroscopeDetails(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == 200)
    return response.body;
  else
    return {"output":[]};
}

class Horoscope extends StatefulWidget{
  _Horoscope createState() => _Horoscope();
}

class _Horoscope extends State<Horoscope>{
  @override
  final url = "http://10.0.2.2:5000/dashboard/zodiac";
  var horoscope_data;
  List<Widget> widgets = [];
  extractData() async {
    var data = await fetchHoroscopeDetails(url);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      horoscope_data = jsonDecode(data)["output"];
      widgets = _horoscopeWidgets();
    });
  }
  void initState(){
    extractData();
    super.initState();
  }
  List<Widget> _horoscopeWidgets(){
    if(horoscope_data == null || horoscope_data == []){
      return [];
    }
    widgets = [];
    for(int i=0; i<12; i++){
      var item = horoscope_data[i];
      var name = item["name"];
      var imageUrl = item["imageUrl"];
      var date = item["date"];
      widgets.add(
        MaterialButton(
          onPressed: (){
            print(name);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0,10,0,10),
                child: Container(
                  // padding: EdgeInsets.all(10),
                  width: 80,
                  height: 80,
                  color: Colors.red,
                  child: Image.network(imageUrl),
                ),
              ),
              Text(name, style: GoogleFonts.koHo(fontSize: 15, fontWeight: FontWeight.bold),),
              Text(date, style: GoogleFonts.koHo(fontSize: 11, color: Colors.blueGrey),)
            ],
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
                Text("Daily Horoscope", style: GoogleFonts.koHo(fontSize:20, fontWeight: FontWeight.bold),),
                Container(
                  height: 20,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                          minimumSize: Size(50, 30),
                          alignment: Alignment.centerLeft,
                      ),
                      onPressed: (){},
                      child: Text("See All>", style: GoogleFonts.koHo(color: Colors.deepOrangeAccent),)
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            width: size,
            child: Text(
              "Read your daily horoscope based on your sunsign, select your zodiac sign and give the right start to your day.",
              style: GoogleFonts.koHo(fontSize: 13),
              maxLines: null,
            ),
          ),
          Container(
            width: size,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}