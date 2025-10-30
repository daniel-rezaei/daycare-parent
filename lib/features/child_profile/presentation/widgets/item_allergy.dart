import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListItem extends StatelessWidget {
  final String text;

  const ListItem({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 24),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/ic_warning_orange.svg'),
          const SizedBox(width: 8),
          Flexible(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
