// import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:task_manager/widgets/DynamicThemeChanger.dart';

import 'Services.dart';
import 'package:flutter/material.dart';
import '../helpers/shared_preferences_helper.dart';
import 'package:task_manager/locator.dart';
import '../enums/UserType.dart';
import '../models/User.dart';
import 'Services.dart';


class ProfileServices extends Services {
//  StorageServices storageServices = locator<StorageServices>();
  StreamController<AppUser> loggedInUserStream =
      StreamController.broadcast(sync: true);
  AppUser user;

  List<AppUser> child = List.empty(growable: true);
  
  
  //[AppUser(id:'543',displayName:"HellBoy"),AppUser(id:'5327',displayName:"Thor")];//[] was in the beggining


  ProfileServices() {
    initialiseUser();
  }

  initialiseUser() async {

    // List<String,dynamic> dataModel = new List

    // List<dynamic> dataModel =  json.decode(await sharedPreferencesHelper.getUserDataModel())[0];

    // if(dataModel!="N.A"){
    //   log(dataModel.toString());
    //   user= new AppUser(email:dataModel[0].toString() ,  sex:dataModel[4].toString() ,displayName:dataModel[2].toString()+dataModel[3].toString() ,unite:dataModel[1].toString() ,birthDate: dataModel[5].toString());
    //   loggedInUserStream.add(AppUser(displayName: user.DisplayName,email: user.email, unite : user.unite, birthDate: user.birthDate, sex: user.sex ));
    // }
    

  }


  setProfileData({
    AppUser user,
    UserType userType,
  }) async {
    UserType userType = await sharedPreferencesHelper.getUserType();
    // String photoUrl = '';
    // String url = await sharedPreferencesHelper.getLoggedInUserPhotoUrl();

    // if (user.photoUrl.contains('https')) {
    //   // photoUrl = url;
    // } else if (user.photoUrl == 'default') {
    //   // user.photoUrl = user.photoUrl;
    // } else {
    //   //user.photoUrl = await storageServices.setProfilePhoto(user.photoUrl);
    // }

    // user.photoUrl = photoUrl;

    Map profileDataHashMap = user.toJson();

    var body = json.encode({
      "schoolCode": schoolCode.trim().toUpperCase(),
      "profileData": profileDataHashMap,
      "userType": UserTypeHelper.getValue(userType),
      // "country": country
    });

    //Dio dio = Dio();
    //Options options = Options(
    //  contentType: 'multipart/form-data',
    //  headers: headers,
    //);

    //final response = await dio.post(
    //  profileUpdateUrl,
    //  options: options,
    //  data: body,
      // body: body,
      // headers: headers,
    //);

    // if (response.statusCode == 200) {
    //   getProfileData(user.id, userType);
    //  print("Data Uploaded Succesfully");
    //  final jsonData = await json.decode(response.data.toString());

    //  AppUser user = AppUser.fromJson(jsonData);
    //  sharedPreferencesHelper.setUserDataModel(response.data.toString());
    //  loggedInUserStream.add(user);
    // } else {
    //  print("Data Upload error");
    // }
  }

  Future<AppUser> getLoggedInUserProfileData() async {
    // if (schoolCode == null)
    //await getSchoolCode();
    String id = await sharedPreferencesHelper.getLoggedInUserId();//email in our case
    UserType userType = await sharedPreferencesHelper.getUserType();

    // String userDataModel = await sharedPreferencesHelper.getUserDataModel();

    // if (userDataModel != 'N.A') {
    //   log("Data Retrieved Succesfully (Local)");
    //   final jsonData = await json.decode(userDataModel);

    //   log(jsonData.toString());
    //   user = AppUser.fromJson(jsonData);
    //   loggedInUserStream.add(user);
    //   log("Profile Service, User : "+user.toString());
    //   // user.toString();
    //   return user;
    // }

    var body = json.encode({
      // "schoolCode": schoolCode.trim().toUpperCase(),
      "email": id,
      // "userType": UserTypeHelper.getValue(userType),
      // "country": country
    });

    // print(body);

    Dio dio = Dio();
    Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );

    final response = await dio.post(
      getProfileDataUrl,
      options: options,
      data: body,
      // body: body,
      // headers: headers,
    );
    if (response.statusCode == 200) {
      log("Data Retrieved from server Succesfully..");
      final jsonData = json.decode(response.data.toString());
      
      // log(response.data.toString()); 
      
      user = AppUser.fromJson(jsonData[0]);
      sharedPreferencesHelper.setUserDataModel(response.data.toString());
      loggedInUserStream.add(user);
      // loggedInUser=user;
      //user.toString();
      return user;
    } else {
      print("Data Retrieval failed");
      return AppUser(email: id);
    }
  }
  //Fetch Profile Data Using Firestore SDK
  //Future<AppUser> getProfileDataById(String uid, UserType userType) async {
    //DocumentReference profielRef = await _getProfileRef(uid, userType);

/*
    try {
      user = AppUser.fromSnapshot(
          await profielRef.get(GetOptions(source: Source.serverAndCache)));
      return user;
    } catch (e) {
      print(e);
      return AppUser(id: uid);
    }
  }
*/

  /*
  Future<AppUser> getUserDataFromReference(DocumentReference reference) async {
    AppUser user = AppUser.fromSnapshot(await reference.get());
    return user;
  }
*/

  getChildrens() async {



    var body = json.encode({
      "email": user.email,
      });

      Dio dio = Dio();
      Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );
  final response = await dio.post(
        getChildrenIDsURL,
        options: options,
        data: body,
      );
    var childs;
  if (response.statusCode == 200) {
     childs = await json.decode(response.data);
    List<String> a = List.empty(growable:true);
    for(int i=0;i<childs.length;i++){
      a.add(childs[i]["email"]);
      log(childs[i]["email"].toString());
    }
    await _getData(a);

    // await _getData(childIds);
    // var childIds = Map.from(
    //   jsonDecode(response.data).map(
    //     (key, values) {
    //       String value = values.toString();
    //       log(value);
    //       return MapEntry(key, value);
    //     },
    //   ),
    // );
    //  await _getData(childIds);
  }

  


  // log(childs.toString());

}


  _getData(List< String> childIds) async {
    List<AppUser> childData = List.empty(growable: true);
    for (String id in childIds) {
      log("id");
      AppUser data = await getProfileDataByIdd(id, UserType.STUDENT);
      if(data!=null)
        childData.add(data);
    }
    child=List.empty(growable:true);
    child.addAll(childData);
  }

  /*
  Future<DocumentReference> _getProfileRef(
      String uid, UserType userType) async {
    await getSchoolCode();
    DocumentReference ref = (await schoolRefwithCode()).doc('Profile');
    switch (userType) {
      case UserType.STUDENT:
        return ref.collection('Student').doc(uid);
        break;
      case UserType.TEACHER:
      case UserType.PARENT:
        return ref.collection('Parent-Teacher').doc(uid);
        break;
      case UserType.UNKNOWN:
        return null;
        break;
      default:
        return null;
    }
  }
*/
  //Fetch Profile Data Using HTTP Request
  Future<AppUser> getProfileDataByIdd(String uid, UserType userType) async {

    var body = json.encode({
      // "schoolCode": schoolCode.trim().toUpperCase(),
      "email": uid,
      // "userType": UserTypeHelper.getValue(userType),
      // "country": country
    });

    log(body);

    Dio dio = Dio();
    Options options = Options(
      contentType: 'multipart/form-data',
      headers: headers,
    );

    final response = await dio.post(
      
      getProfileDataUrl,
      options: options,
      data: body,
      // body: body,
      // headers: headers,
    );

    if (response.statusCode == 200) {
      
      print("Profile Service, Data Retrieved Succesfully");
      if(response.data.toString().length==0)
        return null;
      final jsonData = await json.decode(response.data);
      log(jsonData[0].toString());
      log("at least there's data");
      AppUser user = AppUser.fromJson(jsonData[0]);
      log(user.toString());
      if(user==null){
        sharedPreferencesHelper.setUserDataModel(response.data.toString());
        loggedInUserStream.add(user);
      }

      return user;
    } else {
      print("Data Retrieval failed");
      return AppUser(email: uid);
    }
  }
}


