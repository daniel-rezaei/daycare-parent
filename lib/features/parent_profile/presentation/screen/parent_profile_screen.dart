import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/phone_utils.dart';
import '../../../../resorces/pallete.dart';
import '../../../login/domain/entity/user_entity.dart';
import '../../../login/presentation/screen/login_screen.dart';
import '../bloc/parent_profile_bloc.dart';
import '../bloc/parent_profile_event.dart';
import '../bloc/parent_profile_state.dart';
import '../widgets/info_card.dart';
import '../widgets/info_card_email.dart';
import '../widgets/bank_info.dart';
import '../bloc/guardian_banking_bloc.dart';
import '../bloc/guardian_banking_event.dart';
import '../bloc/guardian_banking_state.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParentProfileBloc>().add(
        LoadParentProfileEvent(parentId: widget.user.id),
      );

      context.read<GuardianDashboardBloc>().add(
        LoadGuardianDashboard(
          contactId: widget.user.contactId ?? '',
          guardianId: widget.user.guardianId,
        ),
      );
    });
  }

  Future<void> signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  String _maskAccount(String? account) {
    if (account == null || account.length < 4) return account ?? '';
    return '*** ${account.substring(account.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Parent Profile', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              tooltip: "Sign Out",
              onPressed: () => signOut(context),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE9DFFF), Color(0xFFF3EFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          BlocBuilder<ParentProfileBloc, ParentProfileState>(
            builder: (context, state) {
              if (state is ParentProfileLoading || state is ParentProfileInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ParentProfileError) {
                return Center(child: Text(state.message));
              } else if (state is ParentProfileLoaded) {
                final parent = state.parent;
                final name = parent.fullName;
                final email = parent.email ?? "-";
                final phone = parent.phone ?? "-";
                final address = parent.street ?? "-";
                final postal = parent.postalCode ?? "-";
                final photo = parent.photo ?? "";

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kToolbarHeight + 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: (photo.isNotEmpty)
                                  ? CachedNetworkImageProvider(
                                  'http://51.79.53.56:8055/assets/$photo?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo')
                                  : const AssetImage('assets/images/avatar1.png')
                              as ImageProvider,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name.isNotEmpty ? name : email,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Palette.bgBorder),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset('assets/images/ic_call.svg', width: 18),
                                          const SizedBox(width: 6),
                                          Text(PhoneUtils.formatPhoneNumber(phone)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: screenHeight * 4 / 5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: BlocBuilder<GuardianDashboardBloc, GuardianDashboardState>(
                              builder: (context, gState) {
                                // fallback وقتی هنوز داده نیامده یا خطا دارد
                                Map<String, dynamic> bankData = {};
                                bool hasSubsidy = false;
                                bool consent = false;

                                if (gState is GuardianDashboardLoaded) {
                                  bankData = {
                                    'accountLast4': gState.banking?.accountLast4,
                                    'transitNumber': gState.banking?.transitNumber,
                                    'institutionNumber': gState.banking?.institutionNumber,
                                    'guardianId': gState.banking?.guardianId,
                                  };
                                  consent = gState.banking?.consent ?? false;
                                  hasSubsidy = gState.subsidyToggleOn;
                                }

                                return SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InfoCard(
                                                icon: 'assets/images/ic_address_parent.svg',
                                                title: 'Address',
                                                subtitle: address,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: InfoCard(
                                                icon: 'assets/images/ic_postal_code.svg',
                                                title: 'Postal Code',
                                                subtitle: postal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InfoCardEmail(
                                          icon: 'assets/images/ic_email_parent.svg',
                                          title: 'Email',
                                          subtitle: email,
                                          fullWidth: true,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Pre-Authorization Consent
                                      Align(
                                      alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                          'Banking information',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Palette.textForeground
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Pre-Authorization Consent'),
                                            Transform.scale(
                                              scale: 0.85,
                                              child: Switch(
                                                activeColor: Palette.borderPrimary,
                                                value: consent,
                                                onChanged: bankData['guardianId'] != null
                                                    ? (v) {
                                                  context
                                                      .read<GuardianDashboardBloc>()
                                                      .add(UpdateConsent(
                                                    consentValue: v,
                                                    fullName: parent.fullName,
                                                    guardianId: bankData['guardianId'],
                                                  ));
                                                }
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // بانک فقط وقتی موجود است
                                      if (consent)
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              image: const DecorationImage(
                                                image: AssetImage('assets/images/background_parent.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                BankInfoRow(
                                                  title: 'Account Number',
                                                  value: _maskAccount(bankData['accountLast4']),
                                                ),
                                                BankInfoRow(
                                                  title: 'Transit No',
                                                  value: bankData['transitNumber'] ?? '',
                                                ),
                                                BankInfoRow(
                                                  title: 'Institution Number',
                                                  value: bankData['institutionNumber'] ?? '',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      const SizedBox(height: 24),
                                      // Subsidy
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Subsidy or Benefit Program'),
                                            Transform.scale(
                                              scale: 0.85,
                                              child: Switch(
                                                activeColor: Palette.borderPrimary,
                                                value: hasSubsidy,
                                                onChanged: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

