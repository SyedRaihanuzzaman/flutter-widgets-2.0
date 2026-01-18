import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/textformfield_controller.dart';

class TextformfieldView extends GetView<TextformfieldController> {
  const TextformfieldView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Form Field'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),

          /// FORM MUST BE REACTIVE
          child: Obx(
                () => Form(
              key: controller.formKey,
              autovalidateMode: controller.hasAttemptedSubmit.value
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome to Login Page"),
                  const SizedBox(height: 20),

                  /// EMAIL FIELD
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: TextformfieldController.validateEmail,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// PASSWORD FIELD
                  Obx(
                        () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.isPasswordHidden.value,
                      validator: TextformfieldController.validatePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: controller.isPasswordHidden.value
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        controller.submitForm();
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                          () => FilledButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.submitForm,
                        child: controller.isLoading.value
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Login"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );


  }
}
