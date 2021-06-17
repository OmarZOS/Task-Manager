// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ourESchool/core/enums/ViewState.dart';
// import 'package:ourESchool/core/services/AnnouncementServices.dart';
// import 'package:ourESchool/core/viewmodel/BaseModel.dart';
// import 'package:ourESchool/locator.dart';

import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/services/NotificationServices.dart';
import 'package:task_manager/core/services/ProfileServices.dart';

import '../../locator.dart';
import 'BaseModel.dart';

class NotificationPageModel extends BaseModel { 
  NotificationServices _notifServices = locator<NotificationServices>();

  NotificationPageModel();

  List<dynamic> get postSnapshotList =>
      _notifServices.myNotifications;

  getNotifs(String stdDiv_Global) async {
    setState(ViewState.Busy);
    await _notifServices.getNotifications(locator<ProfileServices>().user.email );
    setState(ViewState.Idle);
  }

  onRefresh(String stdDiv_Global) async {
    // _announcementServices.postDocumentSnapshots.clear();
    // _announcementServices.lastPostSnapshot = null;
    await getNotifs(stdDiv_Global);
  }

  @override
  void dispose() {
    // _announcementServices.lastPostSnapshot = null;
    // _announcementServices.postDocumentSnapshots.clear();
    super.dispose();
  }
}
