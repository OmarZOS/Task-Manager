import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/ModelView/BaseView.dart';
import 'package:task_manager/core/ModelView/CreateAnnouncementModel.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/models/Announcement.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/core/services/ProfileServices.dart';
import 'package:task_manager/widgets/ChoosableTile.dart';
import 'package:task_manager/widgets/MyReusableTile.dart';
import 'package:task_manager/widgets/IntegerExample.dart';
import 'package:task_manager/widgets/TopBar.dart';
//import 'package:ourESchool/imports.dart';
import '../Utilities/Resources.dart';
import '../core/enums/announcementType.dart';
import '../locator.dart';
// import 'package:numberpicker/numberpicker.dart';
import '../widgets/IntegerExample.dart';





class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);
  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  String path = '';

  // TextEditingController _standardController;
  TextEditingController _divisionController;
  TextEditingController _captionController;
  // final GlobalKey expansionTileKey = GlobalKey();

  var showSubordinates=false;

  // List<String> model.workers= ["sqc","zfa","fzaf"];
  List<bool> isChosenChild = [];
  List<bool> isChosenTool = [];



  AnnouncementType announcementType = AnnouncementType.CIRCULAR;

  FocusNode _focusNode = new FocusNode();
  var _scaffoldKey;
  bool isPosting = false;
  Color postTypeFontColor = Colors.black;
  bool isReadyToPost = false;
  String postType = 'GLOBAL';

  int _currentPeriod = 1;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    // _standardController = TextEditingController();
    _captionController = TextEditingController();
    _divisionController = TextEditingController();
  }

  floatingButtonPressed(
      CreateAnnouncementModel model, BuildContext context) async {
    AppUser user = Provider.of<AppUser>(context, listen: false);

    log("Clicked");
    // var announcement = Announcement(
    //   by: user.id,
    //   caption: _captionController.text,
    //   forClass:
    //       postType == 'Spécifique' ? _standardController.text.trim() : 'Global',
    //   forDiv: postType == 'Spécifique'
    //       ? _divisionController.text.toUpperCase().trim()
    //       : 'Global',
    //   //type: announcementType,
    // );
    log(postType);





    if (postType == 'Spécifique') {
      bool sendmsg=false;
      List<dynamic> message = List.empty(growable:true);
      for (int i = 0; i < model.workers.length ; i++) {
        if(isChosenChild[i]){
          sendmsg=true;
          var map = {
            "email":model.workers[i].email,
            "label":_divisionController.text,
            "description": _captionController.text,
            "periode": _currentPeriod,
          };
          message.add(map);
        }
      }

      if(sendmsg){
        var map = {
            "email": locator<ProfileServices>().user.email ,
            "label":_divisionController.text,
            "description": _captionController.text,
            "periode": _currentPeriod,
          };

        if(await model.addTask(map)){
          await model.StartAnnouncement(message);
          kbackBtn(context);
        }

        else{
          log("failed to create new task..");
        }


      }



      // await model.postAnnouncement(announcement);
    } else {
      // await model.postAnnouncement(announcement);
      kbackBtn(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    postTypeFontColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return BaseView<CreateAnnouncementModel>(
      onModelReady: (model)  async {
        model.getUserData();
        await model.getPersons();
        await model.getTools(locator<ProfileServices>().user.email);
        isChosenChild=List.filled(25, false);
        isChosenTool=List.filled(25, false);
        setState(() {
          
        });
      } ,
      builder: (context, model, child) {
        isPosting = model.state == ViewState.Idle ? false : true;
        return Scaffold(
          key: _scaffoldKey,
          appBar: TopBar(
            onTitleTapped: () {},
            child: kBackBtn,
            onPressed: () {
              if (!isPosting) kbackBtn(context);
            },
            title: string.create_post,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isReadyToPost) floatingButtonPressed(model, context);
            },
            backgroundColor: isReadyToPost
                ? Theme.of(context).primaryColor
                : Colors.blueGrey,
            child: model.state == ViewState.Busy
                ? SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 20,
                  )
                : Icon(Icons.check),
          ),
          body: InkWell(
            // splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              _focusNode.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // height: 165,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              string.this_post_is_for,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: RawMaterialButton(
                                    elevation: 0,
                                    constraints: BoxConstraints(minHeight: 50),
                                    child: Text(
                                      'Personnel général',
                                      style: TextStyle(
                                        color: postType == 'GLOBAL'
                                            ? Colors.white
                                            : postTypeFontColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      this.setState(() {
                                        postType = 'GLOBAL';
                                        announcementType = AnnouncementType.CIRCULAR;
                                      });
                                    },
                                    fillColor: postType == 'GLOBAL'
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                                Expanded(
                                  child: RawMaterialButton(
                                    elevation: 0,
                                    constraints: BoxConstraints(minHeight: 50),
                                    child: Text(
                                      'Spécifique',
                                      style: TextStyle(
                                        color: postType == 'Spécifique'
                                            ? Colors.white
                                            : postTypeFontColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        postType = 'Spécifique';
                                        announcementType  = AnnouncementType.EVENT;
                                      });
                                    },
                                    fillColor: postType == 'Spécifique'
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          postType == 'Spécifique'
                              ? SizedBox(
                                  height: 5,
                                )
                              : Container(),
                          Container(
                      // height: 60,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          postType != 'Spécifique'?
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'Circulaire',
                                style: TextStyle(
                                  color: announcementType ==
                                          AnnouncementType.CIRCULAR
                                      ? Colors.white
                                      : postTypeFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (model.state == ViewState.Idle)
                                    announcementType =
                                        AnnouncementType.CIRCULAR;
                                });
                              },
                              color:
                                  announcementType == AnnouncementType.CIRCULAR
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                            ),
                          ):Container(),
                          postType == 'Spécifique'?
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'Tâche',
                                style: TextStyle(
                                  color:
                                      announcementType == AnnouncementType.EVENT
                                          ? Colors.white
                                          : postTypeFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (model.state == ViewState.Idle)
                                    announcementType = AnnouncementType.EVENT;
                                });
                              },
                              color: announcementType == AnnouncementType.EVENT
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                            ),
                          )
                          :Container(),
                          postType == 'Spécifique'?
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'Commission',
                                style: TextStyle(
                                  color: announcementType ==
                                          AnnouncementType.ACTIVITY
                                      ? Colors.white
                                      : postTypeFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (model.state == ViewState.Idle)
                                    announcementType =
                                        AnnouncementType.ACTIVITY;
                                });
                              },
                              color:
                                  announcementType == AnnouncementType.ACTIVITY
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                            ),
                          )
                          :Container()
                        ],
                      ),
                    ),
                    postType == 'Spécifique'?
                    Center(child: 
                      Column(children: [NumberPicker(
                      value: _currentPeriod,
                      minValue: 1,
                      maxValue: 100,
                      onChanged: (value) => setState(() {
                        _currentPeriod = value;
                      } ),
        ),
        Text('Nombre de jours estimé : $_currentPeriod'),],)

                    
                    ):Container(),
                          postType == 'Spécifique'
                              ? 
                                ExpansionTile(
                                  title: Text("Choisissez vos subordonnés"),
                                  children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: model.workers.length,//model.workers.length 
                                          itemBuilder: (BuildContext context, int index){
                                            if(index<model.workers.length)//model.workers.length
                                              return
                                                    ChoosableTile(

                                                      tittle: Text(model.workers[index].DisplayName),
                                                      status: TextSpan(text:model.workers[index].disponible?"Actif":"Inactif"),
                                                      icon:Icon(Icons.person_rounded), 
                                                      // isChosenChild[index]?Icon(Icons.check_box_rounded):Icon(Icons.person_add),
                                                      onClick: () {
                                                        isChosenChild[index]=!isChosenChild[index];
                                                        // log(isChosenChild[index].toString());
                                                        setState(() {}) ;
                                                        // return isChosenChild[index];
                                                      },
                                                      coloring: isChosenChild[index]?Colors.teal.withOpacity(0.5):Colors.blueGrey.withOpacity(0.5),
                                                      
                                                    );
                                          },
                                          
                                        ),
                                  ],
                                )
                              : Container(),
                          postType == 'Spécifique'
                              ? 
                                ExpansionTile(
                                  title: Text("Ressources Disponibles"),
                                  children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: model.tools.length,//model.workers.length 
                                          itemBuilder: (BuildContext context, int index){
                                            if(index<model.tools.length)//model.workers.length
                                              return
                                              (model.tools[index]["Disponibility"]??'1')=="1"?
                                                    ChoosableTile(
                                                      tittle: Text(model.tools[index]["LABEL_VEHICULE"]??""), 
                                                      status: TextSpan(text:""), 
                                                      icon: model.tools[index]["ID_OUTIL"]=="PC"?
                                                        Icon(Icons.computer)
                                                        :Icon(Icons.add_box),
                                                      onClick: (){
                                                        isChosenTool[index]=!isChosenTool[index];
                                                        log(isChosenTool[index].toString());
                                                        setState(() {}) ;
                                                      },
                                                      coloring: isChosenTool[index]?Colors.teal.withOpacity(0.5):Colors.blueGrey.withOpacity(0.5),
                                                    ):Container;
                                            else
                                              return Text("Aucune Ressource n'est disponible pour le moment");
                                          },
                                          
                                        ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    



                    
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      // color: Colors.blueAccent.withOpacity(0.5),
                      child: TextField(
                        controller: _divisionController,
                        enabled: !isPosting,
                        // focusNode: _focusNode,
                        maxLength: null,
                        onChanged: (value) {
                          setState(() {
                            isReadyToPost = value == '' ? false : true;
                          });
                        },
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: string.type_your_stuff_here,
                          labelText: "Intitulé",
                        ),
                      ),
                    ),
                    SizedBox(
                      height:10,
                    ),

                    Container(
                      height: 150,
                      // color: Colors.blueAccent.withOpacity(0.5),
                      child: TextField(
                        controller: _captionController,
                        enabled: !isPosting,
                        // focusNode: _focusNode,
                        maxLength: null,
                        onChanged: (caption) {
                          setState(() {
                            isReadyToPost = caption == '' ? false : true;
                          });
                        },
                        maxLines: 50,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: string.type_your_stuff_here,
                          labelText: "Description",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  


}
