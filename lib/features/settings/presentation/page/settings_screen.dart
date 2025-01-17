import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales/core/language/language_controller.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_appbar.dart';
import 'package:sales/core/utils/custom/p_button.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/login/presentation/Page/login_screen.dart';


class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsScreen> {

  TextStyle headingStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red);

  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;

  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color:CupertinoColors.inactiveGray);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar(context: context,text:AppLocalizations.of(context)!.settings),
      body: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: CupertinoPageScaffold(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: CupertinoColors.extraLightBackgroundGray,
            child: Column(
              children: [
                //Common
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      "Common",
                      style: headingStyleIOS,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  color: CupertinoColors.white,
                  child: Column(
                    children: [
                      InkWell(onTap:(){
                        showLanguageBottomSheet();
                      },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 38,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.language,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 12),
                               PText(title:AppLocalizations.of(context)!.language,size:PSize.large,),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top:2),
                                child: PText(title:AppLocalizations.of(context)!.localeName=='en'?"English":'العربية', size:
                                PSize.large,fontColor:AppColors.lightGrey2,fontWeight:FontWeight.w500,),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                CupertinoIcons.right_chevron,
                                color: CupertinoColors.inactiveGray,
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Account
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      "Account",
                      style: headingStyleIOS,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  color: CupertinoColors.white,
                  child: Column(
                    children: [
                      InkWell(onTap:(){
                        showBottomSheet(value:SharedPrefHelper.sp.getString('empMob')??'');
                      },child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 38,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              SizedBox(width: 12),
                              Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 12),
                              PText(title:AppLocalizations.of(context)!.phone_number,size:PSize.large,),
                              Spacer(),
                              Icon(
                                CupertinoIcons.right_chevron,
                                color: CupertinoColors.inactiveGray,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(onTap:(){
                        showBottomSheet(value:SharedPrefHelper.sp.getString('empEmail')??'');
                      },child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 38,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              SizedBox(width: 12),
                              Icon(
                                Icons.mail,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 12),
                              PText(title:AppLocalizations.of(context)!.email,size:PSize.large,),
                              Spacer(),
                              Icon(
                                CupertinoIcons.right_chevron,
                                color: CupertinoColors.inactiveGray,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(onTap:() {
                        exitApp(context);
                      },child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 38,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              SizedBox(width: 12),
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 12),
                              PText(title:AppLocalizations.of(context)!.sign_out,size:PSize.large,),
                              Spacer(),
                              Icon(
                                CupertinoIcons.right_chevron,
                                color: CupertinoColors.inactiveGray,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Security
              ],
            ),
          ),
        ),
      ),
    );
  }
  showLanguageBottomSheet(){
    showModalBottomSheet(
        context: context,barrierColor:Colors.transparent,
        builder: (context) {
          return Container( decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title:const PText(title:'English',size:PSize.large,),
                  onTap: () async {
                    ref.read(languageProvider.notifier).en();
                   await SharedPrefHelper.sp.setString('lang','en');
                    Navigator.pop(context);
                  },
                ),
                Divider(color:AppColors.lightGrey,),
                ListTile(
                  title:const PText(title:'العربية',size:PSize.large,),
                  onTap: () async {
                    ref.read(languageProvider.notifier).ar();
                    await SharedPrefHelper.sp.setString('lang','ar');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
  showBottomSheet({required String value}){
    showModalBottomSheet(
        context: context,barrierColor:Colors.transparent,
        builder: (context) {
          return Container( decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title:PText(title:value,size:PSize.large,),
                ),
              ],
            ),
          );
        });
  }

  void exitApp(BuildContext context) {
     showDialog(context:context,builder:(context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.quest_title),
        // content: Text('We hate to see you leave...'),
        actions: <Widget>[
          PButton(onPressed:() {
            Navigator.of(context).pop(false);
          },title:AppLocalizations.of(context)!.no,size:PSize.large,style:PStyle.tertiary,fillColor:Colors.white,
          textColor:Colors.black,),

          PButton(onPressed:() async {
            await SharedPrefHelper.sp.setBool('isLogged',false);
            // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const LoginScreen(),
              ),
                  (route) => false,
            );
          },title:AppLocalizations.of(context)!.yes,size:PSize.large,)

        ],
      );
    },);
  }
}