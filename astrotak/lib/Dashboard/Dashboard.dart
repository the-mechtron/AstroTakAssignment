import 'package:astrotak/Dashboard/Ask.dart';
import 'package:astrotak/Dashboard/Testimonials.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Astrologers.dart';
import 'BannerClass.dart';
import 'Horoscope.dart';
import 'Report.dart';

class Dashboard extends StatefulWidget{
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with
    AutomaticKeepAliveClientMixin<Dashboard>{
  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(3)),
              // 1. Daily Quotes
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 260,
                      child: Column(
                        children: [
                          RichText(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(text: "\"\"", style: GoogleFonts.koHo(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                TextSpan(text: 'There is no better boat than horoscope to help a man cross over the sea of life.', style: GoogleFonts.koHo(fontSize: 14, color: Colors.black)),
                                TextSpan(text: "\"\"", style: GoogleFonts.koHo(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                              ],
                            ),
                          ),
                        Text("\n- Prashant Kumar", textAlign: TextAlign.center, style: GoogleFonts.koHo(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey))
                        ],
                      ),
                    ),
                    // Padding(padding: EdgeInsets.only(left:20)),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 70,
                      child: Image.asset('assets/ganesh3.png'),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              // 2. Offer Banners
              Row(
                children: [
                  //Data
                  BannerClass()
                  //Photo
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              // 3. Daily Horoscope
              Container(
                width: size*0.9,
                child: Row(
                  children: [
                    //Data
                    Horoscope()
                    //Photo
                  ],
                ),
              ),
              // 4. Talk to an Astrologer
              Padding(padding: EdgeInsets.all(10)),
              Container(
                width: size*0.9,
                child: Row(
                  children: [
                    //Data
                    Astrologer()
                    //Photo
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              // Reports
              Container(
                width: size*0.9,
                child: Row(
                  children: [
                    //Data
                    ReportClass()
                    //Photo
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              // 5. Ask a Question
              Container(
                child: AskQuestions(),
              ),
              Padding(padding: EdgeInsets.all(10)),
              // 6. Hear from our Happy Customers
              Container(
                child: Testimonials(),
              ),
              Padding(padding: EdgeInsets.all(20)),
            ],
          ),
        ),
      ),
    );
  }
}