




import 'package:flutter/material.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/core/models/User.dart';

class ChildrenGridViewCard extends StatelessWidget {
  final AppUser user;
  final Function onTap;

  ChildrenGridViewCard({
    this.onTap,
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool registerd = user.firebaseUuid == '' ? false : true;
    return SafeArea(
      // constraints: BoxConstraints(maxHeight: 100, maxWidth: 100),
      child: InkWell(
        enableFeedback: true,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            elevation: 5,
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: user.DisplayName,
                  transitionOnUserGestures: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                      
                      //image: DecorationImage(
                      //   image: Icon(Icons.zoom_in),
                      //   fit: BoxFit.scaleDown,
                      // ),
                    ),
                      child: new LayoutBuilder(builder: (context, constraint) {
                         return new Icon(user.sex=="Female"?Icons.female_rounded: Icons.person_rounded ,size: constraint.biggest.height);
                         }),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: new BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          user.displayName,
                          // registerd ? user.displayName : "Not Registered Yet",
                          // textAlign: TextAlign.center,
                          style: ktitleStyle.copyWith(color: Colors.white)
                        ),
                        Text(
                          user.disponible?"Disponible":"Indisponible",
                          // registerd
                          //     ? user.standard + '-' + user.division
                          //     : 
                          textAlign: TextAlign.center,
                          style: ksubtitleStyle.copyWith(color: user.disponible?Colors.greenAccent.withOpacity(0.5):Colors.redAccent.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ImageProvider<dynamic> setImage(AppUser user) {
  //   if (user.photoUrl.contains('https')) {
  //     return NetworkImage(user.photoUrl);
  //   } else {
  //     return AssetImage(assetsString.student_welcome);
  //   }
  // }
}
