import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AskQuestions extends StatefulWidget{
  _AskQuestions createState() => _AskQuestions();
}

class _AskQuestions extends State<AskQuestions>{
  @override
    Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;
    String _chosenValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: size,
          child: Row(
            children: [
              Text("Ask a Question", style: GoogleFonts.koHo(fontSize:20, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          width: size,
          child: Text(
            "Seek accurate answers to your life problems and guide you towards the right path. Whether the problem is related to love, self, buisness, money, education or work, our astrologers will do an in depth study of your birth chart provide personalized reponses along with remedies.",
            style: GoogleFonts.koHo(fontSize: 13),
            maxLines: null,
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: size,
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose Category", style: GoogleFonts.koHo(color:Colors.black,fontSize:15, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: size,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  // decoration: BoxDecoration(
                  //   // border: Border.all(color: Colors.white),
                  //   borderRadius: BorderRadius.all(Radius.circular(10))
                  // ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Selct a Category: Love, Buisness, Life", style: GoogleFonts.koHo(),),
                    items: <String>['Love', 'Buisness', 'Life'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: GoogleFonts.koHo()),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Rs. 99 Rs.  ", style: GoogleFonts.koHo(color:Colors.black,fontSize:11, fontWeight: FontWeight.bold),),
                        Text("(Including GST)", style: GoogleFonts.koHo(color:Colors.black,fontSize:11),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ideas what to do   ", style: GoogleFonts.koHo(color:Colors.black,fontSize:11, fontWeight: FontWeight.bold),),
                        Container(
                          width: 100,
                          height: 25,
                          child: MaterialButton(
                            color: Colors.deepOrangeAccent,
                            onPressed: (){},
                            child: Text("Ask a Question", style: GoogleFonts.koHo(color: Colors.white,fontSize:10,),),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ]
          ),
        ),
      ],
    );
  }
}