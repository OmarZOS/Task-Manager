import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/locator.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/pages/Home.dart';
import 'core/enums/UserType.dart';
import 'core/services/AuthenticationServices.dart';
import 'core/services/ProfileServices.dart';
import 'widgets/DynamicThemeChanger.dart';
import 'login/loginMain.dart';


//import 'package:task_manager/core/enums/ViewState.dart';


//import 'imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  // timeDilation = 2;
  //await Firebase.initializeApp();
  //if (kIsWeb) await FirebaseFirestore.instance.enablePersistence();

  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(
    MyApp(),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserType>.value(
          // initialData: UserType.UNKNOWN,
          value: locator<AuthenticationServices>().userTypeStream.stream,
        ),
        StreamProvider<bool>.value(
          // initialData: false,
          value: locator<AuthenticationServices>().isUserLoggedInStream.stream,
        ),
        StreamProvider<AppUser>.value(
          initialData: AppUser(),
          value: locator<ProfileServices>().loggedInUserStream.stream,
        ),
        /*
        StreamProvider<User>.value(
          initialData: null,
          value: locator<AuthenticationServices>()
              .fireBaseUserStream
              .stream
              .asBroadcastStream(),
        ),*/
      ],
      child: DynamicTheme(

        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          fontFamily: "Nunito",
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          primaryColorDark: Color(0xff0029cb),
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) => new OurSchoolApp(
          theme: theme,
        ),
      ),
    );
  }
}



class OurSchoolApp extends StatelessWidget {
  const OurSchoolApp({
    Key key,
    this.theme,
  }) : super(key: key);//

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: theme,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        Home.id: (context) => Home(),
        //Home.id: (context) => Home(),
        //ProfilePage.id: (context) => ProfilePage(),
        //GuardianProfilePage.id: (context) => GuardianProfilePage(
        //      title: 'Guardian Profile',
        //    ),
      },
      home: getHome(context),
    );
  }

  Widget getHome(BuildContext context) {
    
  // return Home();

    AppUser currentUser = Provider.of<AppUser>(context, listen: false);
    UserType userType = Provider.of<UserType>(context, listen: false);

    // log(currentUser.DisplayName);
    log(userType.toString());
    log("is logged : "+Provider.of<bool>(context, listen: false).toString());


    //return ();//LoginPage()Home
    /*
     if (Provider.of<FirebaseUser>(context, listen: false) == null &&
         userType == UserType.UNKNOWN) {
           print("here");
       return WelcomeScreen();
     }
  */
    // if(Provider.of<bool>(context, listen: false)){
    //   return Home();
    // }
    if (userType == UserType.UNKNOWN) {
      log("main.dart : Unknown user, go to login");
      return LoginPage();
    }

    if (userType!=UserType.UNKNOWN&&userType!=null) {//Provider.of<bool>(context, listen: false)
      if (userType == UserType.STUDENT || userType == UserType.TEACHER) {
        log("main.dart : login if user empty");
        return currentUser.isEmpty() ? LoginPage() : Home();
      } else {
        return Home();
      }
    } else {
      log("main.dart : Unknown user or null, go to login");
      return LoginPage();
    }

  }



}
