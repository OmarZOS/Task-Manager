// import 'dart:collection';

// import 'package:task_manager/core/services/ProfileServices.dart';
// import'package:flutter/material.dart';




class AppRessource {

   String id;
   String label;
   String TYPE;


  String get libelle => label;


  AppRessource(
      {
      this.id = '',
      this.label = '',
      this.TYPE = '',
  });

  bool isEmpty() {
    if (this.label == '') return true;

    return false;
  }


  _fromJson(Map<String, dynamic> json) {
    //photoUrl = json['photoUrl'] ?? 'default';
    id = json['ID_OUTIL'] ?? '';
    label = json['LABEL'] ?? '';
    TYPE = (json['TYPE'] ?? '');
  }

  AppRessource.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

}