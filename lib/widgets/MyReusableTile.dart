// import 'package:ourESchool/UI/Utility/constants.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/services/AnnouncementServices.dart';

import '../locator.dart';

//import 'package:task_manager/Utilities/constants.dart';

class MyReusableTile extends StatefulWidget {
  Widget children;

  MyReusableTile({Key key, this.tittle, this.status, this.icon,this.onClick,this.coloring,this.TYPE,this.id,this.disponible,this.children}) : super(key: key);

  _CreateReusableTile createState() => _CreateReusableTile(this.tittle, this.status, this.icon , this.onClick,this.coloring,this.disponible,this.id,this.TYPE,this.children);  
  final Text tittle; 
  final TextSpan status;
  // final Widget child;
  final Icon icon;
  Function onClick = (){};
  String TYPE = "";

  String id="";

  bool disponible=false;
  Color coloring = Colors.grey.withOpacity(0.5);

}

class _CreateReusableTile extends State<StatefulWidget> {
  var icon;

  TextSpan status;
Widget children;
  var tittle;

  var coloring;

  var onClick = (){};

  String TYPE = "";

  String id="";

  bool disponible=false;

  
  _CreateReusableTile(this.tittle, this.status, this.icon,onClicks,this.coloring, this.disponible, this.id, this.TYPE,this.children){
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
                text: status
              ) ,
            
            // widget<>[ Text('Status :',style: TextStyle(color: Colors.grey.withOpacity(0.5)) ),Text('Active') ],
            
            //shape: kRoundedButtonShape,
            trailing: 
            TYPE!="Task"?Badge(
              child : icon
            ):
            (Column(children : 
              [Switch(
              value: disponible,
              onChanged: (value){
                setState((){
                  disponible=value;
                  log(disponible.toString());
                  log(id);
                  
                  (disponible)?locator<AnnouncementServices>().modifierStatusDeTache(id,"encours"):locator<AnnouncementServices>().modifierStatusDeTache(id,"pause");
                  status.children[1]=TextSpan(
                    text : "",
                  );
                  setState(() {
                    
                  });
                });
              },
              activeTrackColor: Colors.lightGreenAccent, 
              activeColor: Colors.green,
            ),]
            )
            
            ),
            
            

            
            // minVerticalPadding: 5,
            // tileColor: Colors.green,
            horizontalTitleGap: 5,
            onTap: (){ setState(() {
              
              // coloring=coloring==Colors.red.withOpacity(0.5)?Colors.green.withOpacity(0.5):Colors.red.withOpacity(0.5);
            });} ,
            
            
            
          ),
          //color: Colors.yellow,
          // border
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all( Radius.circular(25) ),
            color: coloring,
            
            ),
        
        ),
      padding: EdgeInsets.all(5.0),
    );
  }


}
