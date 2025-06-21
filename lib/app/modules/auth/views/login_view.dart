import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:round_tech_square/app/core/utils/enums.dart';
import 'package:round_tech_square/app/widgets/custom_background.dart';
import 'package:round_tech_square/app/widgets/custom_button.dart';
import 'package:round_tech_square/app/widgets/custom_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  child: Icon(Icons.login),
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Email address',
                  prefixIcon: Icons.email,
                  controller: controller.emailController,
                ),
                const SizedBox(height: 20),
                Obx(() => CustomTextField(
                      hintText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: !controller.isPasswordVisible,
                      suffixIcon:controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      onSuffixTap: () {
                        controller.togglePasswordVisibility();
                      },
                      controller: controller.passwordController,
                    )),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                 
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => controller.loginStatus == PostApiStatus.loading
                    ? CircularProgressIndicator()
                    : CustomGradientButton(
                        text: 'Sign In',
                        onPressed: () {
                          controller.login();
                        },
                      )),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}