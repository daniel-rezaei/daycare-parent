import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/features/parent_profile/presentation/widgets/info_card_email.dart';
import 'package:parent_app/resorces/pallete.dart';

import '../widgets/bank_info.dart';
import '../widgets/info_card.dart';

class ParentProfileWidget extends StatefulWidget {
  const ParentProfileWidget({Key? key}) : super(key: key);

  @override
  State<ParentProfileWidget> createState() => _ParentProfileWidgetState();
}

class _ParentProfileWidgetState extends State<ParentProfileWidget> {
  bool _isOn = false;

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
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
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
                  // Profile Header
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            'assets/images/avatar1.png',
                          ), // عکس پروفایل
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jane Doe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:Border.all(color: Palette.bgBorder,width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                SvgPicture.asset('assets/images/ic_call.svg'),
                                  SizedBox(width: 4),
                                  Text('(123) 456-7890'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                 Container(
                   height: screenHeight * 4 / 5,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: const BorderRadius.only(
                       topLeft: Radius.circular(24),
                       topRight: Radius.circular(24),
                     ),
                   ),child:Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Row(
                         children: [
                           Expanded(
                             child: InfoCard(
                               icon: 'assets/images/ic_address_parent.svg',
                               title: 'Adress',
                               subtitle: '123 Main Street, Rich, On',
                             ),
                           ),
                           SizedBox(width: 16),
                           Expanded(
                             child: InfoCard(
                               icon: 'assets/images/ic_postal_code.svg',
                               title: 'Postal Code',
                               subtitle: 'L7E 5D8',
                             ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 16),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: InfoCardEmail(
                         icon: 'assets/images/ic_email_parent.svg',
                         title: 'Email',
                         subtitle: 'JaneDoe@gmail.com',
                         fullWidth: true,
                       ),
                     ),
                     SizedBox(height: 24),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: Text(
                         'Banking information',
                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                       ),
                     ),
                     SizedBox(height: 8),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
                           child: Text('Pre-Authorization Consent'),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 12.0),
                           child: Transform.scale(
                             scale: 0.85,
                             child: Switch(activeColor: Palette.borderPrimary,
                                 inactiveTrackColor: Palette.bgBorder,
                                 thumbColor: WidgetStateProperty.all(Colors.white),
                                 trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                                 value: _isOn, onChanged: (val) {
                                   setState(() {
                                     _isOn = val;
                                   });
                             }),
                           ),
                         ),
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.all(14.0),
                       child: Container(

                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           border: Border.all(color: Colors.white,width: 2),
                           image: DecorationImage(
                             image: AssetImage('assets/images/background_parent.png'),
                             fit: BoxFit.cover,
                           ),
                         ),
                         child: Column(
                           children: [
                             BankInfoRow(
                               title: 'Account Number',
                               value: '(123) 456-7890',
                             ),
                             BankInfoRow(title: 'Transit No', value: '12345'),
                             BankInfoRow(title: 'Institution Number', value: '123'),
                           ],
                         ),
                       ),
                     ),

                     SizedBox(height: 24),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
                           child: Text('Subsidy or Benefit Program'),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 12.0),
                           child: Transform.scale(
                             scale: 0.85,
                             child: Switch(activeColor: Palette.borderPrimary,
                                 inactiveTrackColor: Palette.bgBorder,
                                 thumbColor: WidgetStateProperty.all(Colors.white),
                                 trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                                 value: _isOn, onChanged: (val) {
                                   setState(() {
                                     _isOn = val;
                                   });
                                 }),
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
                 )

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


