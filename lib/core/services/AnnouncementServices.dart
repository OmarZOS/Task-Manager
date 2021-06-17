import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/core/services/ProfileServices.dart';
import 'dart:convert';
import '../models/Announcement.dart';
import '../../locator.dart';
import 'Services.dart';

class AnnouncementServices extends Services {
  // StorageServices _storageServices = locator<StorageServices>();
  // ProfileServices profileServices = locator<ProfileServices>();
  //DocumentSnapshot lastPostSnapshot = null;
  List<dynamic> myTasks = List.empty(growable: true);



  AnnouncementServices() {
    // getFirebaseUser();
    // getSchoolCode();
  }

  init() async {
  }

  Future<bool> endTask(String id)async{
      var body = json.encode({
        "ID_TACHE": id,
      });

      Dio dio = Dio();
      Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );
    //  authentifyUrl =
    //   Server.baseUrl + Server.webApi + Server.authentify;
// log(authentifyUrl);
      final response = await dio.post(
        endTaskURL,
        options: options,
        data: body,
        // body: body,
        // headers: headers,
      );

      log(response.data.toString());
      if (response.statusCode == 200) {
        
        
        return true;
          
        

      } else {
      log("Task ending request failed");
      return false;
    }

  }


  getAnnouncements(
    String stdDiv_Global,
  ) async {

var body = json.encode({
        "email": stdDiv_Global,
      });

      Dio dio = Dio();
      Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );
    //  authentifyUrl =
    //   Server.baseUrl + Server.webApi + Server.authentify;
// log(authentifyUrl);
final response = await dio.post(
  getTaskURL,
  options: options,
  data: body,
  // body: body,
  // headers: headers,
);

if (response.statusCode == 200) {
  log(response.data.toString());
  final jsonData = json.decode(response.data.toString());
  log(stdDiv_Global);
  log("announcement services json : "+jsonData.toString());
  myTasks=new List.empty(growable: true);
  myTasks.addAll(jsonData);


} else {
      print("Task loading failed");
    }

    // List<DocumentSnapshot> _data = new List<DocumentSnapshot>();

    // if (schoolCode == null) await getSchoolCode();

    // var _postRef =
    //     (await schoolRefwithCode()).doc('Posts').collection(stdDiv_Global);
    // QuerySnapshot data;
    // //  = await _schoolRef.getDocuments();
    // if (lastPostSnapshot == null)
    //   data =
    //       await _postRef.orderBy('timeStamp', descending: true).limit(10).get();
    // else
    //   data = await _postRef
    //       .orderBy('timeStamp', descending: true)
    //       .startAfter([lastPostSnapshot['timeStamp']])
    //       .limit(5)
    //       .get();

    // if (data != null && data.docs.length > 0) {
    //   lastPostSnapshot = data.docs[data.docs.length - 1];
    //   postDocumentSnapshots.addAll(data.docs);
    // } else {
    //   //No More post Available
    // }
  }

  modifierStatusDeTache(String ID,String Setting)async{

    var body = json.encode({
      "ID": ID,
    });
    

    log(body.toString());

    final response =
        await http.post((Setting=="pause")?pauseTaskURL:playTaskURL
        , body: body, headers: headers);

    if (response.statusCode == 200) {
      log(response.body.toString());
      for (var item in myTasks) {
        if(item["ID_TACHE"]==ID){
          myTasks[myTasks.indexOf(item)]["Etat"]=(Setting=="pause")?"en_pause":"encours";
        }
      }

    } else {
      print("Post posting failed");
    }
  

  }



  postAnnouncement(Announcement announcement) async {

    Map announcementMap = announcement.toJson();

    var body = json.encode({
      "announcement": announcementMap
    });

    print(body.toString());

    final response =
         await http.post(postTaskUrl, body: body, headers: headers);

    if (response.statusCode == 200) {
      print("Post posted Succesfully");
      print(json.decode(response.body).toString());
    } else {
      print("Post posting failed");
    }
  }
}