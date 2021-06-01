import 'package:get_it/get_it.dart';
import 'core/ModelView/AnnouncementPageModel.dart';
import 'core/ModelView/CreateAnnouncementModel.dart';
import 'core/ModelView/PersonnelPageModel.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/models/ProfilePageModel.dart';
import 'core/services/AnnouncementServices.dart';
import 'core/services/AuthenticationServices.dart';
import 'core/services/ProfileServices.dart';
import 'core/services/Services.dart';
import 'core/services/StorageService.dart';

GetIt locator = GetIt.instance;

//import 'imports.dart';

void setupLocator() {
  // locator.registerLazySingleton(() => MainPageModel());
  //locator.registerSingleton(Services());

  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerLazySingleton(() => AuthenticationServices());
  locator.registerLazySingleton(() => ProfileServices());

  //locator.registerLazySingleton(() => ProfileServices());

  locator.registerLazySingleton(() => AnnouncementServices());
  locator.registerFactory(() => CreateAnnouncementModel());

  locator.registerFactory(() => AnnouncementPageModel());
  locator.registerLazySingleton(() => StorageServices());
  locator.registerLazySingleton(() => ProfilePageModel());

locator.registerFactory(() => PersonnelPageModel());
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
