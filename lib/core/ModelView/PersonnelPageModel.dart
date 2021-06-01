

import 'package:task_manager/core/enums/ViewState.dart';
import 'package:task_manager/core/services/ProfileServices.dart';
import 'package:task_manager/core/services/StorageService.dart';

import '../../locator.dart';
import 'BaseModel.dart';
import '../models/User.dart';



class PersonnelPageModel extends BaseModel {
  PersonnelPageModel();

  ProfileServices _profileServices = locator<ProfileServices>();
  AppUser _currentUser = AppUser();

  // Map<String, AppUser> workerListMap = {"Homer" :AppUser(displayName: 'flenn',email: 'osjfvhng3@gmail.com'), "Nobody" : AppUser(displayName: 'Anotherflenn',email: 'enova@gmail.com')   };//Map();

  StorageServices _storageServices = locator<StorageServices>();

  // Map<String, DocumentSnapshot> get studentsSnapshot =>
  //     _storageServices.studentsDocumentSnapshots;

  // Map<String, DocumentSnapshot> get teachersSnapshot =>
  //     _storageServices.teachersDocumentSnapshots;

  Map<String, AppUser> get workersListMap => _storageServices.workersListMap;

  // Map<String, AppUser> get teachersListMap => _storageServices.teachersListMap;

  // Map<String, List<AppUser>> get studentsParentListMap =>
  //     _storageServices.studentsParentListMap;

  AppUser _selectedWorker = AppUser();

  AppUser get selectedChild => _selectedWorker;

  set selectedChild(AppUser newAppUser) {
    _selectedWorker = newAppUser;
    notifyListeners();
  }

  getSubordinates() async {
    setState(ViewState.Busy);
    await _storageServices.getChildrens();
    setState(ViewState.Idle);
  }

  // getChildrens() {
  //   return workerListMap;
  // }

  // getAllWorkers({String standard = '', String division = ''}) async {
  //   setState(ViewState.Busy);
  //   await _storageServices.getStudents(standard: standard, division: division);
  //   setState(ViewState.Idle);
  // }

  // getSingleStudentData(DocumentSnapshot documentSnapshot) async {
  //   // setState(ViewState.Busy);
  //   AppUser user = await _storageServices.getUser(documentSnapshot);
  //   _storageServices.studentListMap.putIfAbsent(documentSnapshot.id, () => user);
  //   // await _storageServices.getParents(documentSnapshot);
  //   notifyListeners();
  //   // setState(ViewState.Idle);
  // }

  // getParents(DocumentSnapshot documentSnapshot) async {
  //   setState(ViewState.Busy);
  //   print('Parent Data Fetching Started');
  //   await _storageServices.getParents(documentSnapshot);
  //   setState(ViewState.Idle);
  //   print('Parent Data Fetched');
  // }

  // getAllTeachers({String standard = '', String division = ''}) async {
  //   setState(ViewState.Busy);
  //   teachersListMap.clear();
  //   teachersSnapshot.clear();
  //   await _storageServices.getTeachers(division: division, standard: standard);
  //   setState(ViewState.Idle);
  // }

  // Future<AppUser> getSingleTeacherData(
  //     DocumentSnapshot documentSnapshot) async {
  //   // setState(ViewState.Busy);
  //   AppUser user = await _storageServices.getUser(documentSnapshot);
  //   _storageServices.teachersListMap.putIfAbsent(documentSnapshot.id, () => user);
  //   await _storageServices.getParents(documentSnapshot);
  //   notifyListeners();
  //   return user;
  //   // setState(ViewState.Idle);
  // }

  // onRefereshStudent({String standard, String division}) async {
  //   _storageServices.studentsDocumentSnapshots.clear();
  //   await getAllStudent(standard: standard, division: division);
  // }
}
