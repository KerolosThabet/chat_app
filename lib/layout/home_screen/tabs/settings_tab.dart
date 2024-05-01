import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/provider/auth provider.dart';
import '../../../shared/provider/setting_provider.dart';
import '../../../style/app_colors.dart';
import '../../login/login_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  var SelectedLanguage = "English";
  var SelectedTheme = "Light";
  @override
  Widget build(BuildContext context) {
    SettingProvider SetiingProvider = Provider.of<SettingProvider>(context);
    authProvider provider = Provider.of<authProvider>(context);

    return Stack(children: [
      Container(
        height: 150,
        width: double.infinity,
        color: AppColors.primaryLightColor,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        child:  Text('Settings',style:Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSecondary,)),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Language",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                border: Border.all(color:Theme.of(context).colorScheme.primary,width: 2.5),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  iconEnabledColor:Theme.of(context).colorScheme.primary,
                  isDense: true,


                  hint: Text('$SelectedLanguage',style: TextStyle(color:Theme.of(context).colorScheme.primary),),
                  alignment: Alignment.centerLeft,

                  style: Theme.of(context).textTheme.labelSmall,
                  items: <String>['English', 'Arabic',].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: SelectedLanguage,
                  onChanged: (String? value) {

                  },

                ),
              ),
            ),
            Text(
              "Mode",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
              border: Border.all(color:Theme.of(context).colorScheme.primary,width: 2.5),
            ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  iconEnabledColor: AppColors.primaryLightColor,
                  isDense: true,
                  hint: Text('$SelectedTheme',style: TextStyle(color:Theme.of(context).colorScheme.primary),),
                  alignment: Alignment.centerLeft,
                  style: Theme.of(context).textTheme.labelSmall,

                  items: ['Light', 'Dark',].map((String value)=>DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),)).toList(),
                  value: SelectedTheme,
                  onChanged: (String? value) {
                     SelectedTheme=value!;
                     SelectedTheme=="Light"?SetiingProvider.changeTheme(ThemeMode.light):SetiingProvider.changeTheme(ThemeMode.dark);
                  },



                ),
              ),
            ),

            SizedBox(height: 20,),
            TextButton(
              onPressed: () async {
                await provider.SignOut();
                Navigator.pushReplacementNamed(context, LoginScreen.route);
              },
             child: Text("Log out"))
          ],
        ),
      )
    ]);
  }
}
