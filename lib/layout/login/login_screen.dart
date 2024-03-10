import 'package:chat_app/layout/home_Screen.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:chat_app/shared/remote/firebase/firestore_helper.dart';
import 'package:chat_app/shared/reusable_componenets/custom_form_field.dart';
import 'package:chat_app/style/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../shared/dialog_utils.dart';
import 'package:chat_app/model/user.dart' as MyUser ;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static const String route = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          title: Text("Login",
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
                  obscureText: isObscure,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: AppColors.primaryLightColor,
                      )),
                ),
                SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      // TODO
                    },
                    child: Text("Forgot password ?")),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLightColor),
                    onPressed: () {
                      loginWithEmailAndPassword();
                    },
                    child: Text(
                      "LOGIN ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "register");
                    },
                    child: Text("Create My Account")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginWithEmailAndPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      DialogUtils.ShowLoadingDialog(context);
      try {
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideLoadingDialog(context);
        print(credential.user?.uid);
        MyUser.User? user = await FirestoreHelper.GetUser(credential.user!.uid);
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoadingDialog(context);
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          DialogUtils.showDialogMessage(context: context, message: "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          DialogUtils.showDialogMessage(context: context, message:'Wrong password provided for that user.' );
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
