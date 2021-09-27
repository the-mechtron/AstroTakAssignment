import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


fetchReportDetails(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == 200)
    return response.body;
  else
    return {"output":[]};
}

class ReportClass extends StatefulWidget{
  _Report createState() => _Report();
}

class _Report extends State<ReportClass>{
  @override

  final url = "http://10.0.2.2:5000/dashboard/banners";
  var report_data;
  extractData() async {
    var data = await fetchReportDetails(url);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      report_data = jsonDecode(data)["output"];
    });
  }
  void initState(){
    extractData();
    super.initState();
  }
  List<Widget> _astrologersWidgets(){
    if(report_data == null || report_data == []){
      return [];
    }
    List<Widget> widgets = [];
    for(int i=0; i<report_data.length; i++){
      var item = report_data[i];
      var name = item["name"];
      var imageUrl = item["imageUrl"];

      widgets.add(
          MaterialButton(
            onPressed: ()async{
              if(await canLaunch(url)){
                await launch(url);
              }
              else{
                throw 'Could not launch $url';
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
    return widgets;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: size,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Reports", style: GoogleFonts.koHo(fontSize:20, fontWeight: FontWeight.bold),),
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
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            width: size,
            child: Text(
              "Astrology report or what is commonly known as Horoscope report is basically an in depth look at your birth chart. Horoscope report will look at various planetery positions in your birth charts and also derive relationships and angle to understand your personality and trait.",
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