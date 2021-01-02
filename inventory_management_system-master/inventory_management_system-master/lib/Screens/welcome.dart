import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/login.dart';
import 'package:inventory_management_system/Screens/signup.dart';
import 'package:inventory_management_system/widgets/titleText.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/welcome_icon.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            SizedBox(height: size.height*0.3  ,),
            ButtonTheme(
              minWidth: size.width-20,
              child: RaisedButton(

                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );

                },
                child: Text('LOGIN',style: TextStyle(color: Colors.white),),
              ),
            ),
            ButtonTheme(
              minWidth: size.width-20,
              child: RaisedButton(
                shape: StadiumBorder(),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text('SIGN UP',style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
