import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRecordScreen extends StatefulWidget {
  @override
  _ServiceRecordScreenState createState() => _ServiceRecordScreenState();
}

class _ServiceRecordScreenState extends State<ServiceRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future getData() async{
  var id = await getStringValuesSF('product_id');
  String body =json.encode(id);
  var url = 'https://demo121flutter.000webhostapp.com/service_log.php';
  http.Response response = await http.post(url, body:body);
  var data = jsonDecode(response.body);
  //TODO display fetched data
}
getStringValuesSF(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = await prefs.getString(data.toString()) ?? 'blank value';
  return stringValue;
}
addStringToSF(key,value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key.toString(), value.toString());
}