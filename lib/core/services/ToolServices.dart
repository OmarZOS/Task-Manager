// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ourESchool/UI/Utility/constants.dart';
// import 'package:ourESchool/core/Models/Tool.dart';
// import 'package:ourESchool/core/services/Services.dart';
// import 'package:ourESchool/core/services/StorageServices.dart';
// import 'package:ourESchool/locator.dart';
// import 'package:path/path.dart' as p;
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/core/services/ProfileServices.dart';
import 'dart:convert';

// import '../models/Tool.dart';
import '../../locator.dart';
import 'Services.dart';

class ToolServices extends Services {
  ProfileServices profileServices = locator<ProfileServices>();
  List<dynamic> myTools = List.empty(growable: true);



  ToolServices() {
  }

  init() async {
  }

  getTools(
    String stdDiv_Global,
  ) async {

var body = json.encode({
      "email": profileServices.user.email,
      });

      Dio dio = Dio();
      Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );
final response = await dio.post(
      getToolsURL,
      options: options,
      data: body,
    );

if (response.statusCode == 200) {
  log(response.data.toString());
  if(response.data.toString()==0)
    return;
  final jsonData = json.decode(response.data.toString());
  log("Tool services json : "+jsonData.toString());
  myTools=new List.empty(growable: true);
  myTools.addAll(jsonData);

} else {
      print("Tool loading failed");
    }

  }

}
