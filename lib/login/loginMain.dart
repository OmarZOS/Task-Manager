import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/enums/UserType.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/services/AuthenticationServices.dart';
import 'package:task_manager/core/services/ProfileServices.dart';
import 'package:task_manager/widgets/DynamicThemeChanger.dart';
import '../locator.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'transition_route_observer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
      SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>.value(
          initialData: AppUser(),
          value: locator<ProfileServices>().loggedInUserStream.stream,
        ),
        
        StreamProvider<UserType>.value(
          initialData: UserType.UNKNOWN,
          value: locator<AuthenticationServices>().userTypeStream.stream,
        ),
        StreamProvider<bool>.value(
          initialData: false,
          value: locator<AuthenticationServices>().isUserLoggedInStream.stream,
        ),
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
        themedWidgetBuilder: (context, theme) => new LoginPage(
          //theme: theme,
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  static const id = "LoginPage";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        accentColor: Colors.orange,
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.orange),
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          button: TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          headline1: TextStyle(fontFamily: 'Quicksand'),
          headline2: TextStyle(fontFamily: 'Quicksand'),
          headline4: TextStyle(fontFamily: 'Quicksand'),
          headline5: TextStyle(fontFamily: 'NotoSans'),
          headline6: TextStyle(fontFamily: 'NotoSans'),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
          subtitle2: TextStyle(fontFamily: 'NotoSans'),
          overline: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: LoginScreen(),
      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        //DashboardScreen.routeName: (context) => DashboardScreen(),
      },
    );
  }
}