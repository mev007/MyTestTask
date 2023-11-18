import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_developer_test_task/models/user_model.dart';
import 'package:mobile_developer_test_task/services/user_api.dart';

class HomeController extends GetxController {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();

  var isButtonEnabled = false.obs;
  var isLoading = false.obs;
  String resultLoaded = '';

  void checkButtonAvailability() {
    isButtonEnabled.value = nameCtrl.text.trim().isNotEmpty &&
        EmailValidator.validate(emailCtrl.text.trim()) &&
        messageCtrl.text.trim().isNotEmpty;
  }

  Future<void> sendUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    final user = UserModel(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      message: messageCtrl.text.trim(),
    );
    final result = await UserApi().sendUser(user);
    isLoading.value = false;
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      margin: const EdgeInsets.all(20),
      titleText: Text(
        result
            ? "User data has been successfully uploaded to the server"
            : "Error uploading user data to the server",
        style: const TextStyle(color: Colors.white),
      ),
      messageText: const SizedBox.shrink(),
      backgroundColor: result ? Colors.green : Colors.red,
      colorText: Colors.white,
      borderRadius: 10,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onInit() {
    nameCtrl.addListener(() => checkButtonAvailability());
    emailCtrl.addListener(() => checkButtonAvailability());
    messageCtrl.addListener(() => checkButtonAvailability());
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    messageCtrl.dispose();
    super.onClose();
  }
}
