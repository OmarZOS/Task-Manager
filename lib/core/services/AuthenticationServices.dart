//import 'dart:html';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/core/enums/AuthErrors.dart';
import 'package:task_manager/core/helpers/shared_preferences_helper.dart';
import 'package:task_manager/core/services/StorageService.dart';
//import 'package:ourESchool/imports.dart';
import '../../locator.dart';
import '../Server.dart';
import 'ProfileServices.dart';
import 'Services.dart';
import 'package:flutter/material.dart';
import '../enums/UserType.dart';
import '../models/User.dart';
import 'dart:async';







class AuthenticationServices extends Services {
  // Future handleGoogleSignIn() async {
  //   try {
  //     AuthCredential credential;
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn().catchError((e) {
  //       throw e;
  //     });
  //     await googleUser.authentication.then((onValue) async {
  //       credential = GoogleAuthProvider.getCredential(
  //         accessToken: onValue.accessToken,
  //         idToken: onValue.idToken,
  //       );
  //       _firebaseUser = await _auth.signInWithCredential(credential);
  //     });
  //     print("signed in " + _firebaseUser.displayName);
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  // }

  bool isUserLoggedIn = false;
  UserType userType = UserType.STUDENT;

  //StreamController<User> fireBaseUserStream = StreamController<User>();
  StreamController<bool> isUserLoggedInStream = StreamController<bool>();
  StreamController<UserType> userTypeStream = StreamController<UserType>();

  ProfileServices _profileServices = locator<ProfileServices>();

  AuthenticationServices() : super() {
    // if (kIsWeb) firestore.enablePersistence();
    //if (!kIsWeb) firestore.settings = Settings(persistenceEnabled: true);
    // firestore.settings(
    //   persistenceEnabled: false,
    // );
    // isLoggedIn().then((onValue) => isUserLoggedIn = onValue);
    _userType().then((onValue) => userType = onValue);
  }
  Future<bool> isLoggedIn() async {
    //await getFirebaseUser();
    //fireBaseUserStream.add(firebaseUser);
    //String name = firebaseUser != null ? firebaseUser.email.toString() : 'Null';
    // print('User Email :' + name);
    // if (firebaseUser == null) {
    //   await logoutMethod();
    // }
    // isUserLoggedIn = firebaseUser == null ? false : true;
    UserType type = sharedPreferencesHelper.getUserType() as UserType;
    userTypeStream.add(type);
    if (isUserLoggedIn) _profileServices.getLoggedInUserProfileData();
      log("auth, is user :"+isUserLoggedIn.toString() + 'here');
    return isUserLoggedIn;
  }
/*
*/
  Future<UserType> _userType() async {
    userType = await sharedPreferencesHelper.getUserType();
    isUserLoggedIn = (userType != null);
    log("returned type : " + userType.toString());
    isUserLoggedInStream.add(userType!=null&&userType!=UserType.UNKNOWN);
    userTypeStream.add(userType);
    return userType;
  }
/*
  Future checkDetails({
    required String schoolCode,
    required String email,
    required String password,
    required UserType userType,
  }) async {
    await sharedPreferencesHelper.clearAllData();
    //Check if the School code is present and return "School not Present" if not
    //Then check if the user credentials are in the database or not
    //if not then return "Student Not Found" else return "Logging in"

    //Api Call to check details
    bool isSchoolPresent = false;
    bool isUserAvailable = false;
    String loginType = userType == UserType.STUDENT
        ? "Student"
        : userType == UserType.TEACHER
            ? "Parent-Teacher"
            : "Parent-Teacher";

    //DocumentReference _schoolLoginRef =
      //  schoolRef.collection(schoolCode.toUpperCase().trim()).doc('Login');
/*
    await _schoolLoginRef.get().then((onValue) {
      isSchoolPresent = onValue.exists;
      print("Inside Then :" + onValue.data.toString());
    });
*/
    if (!isSchoolPresent) {
      print('School Not Found');
      return ReturnType.SCHOOLCODEERROR;
    } else {
      print('School Found');
    }

    CollectionReference _userRef = _schoolLoginRef.collection(loginType);

    await _userRef
        .where("email", isEqualTo: email)
        .snapshots()
        .first
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        isUserAvailable = documentSnapshot.exists;
        print("User Data : " + documentSnapshot.data.toString());
        if (userType == UserType.STUDENT) {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            parentIds:
                documentSnapshot['parentId'] as Map<dynamic, dynamic> ?? null,
          );
          // DocumentReference ref = documentSnapshot["ref"] as DocumentReference;
          // print('Insude Document Reference');
          // ref.get().then(
          //       (onValue) => print(
          //         'Dataaa : ' + onValue.data.toString(),
          //       ),
          //     );
        } else {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            isATeacher: documentSnapshot["isATeacher"] as bool,
            childIds:
                documentSnapshot["childId"] as Map<dynamic, dynamic> ?? null,
          );
        }
      });
    });

    if (!isUserAvailable) {
      print('User Not Found');
      return ReturnType.EMAILERROR;
    } else {
      print('User Found');
      userDataLogin.setData();
    }

    sharedPreferencesHelper.setLoggedInUserId(userDataLogin.id);

    if (userType == UserType.STUDENT) {
      this.userType = userType;
      userTypeStream.add(userType);
      sharedPreferencesHelper.setUserType(UserType.STUDENT);
    } else {
      if (userDataLogin.isATeacher) {
        this.userType = UserType.TEACHER;
        userTypeStream.add(this.userType);
        sharedPreferencesHelper.setUserType(this.userType);
      } else {
        this.userType = UserType.PARENT;
        userTypeStream.add(this.userType);
        sharedPreferencesHelper.setUserType(this.userType);
      }
    }

    print("Childs :" + userDataLogin.childIds.toString());
    print("Email :" + userDataLogin.email);
    print("Id :" + userDataLogin.id);
    print("isATeacher :" + userDataLogin.isATeacher.toString());

    return ReturnType.SUCCESS;
  }
*/
  Future emailPasswordRegister(String email, String password, UserType userType,
      ) async {//String schoolCode
    // await sharedPreferencesHelper.clearAllData();
    //try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      //UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        //  email: email, password: password);
      //firebaseUser = userCredential.user;
      authErrors = AuthErrors.SUCCESS;
      //sharedPreferencesHelper.setSchoolCode(schoolCode);
      print("User Regestered using Email and Password");
      // sharedPreferencesHelper.setUserType(userType);
      isUserLoggedIn = true;
      isUserLoggedInStream.add(isUserLoggedIn);
      //fireBaseUserStream.add(firebaseUser);
      return authErrors;
    //} catch (e) {
     // return catchException(e);
    //}
  }

  Future<AuthErrors> emailPasswordSignIn(String email, String password,
      UserType userType) async {//, String schoolCode
    //await sharedPreferencesHelper.clearAllData();
    try {
      

      
      AuthErrors authErrors = AuthErrors.UNKNOWN;


      // UserCredential userCredential = await auth.signInWithEmailAndPassword(
      //    email: email, password: password);
      // firebaseUser = userCredential.user;
      // sharedPreferencesHelper.setSchoolCode(schoolCode);

      //locator<StorageServices>().getProfileDataUrl
      

      var body = json.encode({
      // "schoolCode": schoolCode.trim().toUpperCase(),
      "email": email,
      "password": password
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
      authentifyUrl,
      options: options,
      data: body,
      // body: body,
      // headers: headers,
    );

if (response.statusCode == 200) {
      if(response.data.toString()=="true"){print("login boolean Retrieved Succesfully");
      //final jsonData = await json.decode(response.data.toString());

      locator<SharedPreferencesHelper>().setLoggedInUserId(email);
      locator<ProfileServices>().getLoggedInUserProfileData();//the magic is here

      authErrors = AuthErrors.SUCCESS;
      print("User Loggedin using Email and Password");

      sharedPreferencesHelper.setUserType(userType);
      isUserLoggedIn = true;
      isUserLoggedInStream.add(isUserLoggedIn);
      userTypeStream.add(UserType.TEACHER);
}
      

     
    } else {
      print("Login failed");
      return AuthErrors.UserNotFound;
    }



      //fireBaseUserStream.sink.add(firebaseUser);
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  // Future<User> fetchUserData() async {
  //   FirebaseUser user = await auth.currentUser();
  //   if (user == null) {
  //     print("No User LogedIn");
  //     return null;
  //   }
  //   User userr = User(
  //     displayName: user.displayName,
  //     mobileNo: user.phoneNumber,
  //     email: user.email,
  //     firebaseUuid: user.uid,
  //     isVerified: user.isEmailVerified,
  //     photoUrl: user.photoUrl,
  //   );
  //   print(userr.toString());
  //   return userr;
  // }

  logoutMethod() async {
    //await auth.signOut();
    isUserLoggedIn = false;
    isUserLoggedInStream.add(false);
    //fireBaseUserStream.add(null);
    userTypeStream.add(UserType.UNKNOWN);
    await sharedPreferencesHelper.clearAllData();
    print("User Loged out");
  }

  Future<AuthErrors> passwordReset(String email) async {
    //try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      //await auth.sendPasswordResetEmail(email: email);
      authErrors = AuthErrors.SUCCESS;
      print("Password Reset Link Send");
      return authErrors;
    //} on PlatformException catch (e) {
    //  return catchException(e);
    //}
  }

  AuthErrors catchException(Exception e) {
    AuthErrors errorType = AuthErrors.UNKNOWN;
    if (e is PlatformException) {
      if (Platform.isIOS) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = AuthErrors.NetworkError;
            break;
          case 'Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later':
            errorType = AuthErrors.TOOMANYATTEMPTS;
            break;
          // ...
          default:
            print('Case iOS ${e.message} is not yet implemented');
        }
      } else if (Platform.isAndroid) {
        switch (e.code) {
          case 'Error 17011':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'Error 17009':
          case 'ERROR_WRONG_PASSWORD':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case Android ${e.message} ${e.code} is not yet implemented');
        }
      }
    }

    print('The error is $errorType');
    return errorType;
  }
}
