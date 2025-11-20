import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/register_screen.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/widget/custom_text_form_field.dart';
import 'package:news_app/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? erroMessage;
 void Login() async {
  if (!mounted) return;
  setState(() {
    erroMessage = null;
    isLoading = true;
  });

  await Future.delayed(Duration(seconds: 2));

  final savedEmail = PreferencesManager().getString("user_email");
  final savedPassword = PreferencesManager().getString("user_password");

  if (!mounted) return;

  // الحساب غير موجود
  if (savedEmail == null || savedPassword == null) {
    setState(() {
      erroMessage = "No account found, please register";
      isLoading = false;
    });
    return;
  }

  // الايميل أو الباسورد غلط
  if (savedEmail != emailController.text.trim() ||
      savedPassword != passwordController.text.trim()) {
    setState(() {
      erroMessage = "Incorrect email or password!";
      isLoading = false;
    });
    return;
  }

  await PreferencesManager().setBool("is_logged_in", true);
  await PreferencesManager().setBool("onboarding_complete", true);

  if (!mounted) return;

  setState(() {
    isLoading = false;
    erroMessage = null;
  });

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => MainScreen()),
  );
}


  @override
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
            key: _key,
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
                      if (_key.currentState?.validate() ?? false) {
                        return Login();
                      }
                    },
                    child:isLoading?CircularProgressIndicator(): Text("Sign In"),
                  ),
                ),
                SizedBox(height: 34),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account ?  "),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
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
