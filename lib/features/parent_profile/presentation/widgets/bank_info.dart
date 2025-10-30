
import 'package:flutter/material.dart';
import 'package:parent_app/resorces/pallete.dart';

class BankInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const BankInfoRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0,right: 32,top: 8,bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.bgColorInfo,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,
              color: Palette.textSecondaryForeground)),
              Text(value,style: TextStyle(
                fontSize: 14,fontWeight: FontWeight.w400,color: Palette.textForeground
              ),),
            ],
          ),
        ),
      ),
    );
  }
}