//import 'dart:js';

import 'package:provider/provider.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/services/Services.dart';

import '../../locator.dart';
import 'ProfileServices.dart';



class StorageServices extends Services {
  StorageServices() {
    // getFirebaseUser();
    // getSchoolCode();
    // 
    // TODO: connect to database..
    // 
  }


  ProfileServices _profileServices = locator<ProfileServices>();
  AppUser _currentUser  =null;

  get child => _profileServices.child;//AppUser(displayName:'flennn',id:'531f');



  getChildrens() async {
    AppUser _currentUser  =_profileServices.user;
    // log(_currentUser.DisplayName.toString());
    await _profileServices.getChildrens();

    return _profileServices.child;
    
  }

  // Future<String> setProfilePhoto(String filePath) async {
  //   //if (firebaseUser == null) await getFirebaseUser();
  //   //if (schoolCode == null) await getSchoolCode();
  //   // String schoolCode = await sharedPreferencesHelper.getSchoolCode();

  //   String _extension = p.extension(filePath);
  //   String fileName = firebaseUser.uid + _extension;
  //   // final UploadTask uploadTask = storageReference
  //   //     .child(schoolCode + '/' + "Profile" + '/' + fileName)
  //   //     .putFile(
  //   //       File(filePath),
  //   //       SettableMetadata(
  //   //         contentType: "image",
  //   //         customMetadata: {
  //   //           "uploadedBy": firebaseUser.uid,
  //   //         },
  //   //       ),
  //   //     );

  //   // final TaskSnapshot downloadUrl = await uploadTask.snapshot;
  //   final String profileUrl = await downloadUrl.ref.getDownloadURL();

  //   await sharedPreferencesHelper.setLoggedInUserPhotoUrl(profileUrl);

  //   return profileUrl;
  // }
  

  // Future<String> uploadAnnouncemantPhoto(
  //     String filePath, String fileName) async {
  //   if (schoolCode == null) await getSchoolCode();
  //   if (firebaseUser == null) await getFirebaseUser();

  //   final UploadTask uploadTask = storageReference
  //       .child(schoolCode + "/" + "Posts" + '/' + fileName)
  //       .putFile(
  //         File(filePath),
  //         SettableMetadata(
  //           contentType: "image",
  //           customMetadata: {
  //             "uploadedBy": firebaseUser.uid,
  //           },
  //         ),
  //       );

  //   final TaskSnapshot downloadUrl = await uploadTask.snapshot;
  //   final String postmageUrl = await downloadUrl.ref.getDownloadURL();

  //   return postmageUrl;
  // }

  // Future<String> uploadAssignment(String filePath, String fileName) async {
  //   if (schoolCode == null) await getSchoolCode();
  //   if (firebaseUser == null) await getFirebaseUser();

  //   String _extension = p.extension(filePath);
  //   String file = fileName + _extension;

  //   final UploadTask uploadTask = storageReference
  //       .child(schoolCode + "/" + "Assignments" + '/' + file)
  //       .putFile(
  //         File(filePath),
  //         SettableMetadata(
  //           contentType: "PDF",
  //           customMetadata: {
  //             "uploadedBy": firebaseUser.uid,
  //           },
  //         ),
  //       );

  //   final TaskSnapshot downloadUrl = await uploadTask.snapshot;
  //   final String postmageUrl = await downloadUrl.ref.getDownloadURL();

  //   return postmageUrl;
  // }
}
