// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ourESchool/core/enums/ViewState.dart';
// import 'package:ourESchool/core/services/AnnouncementServices.dart';
// import 'package:ourESchool/core/viewmodel/BaseModel.dart';
// import 'package:ourESchool/locator.dart';

import 'dart:developer';

import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/services/AnnouncementServices.dart';
import 'package:task_manager/core/services/ProfileServices.dart';

import '../../locator.dart';
import 'BaseModel.dart';

class AnnouncementPageModel extends BaseModel { 
  AnnouncementServices _announcementServices = locator<AnnouncementServices>();

  AnnouncementPageModel();

  List<dynamic> get postSnapshotList =>
      _announcementServices.myTasks;

  getAnnouncements(String stdDiv_Global) async {
    setState(ViewState.Busy);
    await _announcementServices.getAnnouncements(stdDiv_Global );
    setState(ViewState.Idle);
  }

  onRefresh(String stdDiv_Global) async {
    // _announcementServices.postDocumentSnapshots.clear();
    // _announcementServices.lastPostSnapshot = null;
    await getAnnouncements(stdDiv_Global);
  }

   Future<bool> endTask(int index) async {
     
     if(await _announcementServices.endTask(_announcementServices.myTasks[index]["ID_TACHE"])){

       log("removing task index : "+index.toString());
       log("id : "+_announcementServices.myTasks[index]["ID_TACHE"]);
        _announcementServices.myTasks.removeAt(index);
       return true;
     }

     log("not removed?");
    return false;
     
    
  }

  @override
  void dispose() {
    // _announcementServices.lastPostSnapshot = null;
    // _announcementServices.postDocumentSnapshots.clear();
    super.dispose();
  }
}
