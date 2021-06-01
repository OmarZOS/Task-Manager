// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ourESchool/UI/Utility/constants.dart';
// import 'package:ourESchool/core/Models/Announcement.dart';
// import 'package:ourESchool/core/services/Services.dart';
// import 'package:ourESchool/core/services/StorageServices.dart';
// import 'package:ourESchool/locator.dart';
// import 'package:path/path.dart' as p;
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/core/services/ProfileServices.dart';
import 'dart:convert';

import '../models/Announcement.dart';
import '../../locator.dart';
import 'Services.dart';
import 'StorageService.dart';

class AnnouncementServices extends Services {
  // StorageServices _storageServices = locator<StorageServices>();
  ProfileServices profileServices = locator<ProfileServices>();
  //DocumentSnapshot lastPostSnapshot = null;
  List<dynamic> myTasks = List.empty(growable: true);



  AnnouncementServices() {
    // getFirebaseUser();
    // getSchoolCode();
  }

  init() async {
    // if (firebaseUser == null) await getFirebaseUser();
    //if (schoolCode == null) await getSchoolCode();
  }

  getAnnouncements(
    String stdDiv_Global,
  ) async {

var body = json.encode({
      // "schoolCode": schoolCode.trim().toUpperCase(),
      "email": profileServices.user.email,
      // "password": password
      // "userType": UserTypeHelper.getValue(userType),
      // "country": country
      });

      // log(body);


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
  final jsonData = json.decode(response.data.toString());
  log("announcement services json : "+jsonData.toString());
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

  postAnnouncement(Announcement announcement) async {
    // if (firebaseUser == null) await getFirebaseUser();
    // if (schoolCode == null) await getSchoolCode();

    //Timestmap will be directly set by Firebase Functions(througn REST Api)
    // announcement.timestamp = Timestamp.now();

    String fileName = "";
    String filePath = "";

    if (announcement.photoUrl != '') {
      // fileName = createCryptoRandomString(8) +
      //     createCryptoRandomString(8) +
      //     p.extension(announcement.photoUrl);

      // announcement.photoUrl = await _storageServices.uploadAnnouncemantPhoto(
      //     announcement.photoUrl, fileName);

      // filePath = '${Services.country}/$schoolCode/Posts/$fileName';
    }
    announcement.photoPath = filePath;
    Map announcementMap = announcement.toJson();

    var body = json.encode({
      "schoolCode": schoolCode.toUpperCase(),
      // "country": Services.country,
      "announcement": announcementMap
    });

    print(body.toString());

    final response =
        await http.post(postAnnouncemnetUrl, body: body, headers: headers);

    if (response.statusCode == 200) {
      print("Post posted Succesfully");
      print(json.decode(response.body).toString());
    } else {
      print("Post posting failed");
    }
  }
}