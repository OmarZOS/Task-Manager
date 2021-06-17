//import 'package:ourESchool/imports.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/ModelView/AnnouncementPageModel.dart';
import 'package:task_manager/core/ModelView/BaseView.dart';
import 'package:task_manager/core/enums/UserType.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/services/ProfileServices.dart';
import 'package:task_manager/widgets/MyReusableTile.dart';
import 'package:task_manager/widgets/TopBar.dart';
import '../Utilities/Resources.dart';

import '../locator.dart';
import 'CreateAnnouncement.dart';

class AnnouncementPage extends StatefulWidget  {
  AnnouncementPage({
    Key key,
    this.announcementFor
  }) : super(key: key) {
    // setCurrentScreen();
  }

  final String announcementFor;

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState(announcementFor);

  @override
  
  String get screenName => string.announcement + 'Page';
}

class _AnnouncementPageState extends State<AnnouncementPage>
    with AutomaticKeepAliveClientMixin {
  _AnnouncementPageState(this.announcementFor);



  _showSnack1() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Tâche archivée"),
      duration: Duration(seconds: 1),
      )
  );
  _showSnack2() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text(("échec de terminaison de tâche")),
      duration: Duration(seconds: 1),
      )
  );
  String announcementFor;

  bool isTeacher = false;

  ScrollController controller;
  AnnouncementPageModel model = AnnouncementPageModel();
  // String stdDiv_Global = 'Global';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLast = false;
  bool isLoaded = false;
  String buttonLabel = 'Global';

  TextEditingController _standardController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();

  @override
  void initState() {
    //log(locator<ProfileServices>().user.email);
    // model.getAnnouncements(locator<ProfileServices>().user.email);
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
    // stdDiv_Global =
        // widget.announcementFor == '' ? 'Global' : widget.announcementFor;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (model.state == ViewState.Idle) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        // setState(() => isLoaded = true);
        log(announcementFor);
        model.getAnnouncements(announcementFor);
        scaffoldKey.currentState.widget;
        // setState(() {
          
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {



    var userType = Provider.of<UserType>(context, listen: false);
    AppUser currentUser = Provider.of<AppUser>(context, listen: false);
    if (userType == UserType.TEACHER) {
      isTeacher = true;
    } else if (userType == UserType.PARENT) {
    } else if (userType == UserType.STUDENT) {
      if (!isLoaded) {
        // stdDiv_Global =
            // currentUser.standard + currentUser.division.toUpperCase();
        isLoaded = true;
      }

      // print(stdDiv_Global);
    }
    return BaseView<AnnouncementPageModel>(
        onModelReady: (model)  {
          
          model.getAnnouncements(locator<ProfileServices>().user.email);
          
          },
        builder: (context, model, child) {
          this.model = model;
          return Scaffold(
            key: scaffoldKey,
            appBar: TopBar(
                buttonHeroTag: string.announcement,
                title: "Tâches",
                child: kBackBtn,
                onPressed: () {
                  kbackBtn(context);
                }),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: Stack(
              children: <Widget>[
                Visibility(
                  visible: isTeacher,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      elevation: 12,
                      onPressed: () {
                        kopenPageSlide(context, CreateAnnouncement(),
                            duration: Duration(milliseconds: 200));
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 700,
                ),
                child: RefreshIndicator(
                  child: 
                  model.postSnapshotList.length == 0
                      ? model.state == ViewState.Busy
                          ? kBuzyPage(color: Theme.of(context).accentColor)
                          : Container(
                              child: Center(
                                child: Text(
                                  'Aucune notification disponible..',
                                  style: ksubtitleStyle.copyWith(fontSize: 25),
                                ),
                              ),
                              // color: Colors.red,
                            ):
                        new ListView.builder(
                          addAutomaticKeepAlives: true,
                          cacheExtent: 10,
                          controller: controller,
                          itemCount:  model.postSnapshotList.length,//model.postSnapshotList.length
                          itemBuilder: (context, index) {
                            if (index < model.postSnapshotList.length) {//model.postSnapshotList.length
                              return 
                              (model.postSnapshotList[index]["Etat"]!="fin"?Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[MyReusableTile(
                                  // announcement: Announcement.fromSnapshot(
                                      // model.postSnapshotList[index]),
                                      tittle: Text(model.postSnapshotList[index]["Label_Tache"]),//model.postSnapshotList[index]["Label_Tache"]
                                      status: TextSpan(
                                        // text : "About : ",
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: model.postSnapshotList[index]["Description"]+"\n",
                                              style: TextStyle(color: Colors.blueAccent.withOpacity(1),fontSize:18)

                                          ),
                                          TextSpan(
                                            text : "",//"Status : "+model.postSnapshotList[index]["Etat"]+"\n"
                                          ),
                                          TextSpan(
                                            text : "Lancé le : "+model.postSnapshotList[index]["Date_Debut"]+"\n",
                                          ),
                                          TextSpan(
                                            text : "Intervalle : "+model.postSnapshotList[index]["periode"]+" jours.\n",
                                          ),
                                        ],
                                      ),//model.postSnapshotList[index]["Description"]
                                      icon: Icon(Icons.time_to_leave),
                                      TYPE: "Task",
                                      id : model.postSnapshotList[index]["ID_TACHE"],
                                      disponible : model.postSnapshotList[index]["Etat"]=="encours",
                                      // disponible: model.postSnapshotList[index]["ID_TACHE"]

                                    ),
                                    ButtonTheme(
                                      minWidth: 400,
                                      child:ElevatedButton(onPressed: () { 
                                        
                                        showAlertDialog(context,index,model.postSnapshotList[index]["Label_Tache"]);
                                        // setState(() {
                                          
                                        // });


                                      },
                                    child: Text("              Terminé?              "),
                                    ) 
                                    
                                    
                                    )
                                      
                                    ]
                              ):Container());
                              
                            } else {
                              return Center(
                                child: new Opacity(
                                  opacity:
                                      model.state == ViewState.Busy ? 1.0 : 0.0,
                                  child: new SizedBox(
                                      width: 32.0,
                                      height: 32.0,
                                      child: kBuzyPage(
                                          color:
                                              Theme.of(context).accentColor)),
                                ),
                              );
                            }
                          },
                        ),
                  onRefresh: () async {
                    await model.onRefresh(announcementFor);
                  },
                ),
              ),
            ),
          );
        });
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


showAlertDialog(BuildContext context, int index,String label) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Annuler"),
    onPressed:  () {
      kbackBtn(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Oui"),
    onPressed:  () async {
      if(await model.endTask(index)){
        _showSnack1();

      }
      else _showSnack2();
      
      kbackBtn(context);
      
      setState(() {
        
      });


    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(label),
    content: Text("Avez vous vraiment terminé cette tâche?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}



