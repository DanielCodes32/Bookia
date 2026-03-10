import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
 
  final int? keyboardtype;
  final bool? maxlines;
  final String? hintText;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,

    this.keyboardtype,
    this.maxlines, this.validator, required this.hintText,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFormField(
          
          validator: validator,
          keyboardType: keyboardtype == 1
              ? TextInputType.emailAddress
              : keyboardtype == 2
              ? TextInputType.number
              : TextInputType.text,
          minLines: maxlines == false ? 3 : 1,
          maxLines: maxlines == false ? null : 1,
              
          decoration: InputDecoration(
            hint:Text(
          hintText ?? "",
          style: TextStyles.caption1.copyWith(color: AppColors.greycolor),
        ) ,
            
            
          ),
        ),
      ],
    );
  }
}
