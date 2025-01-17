import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/custom/p_text.dart';
import 'package:sales/core/utils/globals.dart';


class PDropdown extends StatefulWidget {
  final List<String> menuNames;
  final List<Widget>? menuIcons;
  final void Function(String? value) onChanged;
  const PDropdown({Key? key, required this.menuNames, this.menuIcons, required this.onChanged}) : super(key: key);

  @override
  State<PDropdown> createState() => _PDropdownState();
}

class _PDropdownState extends State<PDropdown> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          items: widget.menuNames.mapIndexed((i,item) => DropdownMenuItem<String>(
            value: item,
            child: Row(mainAxisSize: MainAxisSize.min,
              children: [
                if(widget.menuIcons != null) widget.menuIcons![i],
                const SizedBox(width: 5,),
                Flexible(child: PText(title: item,size: PSize.small,fontWeight: FontWeight.w500,fontColor: AppColors.black,)),
              ],
            )
          )).toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
            widget.onChanged(selectedValue);
          },
          customButton:Container(padding:EdgeInsets.symmetric(horizontal:10,vertical:14),
              decoration: BoxDecoration(
                  border: Border.all(
                    color:AppColors.primary,
                  ),
                  borderRadius:const BorderRadius.all(Radius.circular(8))
              ),
            child: Row(
              children: [
                PText(title: 'Store', size:PSize.veryLarge),Spacer(),
                const Icon(Icons.arrow_drop_down_circle,color:AppColors.primary),
              ],
            ),
          ),
          dropdownStyleData: DropdownStyleData(
              maxHeight:MediaQuery.sizeOf(context).height,useSafeArea:true,
              width: MediaQuery.sizeOf(context).width,
              padding:EdgeInsets.only(left:MediaQuery.sizeOf(context).width*0.40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              elevation: 8,
              offset: const Offset(-50, -5)),
             menuItemStyleData:  MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),

        ),
      ),
    );
  }
}