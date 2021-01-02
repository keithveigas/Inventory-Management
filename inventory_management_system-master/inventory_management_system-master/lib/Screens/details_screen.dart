import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management_system/Screens/qr_scan_logs.dart';
import 'package:inventory_management_system/Screens/welcome.dart';
import 'package:inventory_management_system/widgets/titleText.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  //final String productId, msg;
  //DetailsScreen();
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var product_name;
  var product_id;
  var product_brand;
  var product_cat;
  var product_desc;
  var product_image;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected:handleClick,

            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),

        ],
        title: appBar(context),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            CircleAvatar(
            radius: 100.0,
            backgroundImage: NetworkImage('https://images-na.ssl-images-amazon.com/images/I/61FioHkKfxL._SL1000_.jpg'),
          ),
          Text("Name $product_name"),
          Text('Brand $product_brand'),
          Text('Category $product_cat'),
          Text('Product Desc $product_desc'),
          RaisedButton(child: Text('PREVIOUS SCAN LOGS'), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanLogsScreen()));
          }),
          RaisedButton(
              child: Text('PREVIOUS SERVICE RECORDS'), onPressed: () {}),
        Container(
          margin: EdgeInsets.all(20),
          child: new TextFormField(
            decoration: new InputDecoration(
              labelText: "Enter Service Details",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              if(val.length==0) {
                return "Service Details cannot be empty";
              }else{
                return null;
              }
            },
            //keyboardType: TextInputType,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),),
        ),
              RaisedButton(child: Text('SUBMIT'),
              onPressed: (){})
      ],
    ),),
    );
  }

  Future getData() async {
    var id = '1';
    // var id = await getStringValuesSF('product_id');
    String body = json.encode(id);
    var url = 'https://demo121flutter.000webhostapp.com/product_details.php'; //
    http.Response response = await http.post(url, body: body);
    Map data = jsonDecode(response.body);
    setState(() {
      product_name = data["product_title"];
      product_id = data["product_id"];
      product_brand = data["product_brand"];
      product_cat = data["product_cat"];
      product_desc = data["product_desc"];
      product_image = data["product_image"];
    });

    print(product_name);
  }
}

getStringValuesSF(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = await prefs.getString(data.toString()) ?? 'blank value';
  return stringValue;
}

addStringToSF(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key.toString(), value.toString());
}

Future<void> handleClick(String value) async {
  switch (value) {
    case 'Logout':
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      
      break;

  }
}
