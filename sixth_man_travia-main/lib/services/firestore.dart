import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/model/user.dart';
import 'package:sixth_man_travia/services/api.dart';

class FirestoreServices {
  final FirestoreApi _instance = FirestoreApi();
  FirebaseFirestore i = FirebaseFirestore.instance;

  registerUser() async {
    await _instance.postANode(
        path: 'userProfile/${currentUser.id}', data: currentUser.toJSON());
  }
  saveCrossWord(Map<String, dynamic> map) async {
    await _instance.postANode(
        path: 'crossword/crossword', data: map);
  }

  updateUser(UserModel user) async {
    await _instance.updateANode(
        path: 'userProfile/${user.id}', data: user.toJSON());
  }

  Future<bool> checkEmailExist(String email) async {
    try {
      List<MyResponse> list = await _instance.fetchCollection(
          path: 'userProfile', filter: {'email': email.toLowerCase()});
      if (list.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<void> deleteUser(String uId) async {
    await _instance.deleteANode(path: 'userProfile/$uId');
  }

  Future<UserModel?> getUser(String uId) async {
    MyResponse response = await _instance.fetchANode(path: 'userProfile/$uId');
    if (response.success) {
      return UserModel.toModel(response.data);
    }
    return null;
  }

  List<String> generateArray(String name, [bool subSearch = false]) {
    name = name.toLowerCase();
    List<String> list = [];
    for (int i = 0; i < name.length; i++) {
      list.add(name.substring(0, i + 1));
    }
    if (subSearch) {
      for (String test in name.split(' ')) {
        for (int i = 0; i < test.length; i++) {
          list.add(test.substring(0, i + 1));
        }
      }
    }
    return list;
  }
}
