import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sales/features/settings/presentation/page/settings_screen.dart';
import 'package:sales/features/super_visor_reports/presentation/page/supervisor_reports_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:AppColors.white,
      body: content(context)
    );
  }

  get dashBg => Column(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(color:AppColors.primary),
      ),
      Expanded(
        flex: 6,
        child: Container(color: Colors.transparent),
      ),
    ],
  );

  Widget content(BuildContext context){
    return Column(
      children: <Widget>[
        Container(color:AppColors.primary,height:140,child: header(context)),
        grid(context),
      ],
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:14,right:14,top:14),
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
           Padding(
            padding: const EdgeInsets.only(top:8),
            child: PText(title:AppLocalizations.of(context)!.home,size:PSize.large,fontColor:AppColors.white,),
          ),
          Padding(
            padding: const EdgeInsets.only(top:30),
            child: Column(mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
               ((SharedPrefHelper.sp.getString('empPic')??'').isNotEmpty)?
                 ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child:Image.memory(const Base64Decoder().convert(SharedPrefHelper.sp.getString('empPic')??''),
                      width:40,height:40,fit:BoxFit.fill,)
                ):const Padding(
                  padding: EdgeInsets.only(top:14),
                  child: CircleAvatar(backgroundColor:Colors.white,child:Icon(Icons.person),),
                ),
                Padding( 
                  padding: const EdgeInsets.only(bottom:0),
                  child: PText(title:SharedPrefHelper.sp.getString('empName')??'',size:PSize.large,fontColor:AppColors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget grid (BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16,top:0),
        child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio:1.1,
          children: List.generate(getHomeItems(context: context).length, (index) {
            return Card(elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap:() {
                  if(index==0){
                    Navigator.of(context).push(createRoute(SupervisorReportsScreen()));
                  }else if(index==1){
                    Navigator.of(context).push(createRoute(const SettingsScreen()));
                  }
                  // else if(index==3){
                  //   Navigator.of(context).push(createRoute(const ReportsScreen()));
                  // }else if(index==5){
                  //   Navigator.of(context).push(createRoute(const GardScreen()));
                  // }else if(index==6){
                  //   Navigator.of(context).push(createRoute(const SettingsScreen()));
                  // }else if(index==2){
                  //   Navigator.of(context).push(createRoute(const EznTransferScreen()));
                  // }else if(index==4){
                  //   Navigator.of(context).push(createRoute(const ItemCardScreen()));
                  // }
                },child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Image.asset(getHomeItems(context: context).toList()[index]['image']??'',
                    height:index==2?70:70,fit:BoxFit.fill,),
                    Padding(
                      padding: const EdgeInsets.only(top:14),
                      child: PText(title:getHomeItems(context: context).toList()[index]['title']??'', size:PSize.large),
                    )],
                ),
              ),
              ),
            );
          }),
        )
      ));
  }
}