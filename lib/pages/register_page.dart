import 'package:flutter/material.dart';
import 'package:talk/components/my_dialog.dart';
import 'package:talk/services/auth/auth_service.dart';
import 'package:talk/components/my__textfield.dart';
import 'package:talk/components/my_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});


  // Register User
  Future<void> register(BuildContext context) async {
    AuthService authService = AuthService();

    // password Confirm match -> register user
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await authService.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        // User is still on register page while waiting if not then dont show dialog
        if (!context.mounted) return;

        showAppDialog(
          context: context,
          title: "Registration failed",
          message: e.toString(),
          icon: Icons.error_outline_rounded,
          color: Colors.red,
        );
      }
    }
    // password confirm not match
    else {
      showAppDialog(
        context: context,
        title: "Passwords don't match",
        message: "Please enter the same password in both fields.",
        icon: Icons.lock_outline_rounded,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            // welcome message
            Text(
              "Let's create a account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // email text field
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 10),

            // password text field
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
              prefixIcon: Icons.lock_outlined,
            ),
            const SizedBox(height: 10),

            // confirm password
            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPasswordController,
              prefixIcon: Icons.lock_outlined,
            ),

            // const SizedBox(height: 2),
            // Text(
            //   "This is error message",
            //   textAlign: TextAlign.left,
            //   style: TextStyle(color: Colors.red, fontSize: 13),
            // ),
            const SizedBox(height: 25),

            // Register Btn
            MyButton(text: "Register", onTap: () => register(context)),
            const SizedBox(height: 25),

            // already have account then login Btn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
