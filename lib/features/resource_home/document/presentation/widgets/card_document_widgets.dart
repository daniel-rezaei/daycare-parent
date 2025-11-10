
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/resorces/pallete.dart';

class CardDocumentWidgets extends StatelessWidget {
  final String title;
  final String subtitle;
  const CardDocumentWidgets({super.key,required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
         color: Palette.borderPrimary20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Palette.textForeground),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Palette.textMutedForeground),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(borderRadius:
                BorderRadius.circular(8),color: Colors.white
                    ,border:Border.all(color: Palette.bgBorder,
                width: 1) ),child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_pdf_doc.svg'),
                      SizedBox(width: 4,),
                      Text(' PDF ',style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.w500,
                        color: Palette.textForeground
                      ),)
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
