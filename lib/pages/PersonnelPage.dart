
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/ModelView/BaseView.dart';
import 'package:task_manager/core/ModelView/ChildrenGridViewCard.dart';
import 'package:task_manager/core/ModelView/PersonnelPageModel.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/widgets/BottomSheetChildrensWidget.dart';
import 'package:task_manager/widgets/TopBar.dart';
import '../Utilities/Resources.dart';



class PersonnelPage extends StatelessWidget {
  
  //  List<AppUser> workerListMap  ;//{"Homer" :AppUser(displayName: 'flenn',email: 'osjfvhng3@gmail.com'), "Nobody" : AppUser(displayName: 'Anotherflenn',email: 'enova@gmail.com')   };//Map();

  bool childCarde= false;


  @override
  Widget build(BuildContext context) {
    return BaseView<PersonnelPageModel>(
        onModelReady: (model) {
          model.getSubordinates();
        } ,
        builder: (context, model, child) {
          return Scaffold(
            appBar: TopBar(
              buttonHeroTag: string.personnel,
              child: kBackBtn,
              onPressed: () {
                  kbackBtn(context);
                  childCarde=false;
              },
              title: string.personnel,
            ),
            body: model.state == ViewState.Busy
                ? kBuzyPage(color: Theme.of(context).primaryColor)
                : model.workersListMap.length == 0
                    ? Center(
                        child: Text('Aucun subordonn√© √† votre disposition.',
                            style: ktitleStyle.copyWith(fontSize: 20)),
                      )
                    : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 9 / 9,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 3,
                        ),
                        itemCount: model.workersListMap.length,
                        itemBuilder: (context, index) {
                          return Container(
                            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                            child: ChildrenGridViewCard(
                              user: model.workersListMap[index],
                              onTap: () {
                                
                                //   kbackBtn(context);
                                // childCard!=true;
                                // kbackBtn(context);
                                  // log(childCarde.toString());
                                if(childCarde){
                                  kbackBtn(context);
                                  childCarde=!childCarde;
                                }
                                childCarde=!childCarde;

                                if (model.workersListMap[index].displayName != '')
                                  showBottomSheet(
                                    elevation: 10,
                                    context: context,
                                    builder: (context) =>
                                        BottomSheetChildrensWidget(
                                      user: model.workersListMap[index],
                                    ),
                                  );
                              },
                              
                            ),
                          );
                        }),
          );
        });
  }
}
