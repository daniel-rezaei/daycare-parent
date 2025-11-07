import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_app/resorces/pallete.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
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
                height: 250,child: Image.asset('assets/images/forget_password.png'))),
          ),

          Positioned(
            top: screenHeight * 0.40,
            left: 36,
            right: 36,
            bottom: 0,
            child: Column(
              children: [
                Text('Forgot Password?',style: TextStyle(
                  fontSize: 30,fontWeight: FontWeight.w600,
                  color: Palette.textForeground
                ),),
                SizedBox(height: 12,),
                Text('Enter your registered email',style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,
                    color: Palette.textMutedForeground
                ),),
                SizedBox(height: 40,),

                TextField(
                  onChanged: (value) {
                    setState(() => email = value.trim());
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Palette.bgBackground90,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  ),
                ),

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
                    child: Text('Send Reset Link', style: TextStyle(
                        fontSize: 16,
                        color: Palette.textPrimaryForeground,
                        fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(height: 12),

                TextButton(
                  onPressed: () {},
                  child: Text('Back to Login',
                      style: TextStyle(
                          color: Palette.textForeground,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
