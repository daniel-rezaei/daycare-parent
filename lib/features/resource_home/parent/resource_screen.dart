

import 'package:flutter/material.dart';
import 'package:parent_app/features/resource_home/document/presentation/screen/document_screen.dart';
import 'package:parent_app/features/resource_home/shared_media/presentation/shared.dart';
import 'package:parent_app/resorces/pallete.dart';

import '../form/presentation/screen/form_screen.dart';



class ResourceScreen extends StatefulWidget {


  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
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
              onPressed: () => Navigator.pop(context),
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
                    child: Text('Resources',style: TextStyle(
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
                                builder: (context) => DocumentScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/brand3_background.png'), // مسیر تصویر
                                  fit: BoxFit.cover, // می‌تواند cover, contain و غیره باشد
                                ),
                              ),child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text('Document',style:
                                 TextStyle(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 16,
                                   color: Palette.textForeground
                                 ),),
                             ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/images/ic_document.png'),
                                ),

                            ],),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/brand2_background.png'), // مسیر تصویر
                                  fit: BoxFit.cover, // می‌تواند cover, contain و غیره باشد
                                ),
                              ),child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Form',style:
                                  TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Palette.textForeground
                                  ),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/images/ic_form.png'),
                                ),

                              ],),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SharedScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 14),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/brand1_background.png'), // مسیر تصویر
                                  fit: BoxFit.cover, // می‌تواند cover, contain و غیره باشد
                                ),
                              ),child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Shared Media',style:
                                  TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Palette.textForeground
                                  ),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/images/ic_share_media.png'),
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
