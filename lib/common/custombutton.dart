
import 'package:flutter/material.dart';
import 'package:notes_byte/appconstant.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const CustomButton({super.key,
  required this.title,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
    child: Container( padding: const EdgeInsets.all(18),
      decoration: BoxDecoration( color: AppConstant.compoColor,
      borderRadius: BorderRadius.circular(14)),
      child: Center(child: Text(title, style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold,
        color: AppConstant.textcolor),)),
    ),
    );
  }
}