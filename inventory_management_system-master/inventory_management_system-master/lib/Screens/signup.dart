import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management_system/Screens/login.dart';
import 'package:inventory_management_system/widgets/titleText.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {
  final name =new TextEditingController();
  final email = new TextEditingController();
  final phone = new TextEditingController();
  final password= new TextEditingController();
  final confirmPassword = new TextEditingController();


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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/signup_icon.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width - 40,
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                 // icon: Icon(
                  //  Icons.account_circle_rounded,
                 // ),
                ),
              ),
            ),
            Container(
              width: size.width - 40,
              child: TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email-ID',
                  icon: Icon(
                    Icons.email,
                  ),
                ),
              ),
            ),
            Container(
              width: size.width - 40,
              child: TextFormField(
                controller: phone,
                decoration: InputDecoration(
                  labelText: 'Mobile-Number',
                  icon: Icon(
                    Icons.phone,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: size.width - 40,
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Set-Password',
                  icon: Icon(
                    Icons.lock,
                  ),
                ),
              ),
            ),
            Container(
              width: size.width - 40,
              child: TextFormField(
                controller: confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm-Password',
                  icon: Icon(
                    Icons.lock,
                  ),),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: size.width - 20,
              child: RaisedButton(
                shape: StadiumBorder(),
                color: Colors.blue,
                onPressed: () async {
                  bool result = await signUp([name.text,phone.text,email.text,password.text]);

                  if(result==true)
                    {
                      Fluttertoast.showToast(msg: 'Account Created Successfully');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );

                    }
                  else{
                    Fluttertoast.showToast(msg: 'Account Creation failed');
                  }



                },
                child: Text(
                  'REGISTER',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Future<bool> signUp(details) async{
  print(details);
  print('Running');
  var data=details;
  String body =json.encode(data);
  var url = 'https://demo121flutter.000webhostapp.com/signup.php';
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
      return true;
    }


  else
    print("ERROR");



}