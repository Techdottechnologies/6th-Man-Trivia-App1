// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class FireStorageServices {
//   final FirebaseStorage storage = FirebaseStorage.instance;

//   Future<String> uploadPic(String folder, File image) async {
//     String link = "";
//     try {
//       if (image.path.isEmpty) return link;

//       EasyLoading.show();

//       Reference ref = storage.ref().child("$folder/${DateTime.now()}");
//       UploadTask uploadTask = ref.putData(
//         await image.readAsBytes(),
//         SettableMetadata(contentType: 'image/jpeg'),
//       );

//       TaskSnapshot res = await uploadTask;
//       link = await res.ref.getDownloadURL();

//       EasyLoading.dismiss();
//     } catch (e) {
//       log('UploadPic error: $e');
//       EasyLoading.showError(e.toString());
//     }

//     return link;
//   }

//   Future<String> uploadFile(String folder, File image) async {
//     String link = "";
//     try {
//       EasyLoading.show();

//       Reference ref = storage.ref().child("$folder/${DateTime.now()}");
//       UploadTask uploadTask = ref.putData(await image.readAsBytes());

//       TaskSnapshot res = await uploadTask;
//       link = await res.ref.getDownloadURL();

//       EasyLoading.dismiss();
//     } catch (e) {
//       log('UploadFile error: $e');
//       EasyLoading.showError(e.toString());
//     }

//     return link;
//   }
// }
