import 'package:flutter/material.dart';
import 'package:tailor_app/app/utils/colors.dart';

class DropDownType extends StatelessWidget {
  const DropDownType({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.prefixImage,
    required this.isNotification,
  });

  final String? selectedValue;
  final List<String?>? items;
  final void Function(String?)? onChanged;
  final String hintText;
  final String? prefixImage;
  final bool isNotification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        readOnly: true,
        controller: TextEditingController(
          text: selectedValue, // Set the selected value as the text
        ),
        cursorColor: AppColors.darkBlueColor,
        decoration: InputDecoration(
          prefixIcon: prefixImage != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  child: Image.asset(
                    prefixImage!,
                    color: Colors.grey.shade500,
                    height: 10,
                  ),
                )
              : null,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(12),
                elevation: 3,
                icon: Image.asset(
                  'assets/images/arrow.png',
                  height: 15,
                  color: Colors.grey.shade500,
                ),
                underline: Container(), // Removes the default underline
                onChanged: onChanged,
                items: items?.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: isNotification
                        ? SizedBox(
                            width: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    value!,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 13),
                                  ),
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (value) {},
                                )
                              ],
                            ))
                        : SizedBox(
                            width: 150,
                            child: Text(
                              value!,
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                  );
                }).toList(),
              ),
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 10), // Adjust padding here,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 1, color: AppColors.darkBlueColor),
          ),
        ),
      ),
    );
  }
}
