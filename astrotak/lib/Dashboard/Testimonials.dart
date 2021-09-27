import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Testimonials extends StatefulWidget{
  _Testimonials createState() => _Testimonials();
}

class _Testimonials extends State<Testimonials>{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;
    String _chosenValue;
    return Container(
      width: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: size,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Hear from our Customers", style: GoogleFonts.koHo(fontSize:20, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Container(
            width: size*0.55,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey[200])
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text("\"\"", style: GoogleFonts.koHo(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                      Text('There is no better boat than horoscope to help a man cross over the sea of life.', style: GoogleFonts.koHo(fontSize: 11, color: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(color:Colors.white,child: Image(image: AssetImage('assets/profile.png'))),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                        Column(
                          children:[
                            Text("Rishi Goley", style: GoogleFonts.koHo(color: Colors.white, fontWeight: FontWeight.bold),)
                          ] 
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}