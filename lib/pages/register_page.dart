import 'package:flutter/material.dart';
import 'package:talk/services/auth/auth_service.dart';
import 'package:talk/components/my__textfield.dart';
import 'package:talk/components/my_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key,required this.onTap});

  // Register User 
  void register(BuildContext context) {
    AuthService authService = AuthService();

    // password Confirm match -> register user
    if (_passwordController.text == _confirmPasswordController.text){
      try{
        authService.signUpWithEmailAndPassword(_emailController.text, _passwordController.text,);
      }catch (e){
        showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text(e.toString()),
      ));
      } 
    }
    // password confirm not match -> user not register
    else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text("Password does't match"),
      ));
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
              "Let's creatte a account for you",
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
            const SizedBox(height: 10),

            // cponfirm password
            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 25),

            // login Btn
            MyButton(text: "Register", onTap: ()=>register(context)),
            const SizedBox(height: 25),

            //register now Btn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Allready have an account? ",
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
