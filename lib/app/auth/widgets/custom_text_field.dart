import 'package:flutter/material.dart';
import 'package:tailor_app/app/utils/colors.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.controller,
    this.readOnly,
    this.isShowArrow,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
  });
  final String? prefixIcon;

  final String hint;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool? isShowArrow;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onTap: onTap,
        style: const TextStyle(fontSize: 12),
        readOnly: readOnly != null ? true : false,
        controller: controller,
        cursorColor: AppColors.darkBlueColor,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  child: Image.asset(
                    prefixIcon!,
                    color: Colors.grey.shade500,
                    height: 10,
                  ),
                )
              : null,
          suffixIcon: readOnly != null && isShowArrow != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.grey.shade500,
                  ))
              : null,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 10), // Adjust padding here,
          hintText: hint,

          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
          ),
          focusedBorder: readOnly != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      width: 1, color: AppColors.darkBlueColor),
                ),
        ),
      ),
    );
  }
}
