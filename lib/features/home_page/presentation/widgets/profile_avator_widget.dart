import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resorces/pallete.dart';
import '../bloc/child_bloc.dart';
import '../bloc/child_state.dart';

class ProfileAvatarSelector extends StatefulWidget {
  const ProfileAvatarSelector({super.key, this.onLoaded});

  final VoidCallback? onLoaded;

  @override
  State<ProfileAvatarSelector> createState() => _ProfileAvatarSelectorState();
}

class _ProfileAvatarSelectorState extends State<ProfileAvatarSelector> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoaded?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      builder: (context, state) {
        if (state is ChildLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChildError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is ChildLoaded) {
          final child = state.child;

          final photoUrl = child.photo != null
              ? 'http://51.79.53.56:8055/assets/${child.photo}?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo'
              : null;

          final fullName = child.contacts.isNotEmpty
              ? '${child.contacts.first.firstName} ${child.contacts.first.lastName}'
              : 'Unknown';

          final initials = fullName
              .split(' ')
              .where((p) => p.isNotEmpty)
              .map((p) => p[0].toUpperCase())
              .take(2)
              .join();

          final List<String?> avatars = [
            photoUrl,
            "assets/images/avatar1.png",
            "assets/images/avatar2.png",
            "assets/images/avatar4.png",
          ].take(3).toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: ClipOval(
                  child: avatars[selectedIndex] != null
                      ? (avatars[selectedIndex]!.startsWith('http')
                      ? Image.network(
                    avatars[selectedIndex]!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )
                      : Image.asset(
                    avatars[selectedIndex]!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ))
                      : Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.txtPrimary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // دایره‌های پایین حذف شدند، بقیه ظاهر دقیقاً مثل قبل است
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
