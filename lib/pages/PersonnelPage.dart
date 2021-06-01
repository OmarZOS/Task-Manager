// import 'package:flutter/material.dart';
// import 'package:ourESchool/UI/Utility/Resources.dart';
// import 'package:ourESchool/UI/Utility/constants.dart';
// import 'package:ourESchool/UI/Widgets/TopBar.dart';




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/ModelView/BaseView.dart';
import 'package:task_manager/core/ModelView/ChildrenGridViewCard.dart';
import 'package:task_manager/core/ModelView/PersonnelPageModel.dart';
import 'package:task_manager/core/enums/UserType.dart';
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/models/ProfilePageModel.dart';
import 'package:task_manager/core/models/User.dart';
import 'package:task_manager/widgets/BottomSheetChildrensWidget.dart';
import 'package:task_manager/widgets/MyReusableTile.dart';
import 'package:task_manager/widgets/TopBar.dart';
import '../Utilities/Resources.dart';



class PersonnelPage extends StatelessWidget {
  
  Map<String, AppUser> workerListMap = {"Homer" :AppUser(displayName: 'flenn',email: 'osjfvhng3@gmail.com'), "Nobody" : AppUser(displayName: 'Anotherflenn',email: 'enova@gmail.com')   };//Map();
  
  @override
  Widget build(BuildContext context) {
    return BaseView<PersonnelPageModel>(
        // onModelReady: (model) => model.getChildrens(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: TopBar(
              buttonHeroTag: string.childrens,
              child: kBackBtn,
              onPressed: () {
                kbackBtn(context);
              },
              title: string.childrens,
            ),
            body: model.state == ViewState.Busy
                ? kBuzyPage(color: Theme.of(context).primaryColor)
                : workerListMap.values.toList().length == 0
                    ? Center(
                        child: Text('Aucun subordonné n\'est disoponible',
                            style: ktitleStyle.copyWith(fontSize: 20)),
                      )
                    : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 9,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: workerListMap.values.toList().length,
                        itemBuilder: (context, index) {
                          return Container(
                            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                            child: ChildrenGridViewCard(
                              user: workerListMap.values.toList()[index],
                              onTap: () {
                                if (workerListMap.values.toList()[index].displayName != '')
                                  showBottomSheet(
                                    elevation: 10,
                                    context: context,
                                    builder: (context) =>
                                        BottomSheetChildrensWidget(
                                      user: workerListMap.values.toList()[index],
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
