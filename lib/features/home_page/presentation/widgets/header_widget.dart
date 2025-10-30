import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/resorces/pallete.dart';
import '../../../../resorces/style.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../child_profile/presentation/screen/child_profile.dart';
import '../../../parent_profile/presentation/screen/parent_profile_screen.dart';
import '../../presentation/bloc/parent_contact_bloc.dart';
import '../../presentation/bloc/parent_contact_state.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, this.onLoaded});

  final VoidCallback? onLoaded;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoaded?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentContactBloc, ParentContactState>(
      builder: (context, state) {
        String parentName;

        if (state is ParentContactLoading) {
          parentName = 'Loading...';
        } else if (state is ParentContactLoaded) {
          parentName = state.contact.fullName;
        } else if (state is ParentContactEmpty) {
          parentName = '-';
        } else if (state is ParentContactError) {
          parentName = 'Error';
        } else {
          parentName = '';
        }

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
                      MaterialPageRoute(builder: (context) => ParentProfileWidget()),
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
      },
    );
  }
}
