import 'package:flutter/material.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/widget/custom_text_form_field.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? erroMessage;
  bool isLoading = false;
  void register() async {
    setState(() {
      erroMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    final saveEmail = PreferencesManager().getString("user_email");
    if (saveEmail != null && saveEmail == emailController.text.trim()) {
      setState(() {
      erroMessage = "User Already Registered";
      isLoading=false;
        
      });
    } else {
      await PreferencesManager().setString("user_email", emailController.text);
      await PreferencesManager().setString(
        "user_password",
        passwordController.text,
      );

      await PreferencesManager().setBool("is_logged_in", true);
      await PreferencesManager().setBool("onboarding_complete", true);
      setState(() {
              isLoading = false;

      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
      );
    }
  }

  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png", height: 45),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome to Newts",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 24),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "mark@gmail.com",
                  title: "Email",
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an email';
                    }

                    final pattern =
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    final regex = RegExp(pattern);

                    return regex.hasMatch(value.trim())
                        ? null
                        : 'Please enter a valid email';
                  },
                ),
                SizedBox(height: 24),
                CustomTextFormField(
                  controller: passwordController,
                  title: "Passward",
                  hintText: "*************",
                  obsecureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                  },
                ),
                SizedBox(height: 24),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  title: "Confirm Passward",
                  hintText: "*************",
                  obsecureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                  },
                ),
                if (erroMessage != null)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      erroMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {
                      if (_form.currentState?.validate() ?? false) {
                        return register();
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text("Sign Up"),
                  ),
                ),
                SizedBox(height: 34),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account ?  "),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
