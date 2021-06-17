//import 'package:ourESchool/imports.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/ModelView/ToolPageModel.dart';
import 'package:task_manager/core/ModelView/BaseView.dart';
import 'package:task_manager/core/enums/UserType.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/services/ProfileServices.dart';
import 'package:task_manager/widgets/MyReusableTile.dart';
import 'package:task_manager/widgets/TopBar.dart';
import '../Utilities/Resources.dart';

import '../locator.dart';
// import 'CreateTool.dart';

class ToolPage extends StatefulWidget  {
  ToolPage({
    Key key,
    this.ToolFor = '',
  }) : super(key: key) {
    // setCurrentScreen();
  }

  final String ToolFor;

  @override
  _ToolPageState createState() => _ToolPageState();

  @override
  
  String get screenName => string.transportation + 'Page';
}

class _ToolPageState extends State<ToolPage>
    with AutomaticKeepAliveClientMixin {


  


  bool isTeacher = false;

  ScrollController controller;
  ToolPageModel model = ToolPageModel();
  String stdDiv_Global = 'Global';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLast = false;
  bool isLoaded = false;
  String buttonLabel = 'Global';

  TextEditingController _standardController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();

  @override
  void initState() {
    //log(locator<ProfileServices>().user.email);
    // model.getTools(locator<ProfileServices>().user.email);
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
    stdDiv_Global =
        widget.ToolFor == '' ? 'Global' : widget.ToolFor;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (model.state == ViewState.Idle) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        // setState(() => _isLoading = true);
        model.getTools(stdDiv_Global);
        scaffoldKey.currentState.widget;
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

      print(stdDiv_Global);
    }
    return BaseView<ToolPageModel>(
        onModelReady: (model) => model.getTools(locator<ProfileServices>().user.email),
        builder: (context, model, child) {
          this.model = model;
          return Scaffold(
            key: scaffoldKey,
            appBar: TopBar(
                buttonHeroTag: "string.transportation",
                title: "Ressources",
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
                        // kopenPageSlide(context, CreateTool(),
                            // duration: Duration(milliseconds: 200));
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 31),
                //   child: Align(
                //     alignment: Alignment.bottomLeft,
                //     child: userType == UserType.STUDENT
                //         ? FloatingActionButton.extended(
                //             label: Text(buttonLabel),
                //             heroTag: 'abc',
                //             elevation: 12,
                //             onPressed: () async {
                //               if (stdDiv_Global == 'Global') {
                //                 setState(() {
                //                   buttonLabel = stdDiv_Global;
                //                   // stdDiv_Global = currentUser.standard +
                //                   //     currentUser.division.toUpperCase();
                //                 });
                //               } else {
                //                 setState(() {
                //                   buttonLabel = stdDiv_Global;
                //                   stdDiv_Global = 'Global';
                //                 });
                //               }

                //               await model.onRefresh(stdDiv_Global);
                //             },
                //             icon: Icon(FontAwesomeIcons.globe),
                //             backgroundColor: Colors.red,
                //           )
                //         : userType == UserType.TEACHER
                //             ? FloatingActionButton.extended(
                //                 label: Text('Filter'),
                //                 heroTag: 'abc',
                //                 elevation: 12,
                //                 onPressed: () {
                //                   //Filter Posts Code Here
                //                   filterDialogBox(context, model);
                //                 },
                //                 icon: Icon(Icons.filter_list),
                //                 backgroundColor: Colors.red,
                //               )
                //             : Container(),
                //   ),
                // ),
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
                                  'Aucune ressource disponible..',
                                  style: ksubtitleStyle.copyWith(fontSize: 25),
                                ),
                              ),
                              // color: Colors.red,
                            ):
                        ListView.builder(
                          addAutomaticKeepAlives: true,
                          cacheExtent: 10,
                          controller: controller,
                          itemCount:  model.postSnapshotList.length,//model.postSnapshotList.length
                          itemBuilder: (context, index) {
                            if (index < model.postSnapshotList.length) {//model.postSnapshotList.length
                              return MyReusableTile(
                                  // Tool: Tool.fromSnapshot(
                                      // model.postSnapshotList[index]),
                                      tittle: Text(model.postSnapshotList[index]["LABEL_VEHICULE"]),//model.postSnapshotList[index]["Label_Tache"]
                                      status: TextSpan(text:model.postSnapshotList[index]["DISPONIB_VEHICULE"]!=1?"disponible":"indisponible"),//model.postSnapshotList[index]["Description"]
                                      icon: Icon(Icons.airport_shuttle_outlined)
                                      );
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
                    await model.onRefresh(stdDiv_Global);
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
}
