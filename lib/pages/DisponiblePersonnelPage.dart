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



class DisponiblePersonnelPage extends StatelessWidget {
  
  bool emptyList=true;

  @override
  Widget build(BuildContext context) {
    return BaseView<PersonnelPageModel>(
        onModelReady: (model) {
          model.getSubordinates();
          for (var item in model.workersListMap) {
            if(item.disponible)
              emptyList=false;
          }
        
        } ,
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
                : emptyList
                    ? Center(
                        child: Text('Aucun subordonné n\'est disoponible',
                            style: ktitleStyle.copyWith(fontSize: 20)),
                      )
                    : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 9 / 9,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: model.workersListMap.length,
                        itemBuilder: (context, index) {
                          return (!model.workersListMap[index].disponible)  ? Container():Container(
                            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                            child: ChildrenGridViewCard(
                              user: model.workersListMap[index],
                              onTap: () {
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
