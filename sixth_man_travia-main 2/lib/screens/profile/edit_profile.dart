import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/services/firestore.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/custom_text_field.dart'; // your customTextField

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  RxString profileImageUrl = ''.obs; // Firebase URL or local asset

  @override
  void onInit() {
    // Load current user details
    nameController.text = currentUser.name;
    emailController.text = currentUser.email;
    profileImageUrl.value = currentUser.profileImg;
    super.onInit();
  }

  Future<void> updateProfile() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      EasyLoading.showInfo('Please fill all fields');
      return;
    }

    EasyLoading.show();

    currentUser.name = nameController.text;
    currentUser.email = emailController.text;

    await Get.find<FirestoreServices>().updateUser(currentUser);

    EasyLoading.dismiss();
    EasyLoading.showSuccess("Profile Updated");
    Get.back();
  }

  Future<void> pickProfileImage() async {
    File? image =
        await Get.find<AuthController>().getFile("Select Profile Picture", 1);
    if (image != null) {
      profileImageUrl.value = await uploadPic("profile", image);
      currentUser.profileImg = profileImageUrl.value;
    }
  }
}

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadPic(String folder, File image) async {
  String link = "";
  try {
    if (image.path == "") return link;
    EasyLoading.show(status: 'Uploading...');
    Reference ref = storage.ref().child("$folder/${DateTime.now().toString()}");
    UploadTask uploadTask = ref.putData(
      await image.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    var res = await uploadTask;
    link = await res.ref.getDownloadURL();
    EasyLoading.dismiss();
  } catch (e) {
    debugPrint("UploadPic error: $e");
    EasyLoading.showInfo("Upload failed: $e");
  }
  return link;
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),

                  /// Back + Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.arrow_back,
                              color: Color(0xFFFF6A00))),
                      text_widget("Edit Profile",
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                      const Icon(Icons.arrow_back, color: Colors.transparent),
                    ],
                  ),

                  SizedBox(height: 5.h),

                  /// Avatar + Camera
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Obx(() => Container(
                              width: 26.w,
                              height: 26.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFFFF6A00), width: 2),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    controller.profileImageUrl.value.isNotEmpty
                                        ? NetworkImage(
                                            controller.profileImageUrl.value)
                                        : const AssetImage(
                                                "assets/images/player-2.png")
                                            as ImageProvider,
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          right: -4,
                          child: GestureDetector(
                            onTap: controller.pickProfileImage,
                            child: Container(
                              padding: EdgeInsets.all(1.1.h),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6A00),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt,
                                  size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 6.h),

                  text_widget("Name",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E1E1E)),
                  customTextField(
                      hint: "Write here",
                      controller: controller.nameController),

                  SizedBox(height: 1.5.h),

                  text_widget("Email",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E1E1E)),
                  customTextField(
                    hint: "Write here",
                    enabled: false,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 5.h),

                  /// Save Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: controller.updateProfile,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 1.6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6A00),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: text_widget(
                          "Save",
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
