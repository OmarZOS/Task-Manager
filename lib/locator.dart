import 'package:get_it/get_it.dart';
import 'package:task_manager/core/services/NotificationServices.dart';
import 'core/ModelView/AnnouncementPageModel.dart';
import 'core/ModelView/CreateAnnouncementModel.dart';
import 'core/ModelView/NotificationPageModel.dart';
import 'core/ModelView/PersonnelPageModel.dart';
import 'core/ModelView/ToolPageModel.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/models/ProfilePageModel.dart';
import 'core/services/AnnouncementServices.dart';
import 'core/services/AuthenticationServices.dart';
import 'core/services/ProfileServices.dart';
import 'core/services/StorageService.dart';
import 'core/services/ToolServices.dart';

GetIt locator = GetIt.instance;

//import 'imports.dart';

void setupLocator() {
  // locator.registerLazySingleton(() => MainPageModel());
  //locator.registerSingleton(Services());


  //locator.registerLazySingleton(() => ProfileServices());

  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerLazySingleton(() => AuthenticationServices());
  locator.registerLazySingleton(() => ProfileServices());
  locator.registerLazySingleton(() => AnnouncementServices());
  locator.registerLazySingleton(() => StorageServices());
  locator.registerLazySingleton(() => ToolServices());
  locator.registerLazySingleton(() => NotificationServices());


  locator.registerFactory(() => NotificationPageModel());
  locator.registerFactory(() => PersonnelPageModel());
  locator.registerFactory(() => AnnouncementPageModel());
  locator.registerFactory(() => CreateAnnouncementModel());
  locator.registerFactory(() => ProfilePageModel());
  locator.registerFactory(() => ToolPageModel());

  // locator.registerFactory(() => HolidayModel());
}



/*

  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerFactory(() => QuizStateModel());

  locator.registerLazySingleton(() => RepositoryCalendarific());
  locator.registerFactory(() => HolidayModel());

  locator.registerLazySingleton(() => AuthenticationServices());
  locator.registerFactory(() => LoginPageModel());

  locator.registerLazySingleton(() => ProfileServices());


  locator.registerLazySingleton(() => AssignmentServices());
  locator.registerFactory(() => AssignmentPageModel());

  locator.registerLazySingleton(() => ChatServices());
  locator.registerFactory(() => ChatUsersListPageModel());
  locator.registerFactory(() => MessagingScreenPageModel());
  */
