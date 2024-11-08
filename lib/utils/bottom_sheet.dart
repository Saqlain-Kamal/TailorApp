import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({
    required this.onImageSelected,
    super.key,
  });
  final Function(String?) onImageSelected;
  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  String? selectedImagePath;
  final imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              final pickedImage = await imagePicker
                  .pickImage(source: ImageSource.gallery)
                  .then((value) {
                if (value != null && value.path.isNotEmpty) {
                  widget.onImageSelected(value.path);
                } else {
                  log('Image Not Selected');
                }
              });

              // final pickedImage =
              //     await pickImage(source: ImageSource.camera).then((value) {
              //   Navigator.of(context).pop();
              //   if (value != '') {
              //     widget.onImageSelected(value);
              //   }
              // });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColors.darkBlueColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Camera',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/images/Dot.png',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final pickedImage = imagePicker
                  .pickImage(source: ImageSource.gallery)
                  .then((value) {
                if (value != null && value.path.isNotEmpty) {
                  widget.onImageSelected(value.path);
                } else {
                  log('Image Not Selected');
                }
              });
              // pickImage(source: ImageSource.gallery).then((value) {
              //   Navigator.of(context).pop();
              //   if (value != '') {
              //     widget.onImageSelected(value);
              //   }
              // });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColors.darkBlueColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Gallery',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/images/Dot.png',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
