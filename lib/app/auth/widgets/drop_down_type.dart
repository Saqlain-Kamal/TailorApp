import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';

class DropDownType extends StatelessWidget {
  const DropDownType({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  final String? selectedValue;
  final List<String> items;
  final void Function(String?)? onChanged;

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
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Image.asset(
              'assets/images/tag-user.png',
              color: Colors.grey.shade500,
              height: 10,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                        width: 150,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.grey.shade500),
                        )),
                  );
                }).toList(),
              ),
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 10), // Adjust padding here,
          hintText: 'Account Type',
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 1, color: AppColors.borderGreyColor),
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
