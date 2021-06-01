// import 'package:flutter/material.dart';
// import 'package:ourESchool/UI/Utility/Resources.dart';
// import 'package:ourESchool/UI/Utility/constants.dart';
// import 'package:ourESchool/UI/Widgets/TopBar.dart';




import 'package:flutter/material.dart';
import 'package:task_manager/Utilities/constants.dart';
import 'package:task_manager/widgets/TopBar.dart';
import '../Utilities/Resources.dart';


class ClassementPage extends StatelessWidget {
  const ClassementPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.health_tips,
      ),
      body: Container(),
    );
  }
}