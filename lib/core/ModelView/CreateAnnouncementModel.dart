import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/models/Announcement.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/services/AnnouncementServices.dart';
import 'package:task_manager/core/services/StorageService.dart';
import 'package:task_manager/core/services/ToolServices.dart';
import '../../locator.dart';
import 'BaseModel.dart';



class CreateAnnouncementModel extends BaseModel {

  AnnouncementServices announcementServices = locator<AnnouncementServices>();
  StorageServices _storageServices = locator<StorageServices>();
  ToolServices _toolServices = locator<ToolServices>();
  List<AppUser> workers = [];
  List<dynamic> tools = [];

  getPersons() async {
    _storageServices.getChildrens();
    workers =   _storageServices.child;
  }

  getTools(String id)async{
    _toolServices.getTools(id);
    tools =  _toolServices.myTools;
  }

Future<bool>  addTask(var task)async {
  var body = json.encode(task);
  log("starting to add task");
      Dio dio = Dio();
      Options options = Options(
      contentType: 'multipart/form-data',
      headers: _toolServices.headers,
    );
// log(body);
    final response = await dio.post(
      _toolServices.addAssignmentUrl,
      options: options,
      data: body,
      // body: body,
    );
if(response.statusCode==200){
      
      if(response.data.toString().contains("added")){
      log("task added.. supposedly..");
      return true;
      }
      else {
        log(response.data);
        return false;
        }
    }

return false;


  }




  StartAnnouncement(var message) async {
    var body = json.encode(message);
  log("starting annoncement");
      Dio dio = Dio();
      Options options = Options(
      contentType: 'multipart/form-data',
      headers: _toolServices.headers,
    );

    final response = await dio.post(
      _toolServices.postTaskUrl,
      options: options,
      data: body,
    );
  log(response.data);
    if(response.statusCode==200){
      log("got response task");
      if(response.data.toString().contains("added"))
        Fluttertoast.showToast(
          msg: "Tâche ajoutée avec succès..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          // backgroundColor: Colors.grey,
          // textColor: Colors.white,
          fontSize: 16.0
        );
      else
        Fluttertoast.showToast(
          msg: "Failed to attribute task",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          // backgroundColor: Colors.grey,
          // textColor: Colors.white,
          // fontSize: 16.0
        );
    }
    else{
      log("failes to add task");
      Fluttertoast.showToast(
        msg: "Failed to add Task",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        fontSize: 16.0
      );
    }

  }

  getUserData() async {
    setState(ViewState.Busy);
    await announcementServices.init();
    setState(ViewState.Idle);
  }

  Future postAnnouncement(Announcement announcement) async {
    setState(ViewState.Busy);
    await announcementServices.postAnnouncement(announcement);
    setState(ViewState.Idle);
  }

  @override
  void dispose() {
    if (state == ViewState.Idle && state2 == ViewState.Idle) {
      super.dispose();
    }
  }
}
