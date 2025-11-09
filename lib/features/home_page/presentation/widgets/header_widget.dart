import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/resorces/pallete.dart';
import '../../../../resorces/style.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../../../parent_profile/presentation/screen/parent_profile_screen.dart';


class HeaderWidget extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onLoaded;

  const HeaderWidget({
    super.key,
    required this.user,
    this.onLoaded,
  });

  @override
  Widget build(BuildContext context) {
    final parentName = "${user.firstName} ${user.lastName}".trim().isNotEmpty
        ? "${user.firstName} ${user.lastName}"
        : user.email; // اگه اسم خالی بود، ایمیل رو نشون بده

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          parentName,
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: Palette.textSecondaryForeground,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParentProfileWidget(user: user),
                  ),
                );
              },
              child: Text(
                "Go to profile",
                style: AppTypography.titleSmallSemiBold.copyWith(
                  color: Palette.textSecondaryForeground,
                ),
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset("assets/images/ic_arrow.svg"),
          ],
        ),
      ],
    );
  }
}
