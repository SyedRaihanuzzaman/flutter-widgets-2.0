import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextformfieldController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool hasAttemptedSubmit = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!GetUtils.isEmail(value)) {
      return "Email is not valid";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  Future<void> submitForm() async {
    hasAttemptedSubmit.value = true;

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      debugPrint("Login Successful");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
