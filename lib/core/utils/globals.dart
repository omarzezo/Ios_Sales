import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_button.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Set<Map<String, String>> getHomeItems({required BuildContext context}){
  return  {
    {
      'title': AppLocalizations.of(context)!.total_sales,
      'image': 'assets/card.gif',
      'color': '',
    },
    {
      'title': AppLocalizations.of(context)!.settings,
      'image': 'assets/setting.gif',
      'color': '',
    },
  };
}


final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
const int PRODUCTS_PER_PAGE = 20;
const String USER_LOCAL_STORAGE_KEY = 'user';
const String APP_THEME_STORAGE_KEY = 'AppTheme';

enum PSize {
  veryVeryLarge,
  veryLarge,
  large,
  medium,
  small,
  caption
}

enum PStyle {
  primary,
  secondary,
  tertiary,
  link
}

showLoader({bool canInteract = true}){
  EasyLoading.instance.userInteractions = canInteract;
  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
  if(EasyLoading.isShow){
    EasyLoading.dismiss();
    EasyLoading.show();
  }else{
    EasyLoading.show();
  }
}

dismissLoader(){
  if(EasyLoading.isShow){
    EasyLoading.dismiss();
  }
}


Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // var begin = Offset(0.0, 1.0);
//         var begin = Offset(1.0, 1.0); //animation From bottmo Curve
      var begin = Offset(1.0, 0.0); //animation From left like android
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },

    // animation from Bottom
//      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        return child;
//      },

//      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;
//
//        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//        return SlideTransition(
//          position: animation.drive(tween),
//          child: child,
//        );
//      },
  );
}
String getDoubleDigit(String value) {
  if (value.length >= 2) return value;
  return "0" + value;
}

String getFormattedDate(DateTime day) {
  String formattedDate = getDoubleDigit(day.year.toString()) +
      "-" +
      getDoubleDigit(day.month.toString()) +
      "-" +
      getDoubleDigit(day.day.toString());
  return formattedDate;
}

showMessage(BuildContext context,String msg,{bool isFail = true,int time=500}){
  var snackBar = SnackBar(content:Center(child: PText(title:msg,size:PSize.large,fontColor:AppColors.white,)),
  backgroundColor:isFail?Colors.red:Colors.green,duration:Duration(milliseconds:time),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


void actionNumberDialog(BuildContext context,String actionNumber) {
  showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (contextD, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: SizedBox(
              child: AlertDialog(scrollable:true,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title:PText(title:AppLocalizations.of(context)!.action_number,size:PSize.veryLarge,
                  fontColor:AppColors.primary,),
                content: Center(child:Column(mainAxisSize:MainAxisSize.min,children: [
                  SelectableText(actionNumber,style:TextStyle(fontSize:16,),
                    cursorColor:AppColors.primary,
                    onTap: () {
                      // you can show toast to the user, like "Copied"
                    },
                  ),
                  // PText(title:actionNumber,size:PSize.large,fontColor:AppColors.black,
                  // fontWeight:FontWeight.w400,),
                  Padding(
                    padding: const EdgeInsets.only(top:14),
                    child: PButton(onPressed:() {
                      Navigator.pop(contextD);
                      // showMessage(context,AppLocalizations.of(context)!.success,isFail:false);
                    },title:AppLocalizations.of(context)!.yes,style:PStyle.primary,
                      size:PSize.large,),
                  )
                ],)),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox();
      }
  ).then((value) {
    showMessage(context,AppLocalizations.of(context)!.success,isFail:false);
    Navigator.pop(context);
  },);
}