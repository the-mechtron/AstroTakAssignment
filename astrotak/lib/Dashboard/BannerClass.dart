import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


fetchAstrologersDetails(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == 200)
    return response.body;
  else
    return {"output":[]};
}

class BannerClass extends StatefulWidget{
  _Banner createState() => _Banner();
}

class _Banner extends State<BannerClass>{
  @override

  final url = "http://10.0.2.2:5000/dashboard/banners";
  var astrologers_data;
  List<Widget> all_widgets = [];
  extractData() async {
    var data = await fetchAstrologersDetails(url);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      astrologers_data = jsonDecode(data)["output"];
      _astrologersWidgets();
      print(all_widgets);
    });
  }
  void initState(){
    extractData();
    super.initState();
  }
  void _astrologersWidgets(){
    if(astrologers_data == null || astrologers_data == []){
      return;
    }
    for(int i=0; i<astrologers_data.length; i++){
      var item = astrologers_data[i];
      var name = item["name"];
      var imageUrl = item["imageUrl"];

      all_widgets.add(
          MaterialButton(
            onPressed: ()async{
              if(await canLaunch("https://www.flutter.dev")){
                await launch("https://www.flutter.dev");
              }
              else{
                throw 'Could not launch https://www.flutter.dev"]}';
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: 200,
                  height: 100,
                  color: Colors.white,
                  child: Image.network(imageUrl,fit: BoxFit.cover),
                ),
              ],
            ),
          )
      );
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            width: size,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: all_widgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}