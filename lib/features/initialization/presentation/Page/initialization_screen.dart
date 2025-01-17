import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_appbar.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/initialization/data/models/db_response_model.dart';
import 'package:sales/features/initialization/presentation/logic/db_notifier.dart';
import 'package:sales/features/login/presentation/Page/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collection/collection.dart';

class InitializationScreen extends StatefulWidget{
  const InitializationScreen({super.key});
  @override
  InitialNamesPageStateNew createState() => InitialNamesPageStateNew();
}

class InitialNamesPageStateNew extends State<InitializationScreen> {
  AllDbResponseModelData? selectedValue;
  AllDbResponseModel? allDbResponseModel;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context: context,text:AppLocalizations.of(context)!.company,backBtn:false,isCenter:true,),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
          Container(
            width: MediaQuery.of(context).size.width*0.88,
            height:350,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent
              // : Colors.lightBlue.shade50,
            ),
            child: Lottie.asset(
              'assets/get-in-touch-with-us-online-managers.json',
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
          Center(child: PText(title:AppLocalizations.of(context)!.select_company, size: PSize.veryLarge)),
          const SizedBox(height:20,),
          Consumer(builder:(context, ref, child) {
            allDbResponseModel = ref.watch(dbDataProvider).value;
            return (allDbResponseModel!=null&&allDbResponseModel!.data!=null&&
                allDbResponseModel!.data!.isNotEmpty)?Padding(
              padding: const EdgeInsets.symmetric(horizontal:30),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<AllDbResponseModelData>(
                  items: allDbResponseModel!.data!.mapIndexed((i,item) => DropdownMenuItem<AllDbResponseModelData>(
                      value: item,
                      child: Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 5,),
                          Flexible(child: PText(title: item.dbName??'',
                            size: PSize.large,fontWeight: FontWeight.w500,fontColor: AppColors.black,)),
                        ],
                      )
                  )).toList(),
                  value: selectedValue,
                  onChanged: (val) async {
                    selectedValue=val;
                    SharedPrefHelper.sp.setInt('companyNumber',val?.companyNumber??0);
                    setState(() {});
                    AllDbResponseModelData? data =
                    await ref.watch(dbProvider).getInfoForDbApi(companyCode:val?.companyNumber??0);
                    // await ref.watch(dbProvider).getInfoForDbApi(companyCode:36);
                    if(data!=null){
                      SharedPrefHelper.sp.setInt('connectionId',data.id??0);
                      // SharedPrefHelper.sp.setInt('connectionId',32);
                      SharedPrefHelper.sp.setString('companyLogo',data.comPLogo??'');
                      Navigator.of(context).push(createRoute(const LoginScreen()));
                    }
        
                  },
                  customButton:Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:14),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color:AppColors.primary,
                        ),
                        borderRadius:const BorderRadius.all(Radius.circular(8))
                    ),
                    child: Row(
                      children: [
                        PText(title:selectedValue!=null?selectedValue!.dbName!.replaceAll(RegExp("\r\n"), ''):
                            AppLocalizations.of(context)!.company_title, size:PSize.large,),const Spacer(),
                        const Icon(Icons.arrow_drop_down_circle,color:AppColors.primary),
                      ],
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                      maxHeight:MediaQuery.sizeOf(context).height,useSafeArea:true,
                      width: MediaQuery.sizeOf(context).width,
                      padding:EdgeInsets.only(left:MediaQuery.sizeOf(context).width*0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      elevation: 8,
                      offset: const Offset(-50, -5)),
                  menuItemStyleData:  MenuItemStyleData(
                    height: 40,overlayColor:MaterialStateProperty.all(AppColors.black.withOpacity(0.8)),
                    padding: EdgeInsets.only(left: 140, right: 14),
                  ),
        
                ),
              ),
            ):SizedBox.shrink();
          },)
        
        
        ],),
      )
    );
  }
}
