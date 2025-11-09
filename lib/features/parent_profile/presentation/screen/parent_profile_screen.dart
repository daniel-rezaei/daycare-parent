// lib/features/parent_profile/presentation/pages/parent_profile_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resorces/pallete.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../bloc/guardian_banking_bloc.dart';
import '../bloc/guardian_banking_event.dart';
import '../bloc/guardian_banking_state.dart';
import '../bloc/parent_profile_bloc.dart';
import '../bloc/parent_profile_event.dart';
import '../widgets/bank_info.dart';
import '../widgets/info_card.dart';
import '../widgets/info_card_email.dart';

class ParentProfileWidget extends StatefulWidget {
  final UserEntity user;

  const ParentProfileWidget({super.key, required this.user});

  @override
  State<ParentProfileWidget> createState() => _ParentProfileWidgetState();
}

class _ParentProfileWidgetState extends State<ParentProfileWidget> {
  @override
  void initState() {
    super.initState();
    final fullName = "${widget.user.firstName} ${widget.user.lastName}".trim();
    // Load parent profile
    context.read<ParentProfileBloc>().add(
      LoadParentProfileEvent(parentId: widget.user.contactId ?? ''),
    );

    // Load guardian dashboard
    context.read<GuardianDashboardBloc>().add(
      LoadGuardianDashboard(
        contactId: widget.user.contactId ?? '',

      ),
    );
  }

  String _maskAccount(String? account) {
    if (account == null || account.length < 4) return account ?? '';
    return '•••• •••• ${account.substring(account.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final name = "${widget.user.firstName} ${widget.user.lastName}".trim();
    final email = widget.user.email;
    final phone = widget.user.phone.isNotEmpty ? widget.user.phone : "-";
    final photo = widget.user.photo;
    final address = widget.user.address ?? "-";
    final postal = widget.user.postalCode ?? "-";

    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE9DFFF), Color(0xFFF3EFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Parent Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: (photo.isNotEmpty)
                              ? NetworkImage(
                              'http://51.79.53.56:8055/assets/$photo?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo')
                              : const AssetImage(
                            'assets/images/avatar1.png',
                          ) as ImageProvider,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name.isNotEmpty ? name : email,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Palette.bgBorder, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/ic_call.svg'),
                                  const SizedBox(width: 4),
                                  Text(phone),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // BODY
                  Container(
                    height: screenHeight * 4 / 5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: BlocBuilder<GuardianDashboardBloc, GuardianDashboardState>(
                      builder: (context, state) {
                        if (state is GuardianDashboardLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GuardianDashboardLoaded) {
                          final bank = state.banking;
                          final hasSubsidy = state.subsidyToggleOn;

                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Address + Postal
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InfoCard(
                                          icon:
                                          'assets/images/ic_address_parent.svg',
                                          title: 'Address',
                                          subtitle: address,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: InfoCard(
                                          icon:
                                          'assets/images/ic_postal_code.svg',
                                          title: 'Postal Code',
                                          subtitle: postal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Email
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: InfoCardEmail(
                                    icon:
                                    'assets/images/ic_email_parent.svg',
                                    title: 'Email',
                                    subtitle: email,
                                    fullWidth: true,
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Pre-Authorization toggle
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Pre-Authorization Consent'),
                                      Transform.scale(
                                        scale: 0.85,
                                        child:Switch(
                                          activeColor: Palette.borderPrimary,
                                          value: bank?.consent ?? false,
                                          onChanged: (v) {
                                            final banking = context.read<GuardianDashboardBloc>().state;
                                            if (banking is GuardianDashboardLoaded && banking.banking != null) {
                                              context.read<GuardianDashboardBloc>().add(
                                                UpdateConsent(
                                                  consentValue: v,
                                                  fullName: "${widget.user.firstName} ${widget.user.lastName}",
                                                  guardianId: banking.banking!.guardianId,
                                                ),
                                              );
                                            }
                                          },

                                        ),

                                      ),
                                    ],
                                  ),
                                ),

                                // Bank fields container (enabled only if consent == true)
                                if (bank?.consent == true)
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/background_parent.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          BankInfoRow(
                                            title: 'Account Number',
                                            value: _maskAccount(
                                                bank?.accountLast4), // از مدل GuardianBanking
                                          ),
                                          BankInfoRow(
                                            title: 'Transit No',
                                            value: bank?.transitNumber ?? '',
                                          ),
                                          BankInfoRow(
                                            title: 'Institution Number',
                                            value: bank?.institutionNumber ?? '',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 24),

                                // Subsidy info (read-only)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Subsidy or Benefit Program'),
                                      Transform.scale(
                                        scale: 0.85,
                                        child: Switch(
                                          activeColor: Palette.borderPrimary,
                                          value: hasSubsidy,
                                          onChanged: null, // read-only
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is GuardianDashboardError) {
                          return Center(child: Text(state.message));
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
