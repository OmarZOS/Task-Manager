//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/models/UserDataLogin.dart';
import 'package:http/http.dart';
import 'package:async/async.dart';
import '../Server.dart';
import '../helpers/shared_preferences_helper.dart';


//import 'package:intl/date_symbol_data_http_request.dart';
//import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import '../../locator.dart';

//import 'package:firebase_storage/firebase_storage.dart';

abstract class Services {
  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();
  // static String country =
  //     "India"; //Get this from firstScreen(UI Not developed yet)
      
  //static FirebaseAuth _auth = FirebaseAuth.instance;

  //static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //User firebaseUser;

  AppUser _user;

  UserDataLogin userDataLogin;

  String schoolCode ;

  //final Reference _storageReference =
  //    FirebaseStorage.instance.ref().child(country);

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    // 'Access-Control-Allow-Origin' : 'http://192.168.43.172:40313/task_manager/php/Authentification.php',
  };

  String baseUrl = Server.baseUrl;

  String webApiUrl = Server.baseUrl + Server.webApi;

  String profileUpdateUrl =
      Server.baseUrl + Server.webApi + Server.profileUpdate;

  String getProfileDataUrl =
      Server.baseUrl + Server.webApi + Server.getProfileData;

  String postTaskUrl =
      Server.baseUrl + Server.webApi + Server.postTask;

  String addAssignmentUrl =
      Server.baseUrl + Server.webApi + Server.addAssignment;

  String getNotificationURL =
      Server.baseUrl + Server.webApi + Server.getnotifURL;


String authentifyUrl =
      Server.baseUrl + Server.webApi + Server.authentify;

String getTaskURL =
      Server.baseUrl + Server.webApi + Server.getTasksURL;
      
String getChildrenIDsURL =
      Server.baseUrl + Server.webApi + Server.getChildids;

String getToolsURL =
      Server.baseUrl + Server.webApi + Server.getTools;
      

String pauseTaskURL =
      Server.baseUrl + Server.webApi + Server.pauseTask;


String endTaskURL =
      Server.baseUrl + Server.webApi + Server.endTask;
      
String playTaskURL =
      Server.baseUrl + Server.webApi + Server.playTask;

  // String getVehicleURL = 
  // Server.baseUrl + Server.webApi + Server.getVehicleURL;

  //DocumentReference _schoolRef = _firestore.collection('Schools').doc(country);

  //FirebaseFirestore get firestore => _firestore;
  //FirebaseAuth get auth => _auth;
  AppUser get loggedInUser => _user;

  //DocumentReference get schoolRef => _schoolRef;

  //Future<CollectionReference> schoolRefwithCode() async =>
  //    _schoolRef.collection((await getSchoolCode()).toUpperCase().trim());

  //Reference get storageReference => _storageReference;

  SharedPreferencesHelper get sharedPreferencesHelper =>
          _sharedPreferencesHelper;

  //getFirebaseUser() async {
  //  firebaseUser = _auth.currentUser;

  //}
  //Future<String> getSchoolCode() async {
  //  schoolCode = await _sharedPreferencesHelper.getSchoolCode();
//  return schoolCode;
//  }
}
