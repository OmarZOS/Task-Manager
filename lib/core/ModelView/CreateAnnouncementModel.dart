// import 'package:ourESchool/core/Models/Announcement.dart';
// import 'package:ourESchool/core/enums/ViewState.dart';
// import 'package:ourESchool/core/services/AnnouncementServices.dart';
// import 'package:ourESchool/core/viewmodel/BaseModel.dart';
// import 'package:ourESchool/locator.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/models/Announcement.dart';
import 'package:task_manager/core/services/AnnouncementServices.dart';

import '../../locator.dart';
import 'BaseModel.dart';

class CreateAnnouncementModel extends BaseModel {
  AnnouncementServices announcementServices = locator<AnnouncementServices>();

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
