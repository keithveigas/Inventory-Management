import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management_system/widgets/titleText.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class QRScanLogsScreen extends StatefulWidget {
  @override
  _QRScanLogsScreenState createState() => _QRScanLogsScreenState();
}




class _QRScanLogsScreenState extends State<QRScanLogsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: appBar(context),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null)
              {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              }else {
              return
                ListView.builder(itemCount: snapshot.data.length
                    , itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data[index].username),
                      subtitle: Text(snapshot.data[index].date),);
                    });



            }


          },
        ),
      ),

    );
  }
}
Future<List<LogDetails>> getData() async{
  var id = '1';
  //var id = await getStringValuesSF('product_id');
  String body =json.encode(id);
  var url = 'https://demo121flutter.000webhostapp.com/user_log.php';
  http.Response response = await http.post(url, body:body);
  var data = jsonDecode(response.body);
  //TODO display fetched data
  List<LogDetails> logs=[];

  for(var u in data){
    LogDetails log = LogDetails(u['username'], u['date']);
    logs.add(log);

  }
  print(logs.length);
  return logs;

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


class LogDetails{
  final String username;
  final String date;

  LogDetails(this.username,this.date);
}
