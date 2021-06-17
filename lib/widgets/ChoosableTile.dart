// import 'package:ourESchool/UI/Utility/constants.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

//import 'package:task_manager/Utilities/constants.dart';

class ChoosableTile extends StatefulWidget {
  ChoosableTile({Key key, this.tittle, this.status, this.icon,this.onClick,this.coloring}) : super(key: key);

  _CreateChoosableTile createState() => _CreateChoosableTile(this.tittle, this.status, this.icon , this.onClick,this.coloring);  
  final Text tittle; 
  final TextSpan status;
  // final Widget child;
  final Icon icon;
  var onClick ;
  Color coloring = Colors.grey.withOpacity(0.5);

}

class _CreateChoosableTile extends State<StatefulWidget> {
  var icons;

  var status;

  var tittle;

  var colorings;

  bool Function() onClick = (){};

  
  _CreateChoosableTile(this.tittle, this.status, this.icons,onClicks,this.colorings){
    this.onClick=onClicks;
  }
  

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child : 
        Container(
          
          child : ListTile(
            title: Text(tittle.data,
                        style: TextStyle(color: Colors.red,fontSize: 25),
                        ),
            subtitle:RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Status :', style: TextStyle(color: Colors.grey.withOpacity(0.9))),
                    TextSpan(text: status.text),
                  ],
                ),
              ) ,
            
            // widget<>[ Text('Status :',style: TextStyle(color: Colors.grey.withOpacity(0.5)) ),Text('Active') ],
            
            //shape: kRoundedButtonShape,
            trailing: icons, 
            // Badge(
            //   child : icons
            // ),
            // minVerticalPadding: 5,
            // tileColor: Colors.green,
            horizontalTitleGap: 5,
            onTap: (){
              log(colorings.toString());
              setState(() {
              this.colorings=colorings==Colors.blueGrey.withOpacity(0.5)?Colors.teal.withOpacity(0.5):Colors.blueGrey.withOpacity(0.5);
              // this.icons= (icons==Icon(Icons.person_add))?Icon(Icons.check_box_rounded):Icon(Icons.person_add);
                onClick();
              
              });
                
            }
            
            
            
          ),
          //color: Colors.yellow,
          // border
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all( Radius.circular(25) ),
            color: colorings,
            
            ),
        
        ),
      padding: EdgeInsets.all(5.0),
    );
  }


}
