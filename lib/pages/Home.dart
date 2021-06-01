import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/enums/UserType.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/widgets/MainDashboard.dart';
import 'package:task_manager/widgets/TopBar.dart';
import '../widgets/BottomBar.dart';
import '../Utilities/Resources.dart';
import 'CreateAnnouncement.dart';
import 'GuardianProfile.dart';
import 'ProfilePage.dart';
import 'SettingPage.dart';
import 'StudentDashboard.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  //if (kIsWeb) await FirebaseFirestore.instance.enablePersistence();
  //await Firebase.initializeApp();


  runApp(
    StudentDashboard(),
  );
}

class Home extends StatefulWidget {
  static const id = 'Home';
  Home()  ;
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;
  Color background = Colors.teal;
  // AuthenticationServices _auth = locator<AuthenticationServices>();
  bool isTeacher = false;
  // MainPageModel mainPageModel;

  // _auth.userType == UserType.STUDENT ? false : true;
  String pageName = string.home;

  List<Widget> pages = [
    MainDashboard(),//
    //ChatPage(),
    //NotificationPage(),
    // CreateAnnouncement(),
    SettingPage()
  ];

  List<Widget> studentPages = [
    StudentDashboard(),
    //SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  // ImageProvider<dynamic> setImage(AppUser user) {
  //   return AssetImage(assetsString.student_welcome); 
  //   // user.photoUrl != 'default'
  //   //     ? NetworkImage(
  //   //         user.photoUrl,
  //   //       )
  //   //     : AssetImage(assetsString.student_welcome);//AssetImage(assetsString.student_welcome);
  // }

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<UserType>(context, listen: false);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    }
    AppUser user = Provider.of<AppUser>(context, listen: false);
    return Container(
        //backgroundColor:Colors.teal,
      child: Scaffold(
        
        appBar: TopBar(
          buttonHeroTag: 'profile',
          title: pageName,
          // child: Image(), 
          // Image(
          //   height: 30,
          //   width: 30,
          //   // image:setImage(user),    // setImage(user),
          // ),
          onPressed: () {
            if (userType == UserType.PARENT) {
              kopenPage(context, GuardianProfilePage());
            } else {
              kopenPage(context, ProfilePage());
            }
          },
        ),
        floatingActionButton: Visibility(
          visible: isTeacher,
          child: FloatingActionButton(
            onPressed: () {
              kopenPageSlide(context, CreateAnnouncement());
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: buildBubbleBottomBar(userType),
        body: userType == UserType.STUDENT
            ? IndexedStack(
                index: currentIndex,
                children: studentPages,
              )
            : IndexedStack(
                index: currentIndex,
                children: pages,
              ),
      backgroundColor : Colors.teal
      ),
    );
  }

  List<BubbleBottomBarItem> studentItems = [
    BubbleBottomBarItem(
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.dashboard,
      ),
      activeIcon: Icon(
        Icons.dashboard,
        color: Colors.red,
      ),
      title: Text(string.dashboard),
    ),
    BubbleBottomBarItem(
      backgroundColor: Colors.orange,
      icon: Icon(
        Icons.settings,
      ),
      activeIcon: Icon(
        Icons.settings,
        color: Colors.orange,
      ),
      title: Text(
        string.setting,
      ),
    )
  ];

  List<BubbleBottomBarItem> bottomBarItems = [
    BubbleBottomBarItem(
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.dashboard,
      ),
      activeIcon: Icon(
        Icons.dashboard,
        color: Colors.red,
      ),
      title: Text(string.dashboard),
    ),
    BubbleBottomBarItem(
      backgroundColor: Colors.yellow,//deepPurple
      icon: Icon(
        Icons.message,
        // size: 25,
      ),
      activeIcon: Icon(
        Icons.message,
        color: Colors.yellow,//deepPurple
      ),
      title: Text(string.chat),
    ),
    BubbleBottomBarItem(
      backgroundColor: Colors.orange,
      icon: Icon(
        Icons.settings,
      ),
      activeIcon: Icon(
        Icons.settings,
        color: Colors.orange,
      ),
      title: Text(
        string.setting,
      ),
    )
  ];

  BubbleBottomBar buildBubbleBottomBar(UserType userType) {
    return BubbleBottomBar(
      backgroundColor: Colors.teal   ,//Theme.of(context).canvasColor
      opacity: .2,
      currentIndex: currentIndex,
      onTap: (v) {
        if (userType == UserType.STUDENT) {
          setState(() {
            if (v == 0) {
              pageName = StudentDashboard.pageName;
            } else {
              pageName = SettingPage.pageName;
            }
            currentIndex = v;
          });
        } else {
          setState(() {
            if (v == 0) {
              pageName = MainDashboard.pageName;
            } else if (v == 1) {
              //pageName = ChatPage.pageName;
            } else if (v == 2) {
              pageName = SettingPage.pageName;
            }
            currentIndex = v;
          });
        }
      },
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      elevation: 10,
      fabLocation: isTeacher ? BubbleBottomBarFabLocation.end : null, //new
      hasNotch: isTeacher, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: userType == UserType.STUDENT ? studentItems : bottomBarItems,
    );
  }
}