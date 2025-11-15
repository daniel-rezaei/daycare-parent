import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ContactCard extends StatelessWidget {
  final String name;
  final String role;
  final String phone;
  final String? photo; // UUID یا URL
  final Color color;

  const ContactCard({
    super.key,
    required this.name,
    required this.role,
    required this.phone,
    this.photo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    final imageProvider = (photo != null && photo!.isNotEmpty)
        ? CachedNetworkImageProvider('http://51.79.53.56:8055/assets/$photo?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo')
        : const AssetImage('assets/images/avatar_placeholder.png') as ImageProvider;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 24, backgroundImage: imageProvider),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/ic_call.svg'),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      phone,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis, // اگه طولانی بود، سه‌نقطه بزنه
                    ),
                  ),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
