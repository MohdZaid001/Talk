import 'package:flutter/material.dart';
import 'package:talk/components/my_dialog.dart';
import 'package:talk/services/auth/auth_service.dart';
import 'package:talk/components/my__textfield.dart';
import 'package:talk/components/my_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;
  
  LoginPage({super.key, required this.onTap});

  Future<void> login(BuildContext context) async{
    AuthService authService = AuthService();
    try{
      await authService.signInWithEamailAndPassword(_emailController.text, _passwordController.text);
    }on Exception catch (e){
      // check user is still on login page while waiting, if not then dont show dialog
      if(!context.mounted) return;
       showAppDialog(
          context: context,
          title: "Login failed",
          message: e.toString(),
          icon: Icons.error_outline_rounded,
          color: Colors.red,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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

            // welcome back message
            Text(
              "Welcome back, She masseged you!!!",
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
            ),
            const SizedBox(height: 10),

            // password text field
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 25),

            // login Btn
            MyButton(text: "Login", onTap: ()=>login(context)),
            const SizedBox(height: 25),

            //register now Btn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register Now",
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
