import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:inventory_management_system/Screens/welcome.dart';
import 'package:inventory_management_system/widgets/titleText.dart';
import 'details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class QRScanner extends StatefulWidget {
  @override
  _QRScanner createState() => _QRScanner();
}

class _QRScanner extends State<QRScanner> {

  @override
  void initState() {
    // TODO: implement initState
    getUsername();
    super.initState();
  }
  var result = "",usrname='';

  Future getUsername() async{
    usrname= await getStringValuesSF();
    usrname =usrname.substring(11,usrname.length - 1);
  }

  Future addUserlog(qrRes) async{
    result = qrRes.toString();
    currentPhoneDate = DateTime.now().toString();
    currentPhoneDate = currentPhoneDate.substring(0,19);
    getData([usrname, currentPhoneDate, result]);
  }

  String currentPhoneDate;
  String Formatted;
  Future _scan() async {
    try {
      ScanResult qrRes = await BarcodeScanner.scan();
      var qrResult=qrRes.rawContent;
      print('QR'+qrResult);
      setState(()  {
        addUserlog(qrResult);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DetailsScreen()),
      );
      addStringToSF('product_id',result);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera Permission necessary";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "Scan Incomplete";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }



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
        width: double.infinity,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            children: [
              Text(
                'Welcome '+ usrname,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              ButtonTheme(
                minWidth: size.width-20,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.blue,
                  onPressed: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));

                  },
                  child: Text('LOG OUT',style: TextStyle(color: Colors.white),),
                ),),
            ],
          ),
        ),

      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: _scan,
          label: Text(
            "Scan QR",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          icon: Icon(Icons.camera_alt),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<String> getData(details) async {
  //print('Details'+details);
  var data = details;
 // print('Running'+data);
  String body = json.encode(data);
  var url = 'https://demo121flutter.000webhostapp.com/addUserLog.php';
  http.Response response = await http.post(url, body: body);
  var result = jsonDecode(response.body);
  print("\n\n\n" + result);
  if (result.toString() == 'False') //incorrect username or password
    print("Failed to fetch");
  else if (result.toString() == 'True')
    print("Data fetched"); //goes to next page
  else
    print("ERROR");
  return result;}

 getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = await prefs.getString('username') ?? 'blank value';
  return stringValue;
}
addStringToSF(key,value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key.toString(), value.toString());
}