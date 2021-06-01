import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/Utilities/Resources.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/Utilities/custom_icons.dart';
import 'package:task_manager/pages/AidePage.dart';
import 'package:task_manager/pages/AnnouncementPage.dart';
import 'package:task_manager/pages/ClassementPage.dart';
import 'package:task_manager/pages/CreateAnnouncement.dart';
import 'package:task_manager/pages/FacultativePage.dart';
import 'package:task_manager/pages/HistoryPage.dart';
import 'package:task_manager/pages/PersonnelPage.dart';
import 'package:task_manager/pages/StatisticsPage.dart';
import 'package:task_manager/pages/TransportationPage.dart';
//import 'package:task_manager/pages/AnnouncementPage.dart';
import '../widgets/ColumnReusableCardButton.dart';
import 'RowReusableCardButton.dart';


class MainDashboard extends StatefulWidget {
  MainDashboard({Key key}) : super(key: key) {
    // setCurrentScreen();
  }
  static String pageName = string.dashboard;

  _MainDashboardState createState() => _MainDashboardState();

  @override
  String get screenName => 'ParentAndTeacher Dashboard';
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    ColumnReusableCardButton(
                      //directionIconHeroTag: string.childrens,
                      height: 170,
                      tileColor: Colors.deepPurpleAccent,
                      label: string.childrens,
                      icon: FontAwesomeIcons.child,
                      onPressed: () {
                        kopenPage(context, PersonnelPage());
                      },
                    ),
                    Container(
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.deepOrangeAccent,
                            label: string.e_card,
                            icon: Icons.perm_contact_calendar,
                            onPressed: () {
                              kopenPage(context, PersonnelPage());//ECardPage()
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),

                          
                          RowReusableCardButton(
                            tileColor: null,
                            icon: Icons.av_timer,
                            label: string.timetable,
                            onPressed: () {
                              kopenPage(context, CreateAnnouncement());
                            },
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      directionIconHeroTag: string.announcement,
                      height: 170,
                      tileColor: Colors.orangeAccent,
                      label: string.announcement,
                      icon: Icons.notifications_active,
                      onPressed: () {
                        kopenPage(context, AnnouncementPage());
                      },
                    ),
                    Container(
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RowReusableCardButton(
                            tileColor: Colors.blueGrey,
                            icon: Icons.ad_units,
                            label: string.holidays,
                            onPressed: () {
                              kopenPage(context, HistoryPage());
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RowReusableCardButton(
                            tileColor: Colors.lightGreen,
                            label: string.assignment,
                            onPressed: () {
                              kopenPage(context, StatisticsPage());
                            },
                            icon: Icons.assignment,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 105,
                      child: ListView(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowReusableCardButtonBanner(
                                paddingTop: 0,
                                tileColor: Colors.blue,
                                icon: Icons.receipt,
                                label: string.parenting_guide,
                                onPressed: () {
                                  kopenPage(context, FacultativePage());
                                },
                              ),
                              RowReusableCardButtonBanner(
                                paddingTop: 0,
                                tileColor: Colors.red,
                                icon: FontAwesomeIcons.flag,
                                label: string.health_tips,
                                onPressed: () {
                                  kopenPage(context, ClassementPage());
                                },
                              ),
                              // RowReusableCardButtonBanner(
                              //   paddingTop: 0,
                              //   tileColor: Colors.blue,
                              //   icon: FontAwesomeIcons.userMd,
                              //   label: string.vaccinations,
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ColumnReusableCardButton(
                      height: 170,
                      tileColor: Colors.grey,
                      label: string.transportation,
                      onPressed: () {
                        kopenPage(context, TransportationPage());
                      },
                      icon: FontAwesomeIcons.bus,
                    ),
                    ColumnReusableCardButton(
                      tileColor: Colors.greenAccent,
                      height: 70,
                      label: string.offers,
                      onPressed: () {
                        kopenPage(context, AidePage());
                      },
                      icon: FontAwesomeIcons.questionCircle,
                      directionIcon: Icons.chevron_right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
