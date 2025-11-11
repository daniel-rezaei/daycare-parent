
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../resorces/pallete.dart';


class ArtBottomSheet extends StatelessWidget {
  const ArtBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Palette.bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'ART',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Palette.txtPrimary,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Palette.borderInput,width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/images/ic_download_media.svg'),
                  ),
                ),

              ],

            ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/image_gallery.png', // تصویر جایگزین
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(

                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset('assets/images/ic_play.svg')
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                    ''),
              ),
              const SizedBox(width: 8),
              Text(
                'Sara',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Palette.textForeground
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Palette.bgColorPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Teacher',
                  style: TextStyle(
                    color: Palette.txtTagForeground2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '11:31 AM',
                  style: TextStyle(fontWeight: FontWeight.w400,
                  fontSize: 12,color: Palette.textMutedForeground),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // --- Description
          Text(
            "Sophia’s enjoyed painting today. Look at her masterpiece",
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,
            color: Palette.textForeground
            ),

          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
