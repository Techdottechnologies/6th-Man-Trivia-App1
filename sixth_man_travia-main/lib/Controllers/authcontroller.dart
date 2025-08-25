import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/model/user.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import 'package:sixth_man_travia/screens/auth/verify.dart';
import 'package:sixth_man_travia/services/auth.dart';
import 'package:sixth_man_travia/services/firestore.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      await GoogleSignIn().signOut(); // Optional: Sign out from Google too

      // Clear user session data
      profileImageUrl.value = '';
      image = null;
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      usernameController.clear();

      // Navigate to login screen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      EasyLoading.showError("Logout failed: $e");
      debugPrint("Logout error: $e");
    }
  }

  Future<bool> sendEmailVarification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      print("Check your Email");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkEmailVarification() async {
    try {
      await FirebaseAuth.instance.currentUser!.reload();
      return FirebaseAuth.instance.currentUser!.emailVerified;
    } catch (e) {
      return false;
    }
  }

  var isPasswordHidden = true.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var usernameError = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<File?> getFile(
    String title,
    int type,
  ) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(dialogTitle: title, type: FileType.values[type]);
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  String? localImage;
  File? file;
  bool validateFields() {
    bool isValid = true;

    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else {
      passwordError.value = '';
    }

    return isValid;
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController careIdController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController offerController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // Other Variables
  File? profileImage;
  String profileImagePath = '';
  PageController pageController = PageController(initialPage: 0);
  PageController secondaryPageController = PageController(initialPage: 0);
  DateTime selectedDate = DateTime(2020);
  bool termsAccepted = false;
  int currentPageIndex = 0;
  int currentTabIndex = 0;
  String countryName = '';
  String countryFlag = '';
  File? uploadedFile;
  // FilePickerResult? filePickerResult;
  bool isUser = false;
  bool isPartner = false;
  bool isFocused = false;
  String cvPath = '';
  RxString profileImageUrl = ''.obs; // Firebase URL or local asset
  Future<String> uploadPic(String folder, File image) async {
    String link = "";
    try {
      if (image.path == "") return link;
      EasyLoading.show(status: 'Uploading...');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("$folder/${DateTime.now().toString()}");
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

  File? image;
  Future<void> pickProfileImage() async {
    final picked = await getFile("Select Profile Picture", 1);
    if (picked != null) {
      image = picked;
      profileImageUrl.value = picked.path; // local path used for preview
      update();
    }
  }

  Future<void> signUp() async {
    if (emailController.text.isEmpty) {
      EasyLoading.showInfo('Enter Email');
      return;
    }

    bool emailExists = await Get.find<FirestoreServices>()
        .checkEmailExist(emailController.text);
    if (emailExists) {
      EasyLoading.showInfo('Email already exists');
      return;
    }

    if (!emailController.text.isEmail) {
      EasyLoading.showInfo('Enter a valid email address');
      return;
    }
    if (image == null || profileImageUrl.value.isEmpty) {
      EasyLoading.showInfo('Profile image is required');
      return;
    }
    if (usernameController.text.isEmpty) {
      EasyLoading.showInfo('Enter a valid name');
      return;
    }
    // if (nameController.text.isEmpty) {

    if (!validatePassword(passwordController.text)) {
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      EasyLoading.showInfo('Passwords do not match');
      return;
    }

    currentUser.email = emailController.text;
    currentUser.initialPassword = passwordController.text;
    currentUser.name = usernameController.text;
    // currentUser.profileImg =
    //     await Get.find<FireStorageServices>().uploadPic('profile', file!);
    EasyLoading.show();
    String str = await Get.find<AuthServices>().emailSignUp();

    EasyLoading.dismiss();
    if (str == "") {
      if (image != null) {
        profileImageUrl.value = await uploadPic("profile", image!);
        currentUser.profileImg = profileImageUrl.value;
      }
      await Get.find<FirestoreServices>().registerUser();
      currentUser =
          await Get.find<FirestoreServices>().getUser(currentUser.id) ??
              UserModel();

      // NotificationsService().scheduleWelcomeNotification();
      Get.offAll(const EmailVerify());
    } else {
      EasyLoading.showInfo(str);
    }

    EasyLoading.dismiss();
    print(currentUser.id);
  }

  bool validateFieldsSignUp() {
    bool isValid = true;

    if (usernameController.text.trim().isEmpty) {
      usernameError.value = 'Username is required';
      isValid = false;
    } else {
      usernameError.value = '';
    }

    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else {
      passwordError.value = '';
    }

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    } else {
      confirmPasswordError.value = '';
    }

    return isValid;
  }

  bool validatePassword(String password) {
    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasSpecialChar = RegExp(r'[@#\$%\^&\*\!\?]');
    final hasMinLength = password.length >= 8;

    if (!hasMinLength) {
      EasyLoading.showInfo("Password must be at least 8 characters long");
      return false;
    }
    if (!hasUppercase.hasMatch(password)) {
      EasyLoading.showInfo(
          "Password must contain at least one uppercase letter");
      return false;
    }
    if (!hasLowercase.hasMatch(password)) {
      EasyLoading.showInfo(
          "Password must contain at least one lowercase letter");
      return false;
    }
    if (!hasSpecialChar.hasMatch(password)) {
      EasyLoading.showInfo(
          "Password must contain at least one special character like @, #, etc.");
      return false;
    }
    return true;
  }

  Future<void> loginUser() async {
    if (emailController.text.isEmpty) {
      EasyLoading.showInfo('Enter Email Address');
      return;
    }
    if (!emailController.text.isEmail) {
      EasyLoading.showInfo('Enter Valid Email');
      return;
    }
    if (passwordController.text.isEmpty) {
      EasyLoading.showInfo('Enter Password');
      return;
    }
    EasyLoading.show();
    String response = await Get.find<AuthServices>()
        .emailSignIn(emailController.text, passwordController.text);
    if (response.isEmpty) {
      currentUser =
          await Get.put(FirestoreServices()).getUser(currentUser.id) ??
              UserModel();
      await Get.find<AuthController>().checkEmailVarification()
          ? Get.off(const CustomMainBottomNav(currentIndex: 0))
          : Get.off(const CustomMainBottomNav(currentIndex: 0));
      EasyLoading.dismiss();
    } else {
      EasyLoading.showError("Wrong Credentials");
    }
  }

  Future<bool> sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      }
      await user.sendEmailVerification();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      }
      await user.reload();
      return user.emailVerified;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      EasyLoading.showInfo('Enter Email Address');
      return;
    }
    if (!emailController.text.isEmail) {
      EasyLoading.showInfo('Enter Valid Email');
      return;
    }
    EasyLoading.show();
    String response =
        await Get.find<AuthServices>().forgetPassword(emailController.text);
    if (response.isEmpty) {
      EasyLoading.dismiss();
      EasyLoading.showInfo('Check Your Email');
      Get.back();
    } else {
      EasyLoading.showError(response);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show(status: 'Signing in...');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        EasyLoading.dismiss();
        return; // User canceled
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        // Check if user already exists in Firestore
        bool exists =
            await Get.find<FirestoreServices>().checkEmailExist(user.email!);
        if (!exists) {
          // New user → create Firestore record
          currentUser.id = user.uid;
          currentUser.email = user.email!;
          currentUser.name = user.displayName ?? '';
          currentUser.profileImg = user.photoURL ?? '';
          currentUser.initialPassword = 'Signed in with Google';
          await Get.find<FirestoreServices>().registerUser();
        }

        currentUser = await Get.find<FirestoreServices>().getUser(user.uid) ??
            UserModel();

        Get.offAll(const CustomMainBottomNav(currentIndex: 0));
      }

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Google Sign-In failed");
      print("Google Sign-In error: $e");
    }
  }
}
