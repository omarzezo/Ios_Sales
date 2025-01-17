import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/login/presentation/logic/login_notifier.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LayerThree extends StatefulWidget {
  LayerThree({super.key,required this.callback});
  final void Function(String name,String password) callback;
  @override
  State<LayerThree> createState() => LayerThreeState();
}

class LayerThreeState extends State<LayerThree> {
  bool isChecked = false;
  bool passwordVisible = false;
  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  void initState() {
   setState(() {
     userName.text=SharedPrefHelper.sp.getString('userName')??'';
     password.text=SharedPrefHelper.sp.getString('password')??'';
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 584,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            left:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?59:0,
            right:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?0:14,
            top:60,
            child:PText(title:AppLocalizations.of(context)!.user_name,size:PSize.large,)
          ),
          Positioned(
              left: 59,
              top:80,
              child: Container(
                width: 310,
                child: TextField(controller:userName,
                    cursorColor:AppColors.primary,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    focusedBorder:UnderlineInputBorder(),
                    hintText: 'Enter User Name',
                    hintStyle: TextStyle(color:  AppColors.hintText),
                  ),
                ),
              )),
          Positioned(
              left:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?59:0,
              right:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?0:14,
            top:170,
            child: PText(title:AppLocalizations.of(context)!.password,size:PSize.large,)
          ),
          Positioned(
              left: 59,
              top:190,
              child: Container(
                width: 310,
                child: TextField(controller:password,
                  cursorColor:AppColors.primary,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                    border: UnderlineInputBorder(),
                    focusedBorder:UnderlineInputBorder(),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: AppColors.hintText),
                  ),
                ),
              )),
          // Positioned(
          //     right: 60,
          //     top: 280,
          //     child: PText(title:'Forgot Password',size:PSize.large,)
          //     ),
          Positioned(left: 46,
            top: 250,
            child: Consumer(builder:(context, ref, child) {
              return Row(children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor:  AppColors.checkbox,
                  value:ref.watch(rememberMeProvider),
                  onChanged: (bool? value) {
                    ref.read(rememberMeProvider.state).state=value??false;
                    SharedPrefHelper.sp.setBool('rememberMe', value??false);
                  },
                ),
                InkWell(onTap:() {
                  ref.read(rememberMeProvider.state).state=!ref.watch(rememberMeProvider);
                  SharedPrefHelper.sp.setBool('rememberMe',!ref.watch(rememberMeProvider));
                },child: PText(title:AppLocalizations.of(context)!.remember_me,size:PSize.large,))
              ],);
            },),
          ),
          Positioned(
              top: 258,
              // left:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?0:10,
              right:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?0:20,
              // right: 60,
              child: InkWell(
                onTap:() {
                  widget.callback(userName.text,password.text);
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddToMakhzonScreen()));
                },
                child: Container(width:100,
                  padding:EdgeInsets.only(top:6.sp,bottom:12.sp,left:14.sp,right:14.sp),
                  decoration: BoxDecoration(
                    color:  AppColors.signInButton,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child:Center(child: PText(title:AppLocalizations.of(context)!.sign_in,size:PSize.large,fontColor:AppColors.white,))
                  ),
                ),
              )),
          // Positioned(
          //     top: 300,
          //     left: 59,
          //     child: Container(
          //       height: 0.5,
          //       width: 310,
          //       color:  AppColors.inputBorder,
          //     )),

        ],
      ),
    );
  }
}