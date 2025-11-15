import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../resorces/pallete.dart';
import '../../../child_profile/presentation/screen/child_profile.dart';
import '../bloc/child_bloc.dart';
import '../bloc/child_event.dart';
import '../bloc/child_state.dart';


class ProfileAvatarSelector extends StatelessWidget {
  const ProfileAvatarSelector({super.key, this.onLoaded});

  final VoidCallback? onLoaded;

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
        if (state is ChildListLoaded) {
          final children = state.children;
          final selectedIndex = state.selectedIndex;
          final selectedChild = state.selectedChild;

          final photoUrl = selectedChild.photo != null
              ? 'http://51.79.53.56:8055/assets/${selectedChild.photo}?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo'
              : null;

          final fullName = selectedChild.contacts.isNotEmpty
              ? '${selectedChild.contacts.first.firstName} ${selectedChild.contacts.first.lastName}'
              : 'Unknown';

          final initials = fullName
              .split(' ')
              .where((p) => p.isNotEmpty)
              .map((p) => p[0].toUpperCase())
              .take(2)
              .join();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            onLoaded?.call();
          });

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: InkWell(
                  key: ValueKey(selectedChild.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChildProfileWidget(
                          childId: selectedChild.id,
                          name: '',
                          dob: selectedChild.dob,
                          photoUrl: photoUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: ClipOval(
                      child: photoUrl != null
                          ? CachedNetworkImage(
                        imageUrl: photoUrl,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      )
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
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(children.length, (index) {
                  final c = children[index];
                  final thumbUrl = c.photo != null
                      ? 'http://51.79.53.56:8055/assets/${c.photo}?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo'
                      : null;

                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      context.read<ChildBloc>().add(SelectChild(index));
                    },
                    child: Transform.translate(
                      offset: Offset(index * -12, 0), // 🔥 همه آیتم‌ها اوورلپ یکسان دارند
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Palette.borderPrimary : Colors.grey.shade400,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: ClipOval(
                          child: thumbUrl != null
                              ? Image.network(
                            thumbUrl,
                            key: ValueKey(c.id),
                            fit: BoxFit.cover,
                          )
                              : Center(
                            child: Text(
                              c.contacts.isNotEmpty
                                  ? c.contacts.first.firstName[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )

            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}




