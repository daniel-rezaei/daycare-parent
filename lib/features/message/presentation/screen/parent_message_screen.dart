


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parent_app/features/resource_home/document/presentation/screen/document_screen.dart';
import 'package:parent_app/resorces/pallete.dart';

import 'message_screen.dart';




class ParentMessageScreen extends StatefulWidget {
  final String activeChildId;

  const ParentMessageScreen({super.key, required this.activeChildId});

  @override
  State<ParentMessageScreen> createState() => _ParentMessageScreenState();
}

class _ParentMessageScreenState extends State<ParentMessageScreen> {
  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF7F7F8), Color(0xFFF7F7F8)],
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
              onPressed: () {},
            ),

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 8.0),
                    child: Text('Messages',style: TextStyle(
                      fontSize: 26,fontWeight: FontWeight.w600,
                      color: Palette.textForeground,
                    ),),
                  ),
                  SizedBox(height: 24),

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
                      child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPageSample(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/brand3_background.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Office',style:
                                      TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Palette.textForeground
                                      ),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/ic_office.svg'),
                                    ),

                                  ],),
                                ),
                              ),
                            ),

                            InkWell(
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ChatPageSample(),
                              //     ),
                              //   );
                              // },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16,top: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/brand2_background.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Teacher',style:
                                      TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Palette.textForeground
                                      ),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/ic_teacher.svg'),
                                    ),

                                  ],),
                                ),
                              ),
                            ),

                          ]
                      )

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
