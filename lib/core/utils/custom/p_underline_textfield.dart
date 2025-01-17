import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/globals.dart';
import 'p_text.dart';

class PUnderlineTextField extends StatefulWidget {
  const PUnderlineTextField({Key? key, required this.title, this.hintText,
  this.inputFormatters,this.keyboardType=TextInputType.text,this.maxLength,  this.onChanged, this.controller, this.text, this.validator, this.enabled, this.isObscured, this.maxLines}) : super(key: key);
  final String title;
  final String? text,hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength,maxLines;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final bool? enabled,isObscured;
  @override
  State<PUnderlineTextField> createState() => _PUnderlineTextFieldState();
}

class _PUnderlineTextFieldState extends State<PUnderlineTextField> {

  late  String text = widget.text ?? '';

  late final TextEditingController fieldController = widget.controller ?? TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  @override
  void initState() {
    text = widget.text ?? '';
    if(text.isNotEmpty)fieldController.text = text;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   // if(widget.text != null&&widget.text!.isNotEmpty)fieldController.text = widget.text!;
    return  Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 16),
          child: PText(
            title: widget.title,
            size: PSize.medium,
            fontColor: AppColors.hintText,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            obscureText: widget.isObscured == true ? isObscured : false,
            obscuringCharacter: 'X',
            enabled: widget.enabled,
              autovalidateMode: AutovalidateMode.always,
              inputFormatters:widget.inputFormatters??[],
              maxLength: widget.maxLength,
              controller: fieldController,
              keyboardType:widget.keyboardType,
              maxLines: widget.maxLines ?? 1,
              onChanged:  (val) {text = val..trim();
              if(widget.onChanged != null) widget.onChanged!(val);
              setState(() {});},
              validator: widget.validator,
              decoration: InputDecoration(
                  suffixIcon: widget.isObscured == true ? IconButton(icon: const Icon(Icons.remove_red_eye_outlined),onPressed: (){setState(() {
                    isObscured = !isObscured;
                  });}) : null,
                  hintText: widget.hintText ?? widget.title,
                  hintStyle: const TextStyle(
                      color: AppColors.hintText,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  enabledBorder:  const UnderlineInputBorder(
                    borderSide: BorderSide(color:  AppColors.hintText),
                  ),
                  disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color:  Colors.transparent ),
    ),
                  focusedBorder:  const UnderlineInputBorder(
                    borderSide: BorderSide(color:  AppColors.primary),
                  ))),
        ),
      ],);

  }
}