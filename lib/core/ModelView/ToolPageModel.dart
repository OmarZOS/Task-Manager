
import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/services/ProfileServices.dart';
import 'package:task_manager/core/services/ToolServices.dart';

import '../../locator.dart';
import 'BaseModel.dart';

class ToolPageModel extends BaseModel { 
  ToolServices _ToolServices = locator<ToolServices>();

  ToolPageModel();

  List<dynamic> get postSnapshotList => _ToolServices.myTools;
      // _ToolServices.myTasks;

  getTools(String stdDiv_Global) async {
    setState(ViewState.Busy);
    await _ToolServices.getTools(stdDiv_Global);
    setState(ViewState.Idle);
  }

  onRefresh(String stdDiv_Global) async {
    _ToolServices.myTools.clear();
    _ToolServices.myTools = null;
    await getTools(stdDiv_Global);
  }

  @override
  void dispose() {
    // _ToolServices.lastPostSnapshot = null;
    // _ToolServices.postDocumentSnapshots.clear();
    super.dispose();
  }
}
