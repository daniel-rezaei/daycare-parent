
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class EmergencyItem extends StatelessWidget {
  final String name, phone;
  final Color color;

  const EmergencyItem({
    required this.name,
    required this.phone,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white,width: 2),
          borderRadius: BorderRadius.all( Radius.circular(16),),
        ),
        child: Row(
          children: [

            Expanded(child: Text(name, style: const TextStyle(fontSize: 14))),
            Container(
              decoration: BoxDecoration(borderRadius:
              BorderRadius.all(Radius.circular(6)),color: Colors.white),child:
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  children: [
                     SvgPicture.asset('assets/images/ic_call_rounded.svg'),
                    const SizedBox(width: 4),
                    Text(phone, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              )
              ,
            )

          ],
        ),
      ),
    );
  }
}