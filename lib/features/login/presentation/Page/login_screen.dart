import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/home/presentation/pages/home/home_screen.dart';
import 'package:sales/features/login/data/models/login_request_model.dart';
import 'package:sales/features/login/data/models/login_response_model.dart';
import 'package:sales/features/login/presentation/logic/login_notifier.dart';
import 'package:sales/features/login/presentation/widgets/layer_one.dart';
import 'package:sales/features/login/presentation/widgets/layer_three.dart';
import 'package:sales/features/login/presentation/widgets/layer_two.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    String companyLogo = SharedPrefHelper.sp.getString('companyLogo')??'';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFC2974E),
                Color(0xFFC2974E),
                // Colors.orange,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          // image:DecorationImage(
          //   image: AssetImage('images/primaryBg.png'),
          //   fit: BoxFit.cover,
          // )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:MediaQuery.sizeOf(context).height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top:8.h,left:25.w,
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child:Image.memory(const Base64Decoder().convert(companyLogo),
                            width:200,height:160,fit:BoxFit.fill,)
                        )
                    ),
                    Positioned(
                        top:30.h, left:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?10.w:0,
                        right:((SharedPrefHelper.sp.getString('lang')??'en')=='en')?13:2.w,
                        child:PText(title:AppLocalizations.of(context)!.login,size:PSize.veryLarge,fontColor:AppColors.white,)),
                    // if(allDbResponseModel!=null)Text(allDbResponseModel.toString()),
                    Positioned(top:35.h, right: 0, bottom: 0, child: LayerOne()),
                    Positioned(top:39.h, right: 0, bottom: 28, child: LayerTwo()),
                    Positioned(top:35.h, right: 10, bottom: 48, child: LayerThree(callback:(name,password) async {
                      LoginRequestModel model=LoginRequestModel(branchId:0,
                      userName:name,password:password,companyNumber:SharedPrefHelper.sp.getInt('companyNumber'),
                      connectionId:SharedPrefHelper.sp.getInt('connectionId'),isManager:false);
                      SharedPrefHelper.sp.setString('userName',name);
                      SharedPrefHelper.sp.setString('password',password);
                      // LoginResponseModel? loginModel = await ref.watch(loginDataProvider(model)).value;
                      LoginResponseModel? loginModel = await ref.watch(loginProvider).login(model: model);
                      SharedPrefHelper.sp.setInt('userId',loginModel?.data?.userID??0);
                      SharedPrefHelper.sp.setInt('mandopId',loginModel?.data?.mandopId??0);
                      SharedPrefHelper.sp.setString('empName',loginModel?.data?.empName??'');
                      SharedPrefHelper.sp.setString('empPic',loginModel?.data?.empPic??'');
                      SharedPrefHelper.sp.setString('empEmail',loginModel?.data?.empMail??'');
                      SharedPrefHelper.sp.setString('empMob',loginModel?.data?.empMob??'');
                      SharedPrefHelper.sp.setInt('prounchID',loginModel?.data?.prounchID??0);
                      // print('code>>'+loginModel.code.toString());
                      if(loginModel!=null&&loginModel.code==200){
                        await SharedPrefHelper.sp.setBool('isLogged',true);
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => const HomeScreen(),
                          ),(route) => false,
                        );
                      // Navigator.of(context).push(createRoute( HomeScreen()));
                      }else{
                        showMessage(context,'User Not Exist');
                      }
                    },)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}