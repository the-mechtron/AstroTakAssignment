import 'dart:convert';
import 'package:astrotak/Dashboard/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget{
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login>{
  String email = "";
  // ignore: non_constant_identifier_names
  final _email_controller = TextEditingController();
  String password = "";
  // ignore: non_constant_identifier_names
  final _password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Login Screen"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:20),
              child: Center(
                child: Container(
                  width: size*0.25,
                  height: size*0.25,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size*0.02),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                  hintText: 'abc@abc.com '
                ),
                controller: _email_controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size*0.02, right: size*0.02, top: size*0.03, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: '12345678'
                ),
                controller: _password_controller,
              ),
            ),
            FlatButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.deepOrangeAccent, fontSize: size*0.02),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                  final url = 'http://10.0.2.2:5000/login';
                  final response = await http.post(Uri.parse(url), body:json.encode({'email':_email_controller.text.toString(),'password':_password_controller.text.toString()}));
                  final decoded = json.decode(response.body) as Map<String, dynamic>;
                  if(decoded["response"] == "dashboard"){
                    final snackBar = SnackBar(content: Text("Succefully Logged In"), duration: Duration(seconds: 2),);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Dashboard()));
                  }
                  else{
                    final snackBar = SnackBar(content: Text(decoded["response"]), duration: Duration(seconds: 2),);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User? Create Account')
          ],
        ),
      ),
    );
  }  
}