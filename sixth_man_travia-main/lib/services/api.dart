import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyResponse {
  bool success;
  dynamic data;
  MyResponse({this.success = false, this.data});
}

class FirestoreApi {
  static final FirebaseFirestore firebaseRef = FirebaseFirestore.instance;

  static init() {
    firebaseRef.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  Future<MyResponse> postANode(
      {required String path, required Map<String, dynamic> data}) async {
    MyResponse response = MyResponse();
    try {
      await firebaseRef.doc(path).set(data).then((value) {
        response.success = true;
      });
    } catch (e) {
      log("exception while adding Node data: ${e.toString()}");
    }
    return response;
  }

  Future<bool> checkANode({required String path}) async {
    try {
      final event = await firebaseRef.doc(path).get();
      if (event.exists) {
        return true;
      }
    } catch (e) {
      log("exception while checking Node data: ${e.toString()}");
    }
    return false;
  }

  Future<bool> deleteANode({required String path}) async {
    try {
      await firebaseRef.doc(path).delete();
      return true;
    } catch (e) {
      log("exception while adding Node data: ${e.toString()}");
    }
    return false;
  }

  Future<MyResponse> updateANode(
      {required String path, required Map<String, Object?> data}) async {
    MyResponse response = MyResponse();
    try {
      await firebaseRef
          .doc(path)
          .set(data, SetOptions(merge: true))
          .then((value) {
        response.success = true;
      });
    } catch (e) {
      log("exception while updating Node data: ${e.toString()}");
    }
    return response;
  }

  Future<MyResponse> fetchANode({required String path}) async {
    MyResponse response = MyResponse();
    try {
      final event = await firebaseRef.doc(path).get();
      if (event.exists) {
        response.success = true;
        response.data = event.data();
      } else {
        log("snap shot not exists");
      }
    } catch (e) {
      log("exception while fetching Node data: ${e.toString()}");
    }
    return response;
  }

  fetchCollectionSnapshort({required String path}) {
    return firebaseRef.collection(path).orderBy('userName');
  }

  Future<List<MyResponse>> fetchCollection(
      {required String path, Map<String, dynamic>? filter}) async {
    List<MyResponse> responses = [];
    try {
      QuerySnapshot<Map<String, dynamic>> event;
      if (filter == null || filter.isEmpty) {
        event = await firebaseRef.collection(path).get();
      } else {
        Query<Map<String, dynamic>> query = firebaseRef.collection(path);
        log(filter.toString());
        filter.forEach((key, value) {
          if (key == 'age') {
            if ((value as List).length == 2) {
              query = query.where('age', isGreaterThan: value[0]);
              query = query.where('age', isLessThan: value[1]);
            }
          } else if (key == 'distance') {
          } else if (key == 'searchName') {
            if (value != null && value != "") {
              query = query.where(key,
                  arrayContains: value.toString().toLowerCase());
            }
          } else if (value.runtimeType == String || value.runtimeType == int) {
            if (value != "") {
              if (key == "userName") {
                query = query.where('userType', isEqualTo: 1);
              }
              query = query.where(key, isEqualTo: value);
            }
          }
        });
        event = await query.get();
      }
      if (event.docs.isEmpty) {
        log("collection snap shot not exists");
        return [];
      }
      for (var element in event.docs) {
        MyResponse response = MyResponse();
        if (element.exists) {
          response.success = true;
          response.data = element.data();
          responses.add(response);
        } else {
          response.success = false;
          response.data = {};
          responses.add(response);
        }
      }
    } catch (e) {
      log("exception while fetching Collection data: ${e.toString()}");
    }
    return responses;
  }
}
