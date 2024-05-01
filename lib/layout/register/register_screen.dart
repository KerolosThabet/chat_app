import 'package:TODO_app/layout/home_screen/home_Screen.dart';
import 'package:TODO_app/model/user.dart';
import 'package:TODO_app/shared/constants.dart';
import 'package:TODO_app/shared/dialog_utils.dart';
import 'package:TODO_app/shared/provider/auth%20provider.dart';
import 'package:TODO_app/shared/remote/firebase/firestore_helper.dart';
import 'package:TODO_app/shared/reusable_componenets/custom_form_field.dart';
import 'package:TODO_app/style/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TODO_app/model/user.dart' as MyUser ;

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
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(
        backgroundColor: AppColors.HomeLightColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryLightColor,
          title: Text("Create Account",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  SizedBox(
                    height: height*.15,
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
                      if (value != passwordController.text) {
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
                          isConfirmObscure ? Icons.visibility_off : Icons
                              .visibility,
                          size: 20,
                          color: AppColors.primaryLightColor,
                        )),
                  ),
              
                  SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLightColor,),
                      onPressed: () {
                        CreateNewUser();
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


  Future<void> CreateNewUser() async {
    authProvider provider = Provider.of<authProvider>(context, listen: false);
    if (formKey.currentState?.validate() ?? false) {
      DialogUtils.ShowLoadingDialog(context);
      try {
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FirestoreHelper.AddUser(
            credential.user!.uid,
            emailController.text,
            fullNameController.text);
        Navigator.pushReplacementNamed(context, HomeScreen.route);
        provider.setUsers(credential.user, MyUser.User(
            id: credential.user!.uid,
            email:  emailController.text,
            fullName: fullNameController.text)
        );
        DialogUtils.hideLoadingDialog(context);
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoadingDialog(context);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          DialogUtils.showDialogMessage(context: context, message: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          DialogUtils.showDialogMessage(context: context, message: 'The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoadingDialog(context);
        print(e);
        DialogUtils.showDialogMessage(context: context, message: e.toString());
      }
    }
  }
}
