import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomPassField extends StatefulWidget {
  final String hintText;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomPassField({
    super.key,
    required this.hintText,
    this.prefixIcon,

    this.validator,
    this.controller,
  });

  @override
  State<CustomPassField> createState() => _CustomPassFieldState();
}

class _CustomPassFieldState extends State<CustomPassField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        hint: Text(
          widget.hintText,
          style: TextStyles.caption1.copyWith(color: AppColors.greycolor),
        ),
        prefixIcon: widget.prefixIcon,

        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
