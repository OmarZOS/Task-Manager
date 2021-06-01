// import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
//import 'package:task_manager/Utilities/constants.dart';

class MyReusableTile extends StatelessWidget {
  
  final Text tittle; 
  final Text status;
  // final Widget child;
  final Icon icon;


  const MyReusableTile(
      {@required this.tittle,
      @required this.status,
      // @required this.child,
      @required this.icon});
      

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: tittle,
      subtitle: Text('Status :  $status') ,
      
      //shape: kRoundedButtonShape,
      trailing: Badge(
        child : icon
      ),
    );
  }
}
