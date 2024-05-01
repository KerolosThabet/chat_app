import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class DialogUtils {
  static void ShowLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(
                    strokeWidth: 10, strokeAlign: 2),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context){
     Navigator.pop(context);
  }

  static void showDialogMessage({required BuildContext context,required message}){

    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
            child: Center(
              child:Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message,style: TextStyle( fontSize: 20)),
                    SizedBox(height: 10,),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child:Text("ok",style: TextStyle(fontSize: 25,color: Colors.white,
                        backgroundColor: AppColors.primaryLightColor,
                        fontWeight: FontWeight.bold),) )
                  ],
                ),
              ),
            ),

        );
      },
    );
  }
}
