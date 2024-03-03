import 'package:chat_app/layout/home_Screen.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:chat_app/shared/reusable_componenets/custom_form_field.dart';
import 'package:chat_app/style/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  static const String route = "register";

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  bool isConfirmObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/SIGN IN – 1.jpg"),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Create Account",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back !",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " This field can`t be empty";
                      }

                      return null;
                    },
                    label: "Full Name",
                    keyboard: TextInputType.emailAddress),
                CustomFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " This field can`t be empty";
                      }
                      if (!RegExp(Constants.emailRegex).hasMatch(value)) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                    label: "Email",
                    keyboard: TextInputType.emailAddress),
                CustomFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " This field can`t be empty";
                    }
                    if (value.length < 8) {
                      return "password should be at least 8 char";
                    }
                    return null;
                  },
                  label: "Password",
                  keyboard: TextInputType.visiblePassword,
                  obscureText: isConfirmObscure,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmObscure = !isConfirmObscure;
                        });
                      },
                      icon: Icon(
                        isConfirmObscure ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: AppColors.primaryLightColor,
                      )),
                ),
                CustomFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if(value != passwordController.text){
                      return "Don`t Match";
                    }
                  },
                  label: "Confirm Password",
                  keyboard: TextInputType.visiblePassword,
                  obscureText: isConfirmObscure,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmObscure = !isConfirmObscure;
                        });
                      },
                      icon: Icon(
                        isConfirmObscure ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: AppColors.primaryLightColor,
                      )),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLightColor,),
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.pushNamedAndRemoveUntil(context,HomeScreen.route , (route) => false);
                      }
                    },
                    child: Text(
                      "Register ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
