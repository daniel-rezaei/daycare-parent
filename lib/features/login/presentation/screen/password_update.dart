
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_app/resorces/pallete.dart';

class PasswordUpdatePage extends StatefulWidget {
  const PasswordUpdatePage({super.key});

  @override
  _PasswordUpdatePageState createState() => _PasswordUpdatePageState();
}

class _PasswordUpdatePageState extends State<PasswordUpdatePage> {
  bool rememberMe = false;
  bool isRobot = false;
  bool passwordVisible = false;

  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          Positioned(
            top: screenHeight * 0.16,
            left: 0,
            right: 0,
            child: Center(child: SizedBox(  width: 250,
                height: 250,child: Image.asset('assets/images/update_password.png'))),
          ),

          Positioned(
            top: screenHeight * 0.40,
            left: 36,
            right: 36,
            bottom: 0,
            child: Column(
              children: [
                Text('Password updated',style: TextStyle(
                    fontSize: 26,fontWeight: FontWeight.w600,
                    color: Palette.textForeground
                ),),
                SizedBox(height: 12,),
                Text('Your password has been updated',style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,
                    color: Palette.textMutedForeground
                ),),

                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.txtTagForeground3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Go to Login', style: TextStyle(
                        fontSize: 16,
                        color: Palette.textPrimaryForeground,
                        fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(height: 12),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
