import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/Scanner.dart';
import 'package:inventory_management_system/widgets/titleText.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = new TextEditingController();
  final password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
        title: appBar(context),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Image.asset(
            'assets/images/login_icon.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
            SizedBox(height: 20,),
            Container(
              width: size.width-40,
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    labelText: 'Email ID'
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),

              Container(
                width: size.width-40,
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password'
                  ),
                ),
              ),
          SizedBox(height: 20,),
          ButtonTheme(
              minWidth: size.width-20,
              child: RaisedButton(
                shape: StadiumBorder(),
                color: Colors.blue,
                onPressed: () async {
                  bool result = await signIn([email.text,password.text]);

                  if(result==true)
                  {
                    Fluttertoast.showToast(msg: 'Login Successful ');
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QRScanner()));

                  }
                  else{
                    Fluttertoast.showToast(msg: 'Login Failed');
                  }



                },
                child: Text('LOG IN',style: TextStyle(color: Colors.white),),
              ),),


            ]
          ),
        ),
      ),
    );
  }
}

Future<bool> signIn(details) async{
  print(details);
  print('Running');
  var data=details;
  String body =json.encode(data);
  var url = 'https://demo121flutter.000webhostapp.com/login.php';
  http.Response response = await http.post(url, body:body);
  var result = jsonDecode(response.body);
  if(result.toString()=='False')
  {
    //incorrect username or password
    print("Access denied");
    return false;
  }

  else if(result.toString()=='True')
  {
    print("Access granted");//goes to next page
    addStringToSF('email',details[0].toString());
    addStringToSF('password',details[1].toString());
    var data=details[0];
    String body =json.encode(data);
    var url = 'https://demo121flutter.000webhostapp.com/getUsername.php';
    http.Response response = await http.post(url, body:body);
    var usrname = jsonDecode(response.body);
    addStringToSF('username',usrname.toString());
    var name = await getStringValuesSF();
    //print(name.substring(11,name.length - 1));
    return true;
  }


  else
    print("ERROR");



}

addStringToSF(key,value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setString(key.toString(), value.toString());
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('username');
  return stringValue;
}

