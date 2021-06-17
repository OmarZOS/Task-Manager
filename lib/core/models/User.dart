// import 'dart:collection';

// import 'package:task_manager/core/services/ProfileServices.dart';
// import'package:flutter/material.dart';



import 'dart:developer';

class AppUser {
  //  String photoUrl;
   String email;
   String id;
   String unite;
  //  String enrollNo;
  //String firebaseUuid;
   String displayName;
   String birthDate;
  //  String guardianName;
  //  String standard;
  //String bloodGroup;
  //  String mobileNo;
   String sex;
   bool disponible;
  // bool isTeacher=false;
  //bool isVerified;
  // Map<String, dynamic> connection;
  // var connection;


  String get DisplayName => displayName;


  // String standardDivision() {
  //   return standard + unite.toUpperCase();
  // }

  AppUser(
      {
        // this.photoUrl = 'default',
      this.email = '',
      this.unite = '',
      // this.id = '',
      // this.enrollNo = '',
      //this.firebaseUuid = '',
      // this.connection = null,
      this.displayName = '',
      this.disponible = false,
      // this.standard = '',
      this.birthDate = '',
      // this.guardianName = '',
      //this.bloodGroup = '',
      // this.mobileNo = '',
      // this.isTeacher = false,
      this.sex=''
      //this.isVerified = false
  });

  bool isEmpty() {
    if (this.displayName == '') return true;

    // if (this.unite == '') return true;

    // if (this.standard == '') return true;

    // if (this.guardianName == '') return true;

    return false;
  }

//  AppUser.fromSnapshot(DocumentSnapshot documentSnapshot) {
//    _fromJson(documentSnapshot.data());
//  }

  _fromJson(Map<String, dynamic> json) {
    //photoUrl = json['photoUrl'] ?? 'default';
    email = json['email'] ?? '';
    unite = json['Unit'] ?? '';
    displayName = (json['nom'] ?? ' ')+" "+(json['prenom'] ?? ' ');
    birthDate = json['birthDate'] ?? '';
    sex=json['sex']=="1"?'Female':'Male';
    disponible = json['disonible']=="1";
    // log(displayName);

    //id = json['id'] ?? '';
    //enrollNo = json['enrollNo'] ?? '';
    //firebaseUuid = json['firebaseUuid'] ?? '';
    // standard = json['standard'] ?? '';
    // guardianName = json['guardianName'] ?? '';
    //bloodGroup = json['bloodGroup'] ?? '';
    //mobileNo = json['mobileNo'] ?? '';
    //isTeacher = json['isTeacher'] ?? false;
    //isVerified = json['isVerified'] ?? false;
    //connection = json['connection'] ?? {};
  }

  AppUser.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['photoUrl'] = this.photoUrl;
    data['email'] = this.email;
    log(data['email']);
    data['unite'] = this.unite.toUpperCase().trim();
    data['displayName'] = this.displayName;
    data['birthDate'] = this.birthDate;
    data['sex'] = (this.sex=="Female");
    data['disonible'] = (this.disponible=="1");
    // data['id'] = this.id;
    // data['enrollNo'] = this.enrollNo;
    //data['firebaseUuid'] = this.firebaseUuid;
    // data['standard'] = this.standard;
    // data['guardianName'] = this.guardianName;
    //data['bloodGroup'] = this.bloodGroup;
    // data['mobileNo'] = this.mobileNo;
    // data['isTeacher'] = this.isTeacher;
    //data['isVerified'] = this.isVerified;
    // data['connection'] = this.connection;
    return data;
  }
}

// List<AppUser> users = [];
//   User(
//       displayName: "Name Surname",
//       division: "A",
//       standard: "9",
//       photoUrl:
//           "https://www.discover.com/content/dam/dfs/student-loans/hero/homebanner/home_mob.jpg",
//       bloodGroup: "B+",
//       dob: "29/02/1998",
//       email: "student@std.com",
//       firebaseUuid: "randomid123",
//       isTeacher: false,
//       mobileNo: "1234567890"),
//   User(
//       displayName: "Name2 Surname",
//       division: "B",
//       standard: "6",
//       photoUrl:
//           "https://www.collegechoice.net/wp-content/uploads/2014/07/00_Student.jpg",
//       bloodGroup: "B+",
//       dob: "21/01/2000",
//       email: "student@std.com",
//       firebaseUuid: "randomid1234",
//       isTeacher: false,
//       mobileNo: "1234567450")
// ];
