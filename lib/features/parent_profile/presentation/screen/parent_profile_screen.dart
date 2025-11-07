// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:parent_app/resorces/pallete.dart';
// import '../../../../core/constants.dart';
//
// // Parent Profile
// import '../bloc/parent_profile_bloc.dart';
// import '../bloc/parent_profile_event.dart';
// import '../bloc/parent_profile_state.dart';
//
// // Parent Bank
// import '../bloc/guardian_banking_bloc.dart';
// import '../bloc/guardian_banking_event.dart';
// import '../bloc/guardian_baking_state.dart';
//
// import '../widgets/bank_info.dart';
// import '../widgets/info_card.dart';
// import '../widgets/info_card_email.dart';
//
// class ParentProfileWidget extends StatefulWidget {
//   const ParentProfileWidget({Key? key}) : super(key: key);
//
//   @override
//   State<ParentProfileWidget> createState() => _ParentProfileWidgetState();
// }
//
// class _ParentProfileWidgetState extends State<ParentProfileWidget> {
//   @override
//   void initState() {
//     super.initState();
//
//     context.read<ParentProfileBloc>().add(
//       LoadParentProfileEvent(parentId: parentContactId),
//     );
//
//     context.read<ParentBankBloc>().add(
//       LoadParentBank(guardianId: parentContactId),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Stack(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFE9DFFF), Color(0xFFF3EFFF)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () => Navigator.pop(context),
//             ),
//             title: const Text(
//               'Parent Profile',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//
//           body: BlocBuilder<ParentProfileBloc, ParentProfileState>(
//             builder: (context, parentState) {
//               if (parentState is ParentProfileLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (parentState is ParentProfileError) {
//                 return Center(
//                   child: Text(parentState.message,
//                       style: const TextStyle(color: Colors.red)),
//                 );
//               }
//
//               if (parentState is! ParentProfileLoaded) {
//                 return const SizedBox();
//               }
//
//               final p = parentState.parent;
//               final photo = p.photo;
//               final name = p.fullName;
//               final phone = p.phone ?? "-";
//               final email = p.email ?? "-";
//               final address = p.street ?? "-";
//               final postal = p.postalCode ?? "-";
//
//               return BlocBuilder<ParentBankBloc, ParentBankState>(
//                 builder: (context, bankState) {
//                   final banking = bankState.banking;
//                   bool consent = banking?.consent ?? false;
//                   bool subsidy = bankState.hasSubsidy;
//                   String acc = banking?.accountNumber ?? "-";
//                   String tran = banking?.transitNumber ?? "-";
//                   String inst = banking?.institutionNumber ?? "-";
//
//                   return SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           /// HEADER
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 40,
//                                   backgroundImage: (photo != null && photo.isNotEmpty)
//                                       ? NetworkImage('http://51.79.53.56:8055/assets/$photo?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo')
//                                       : const AssetImage('assets/images/avatar1.png')
//                                   as ImageProvider,
//                                 ),
//                                 const SizedBox(width: 16),
//
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       name,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(color: Palette.bgBorder, width: 1),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           SvgPicture.asset('assets/images/ic_call.svg'),
//                                           const SizedBox(width: 4),
//                                           Text(phone),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           const SizedBox(height: 24),
//
//                           /// BODY
//                           Container(
//                             height: screenHeight * 4 / 5,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(24),
//                                 topRight: Radius.circular(24),
//                               ),
//                             ),
//
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// Address + Postal
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: InfoCard(
//                                           icon: 'assets/images/ic_address_parent.svg',
//                                           title: 'Address',
//                                           subtitle: address,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         child: InfoCard(
//                                           icon: 'assets/images/ic_postal_code.svg',
//                                           title: 'Postal Code',
//                                           subtitle: postal,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 /// Email
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                   child: InfoCardEmail(
//                                     icon: 'assets/images/ic_email_parent.svg',
//                                     title: 'Email',
//                                     subtitle: email,
//                                     fullWidth: true,
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 24),
//
//                                 /// Banking
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                   child: Text(
//                                     'Banking information',
//                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//
//                                 /// Pre auth switch
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                       child: Text('Pre-Authorization Consent'),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 12.0),
//                                       child: Transform.scale(
//                                         scale: 0.85,
//                                         child: Switch(
//                                           activeColor: Palette.borderPrimary,
//                                           value: consent,
//                                           onChanged: (v) {
//                                             context.read<ParentBankBloc>().add(
//                                               TogglePreAuthConsent(v),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 /// Bank info card
//                                 Padding(
//                                   padding: const EdgeInsets.all(14.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       border: Border.all(color: Colors.white, width: 2),
//                                       image: const DecorationImage(
//                                         image: AssetImage('assets/images/background_parent.png'),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         BankInfoRow(title: 'Account Number', value: acc),
//                                         BankInfoRow(title: 'Transit No', value: tran),
//                                         BankInfoRow(title: 'Institution Number', value: inst),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 24),
//
//                                 /// Subsidy switch
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                       child: Text('Subsidy or Benefit Program'),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 12.0),
//                                       child: Transform.scale(
//                                         scale: 0.85,
//                                         child: Switch(
//                                           activeColor: Palette.borderPrimary,
//                                           value: subsidy,
//                                           onChanged: (v) {
//                                             // چون event نداده بودی فقط UI تغییر می‌کنیم
//                                             // اگر event دادی بگو اضافه کنم
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parent_app/resorces/pallete.dart';
import '../../../../core/constants.dart';

// Parent Profile
import '../bloc/guardian_baking_state.dart';
import '../bloc/guardian_banking_event.dart';
import '../bloc/parent_profile_bloc.dart';
import '../bloc/parent_profile_event.dart';
import '../bloc/parent_profile_state.dart';

// Guardian Banking
import '../bloc/guardian_banking_bloc.dart';

// Subsidy
import '../bloc/subsidy_bloc.dart';

import '../bloc/subsidy_event.dart';
import '../bloc/subsidy_state.dart';
import '../widgets/bank_info.dart';
import '../widgets/info_card.dart';
import '../widgets/info_card_email.dart';

class ParentProfileWidget extends StatefulWidget {
  const ParentProfileWidget({Key? key}) : super(key: key);

  @override
  State<ParentProfileWidget> createState() => _ParentProfileWidgetState();
}

class _ParentProfileWidgetState extends State<ParentProfileWidget> {
  @override
  void initState() {
    super.initState();

    context.read<ParentProfileBloc>().add(
      LoadParentProfileEvent(parentId: parentContactId),
    );

    context.read<GuardianBankingBloc>().add(
      LoadGuardianBankingEvent(parentContactId2),
    );

    context.read<SubsidyBloc>().add(
      LoadSubsidyStatusEvent(parentContactId2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
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

          body: BlocBuilder<ParentProfileBloc, ParentProfileState>(
            builder: (context, parentState) {
              if (parentState is ParentProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (parentState is ParentProfileError) {
                return Center(
                  child: Text(parentState.message,
                      style: const TextStyle(color: Colors.red)),
                );
              }

              if (parentState is! ParentProfileLoaded) {
                return const SizedBox();
              }

              final p = parentState.parent;
              final photo = p.photo;
              final name = p.fullName;
              final phone = p.phone ?? "-";
              final email = p.email ?? "-";
              final address = p.street ?? "-";
              final postal = p.postalCode ?? "-";

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// HEADER
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: (photo != null && photo.isNotEmpty)
                                  ? NetworkImage(
                                  'http://51.79.53.56:8055/assets/$photo?access_token=1C1ROl_Te_A_sNZNO00O3k32OvRIPcSo')
                                  : const AssetImage('assets/images/avatar1.png')
                              as ImageProvider,
                            ),
                            const SizedBox(width: 16),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
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

                      /// BODY
                      Container(
                        height: screenHeight * 4 / 5,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Address + Postal
                            Padding(
                              padding: const EdgeInsets.all(16.0),
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

                            /// Email
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: InfoCardEmail(
                                icon: 'assets/images/ic_email_parent.svg',
                                title: 'Email',
                                subtitle: email,
                                fullWidth: true,
                              ),
                            ),

                            const SizedBox(height: 24),

                            /// BANKING INFO
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Banking Information',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 8),

                            BlocBuilder<GuardianBankingBloc,
                                GuardianBankingState>(
                              builder: (context, state) {
                                if (state is GuardianBankingLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is GuardianBankingLoaded) {
                                  final b = state.data;
                                  return Column(
                                    children: [
                                      /// Consent switch
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                                'Pre-Authorization Consent'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Transform.scale(
                                              scale: 0.85,
                                              child: Switch(
                                                activeColor:
                                                Palette.borderPrimary,
                                                value: b.consent,
                                                onChanged: (v) {
                                                  context
                                                      .read<
                                                      GuardianBankingBloc>()
                                                      .add(ToggleConsentEvent(
                                                      b.id, v));
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// Bank info
                                      Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
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
                                                  value: b.accountNumber ?? ''),
                                              BankInfoRow(
                                                  title: 'Transit No',
                                                  value: b.transitNumber ?? ''),
                                              BankInfoRow(
                                                  title: 'Institution Number',
                                                  value: b.institutionNumber ?? ''),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (state is GuardianBankingError) {
                                  return Center(
                                      child: Text(
                                        state.message,
                                        style:
                                        const TextStyle(color: Colors.redAccent),
                                      ));
                                }
                                return const SizedBox();
                              },
                            ),

                            const SizedBox(height: 24),

                            /// SUBSIDY INFO
                            BlocBuilder<SubsidyBloc, SubsidyState>(
                              builder: (context, state) {
                                if (state is SubsidyLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is SubsidyLoaded) {
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                            'Subsidy or Benefit Program'),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 12.0),
                                        child: Transform.scale(
                                          scale: 0.85,
                                          child: Switch(
                                            activeColor:
                                            Palette.borderPrimary,
                                            value: state.hasActive,
                                            onChanged: null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (state is SubsidyError) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      style:
                                      const TextStyle(color: Colors.redAccent),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
