import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_app/resorces/pallete.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
                Text('Reset Password',style: TextStyle(
                    fontSize: 30,fontWeight: FontWeight.w600,
                    color: Palette.textForeground
                ),),
                SizedBox(height: 12,),
                Text('Enter your New Password',style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,
                    color: Palette.textMutedForeground
                ),),
                SizedBox(height: 40,),

                TextField(
                  onChanged: (value) {
                    setState(() => password = value.trim());
                  },
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'New password',
                    filled: true,
                    fillColor:Palette.bgBackground90,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  ),
                ),
                SizedBox(height: 24,),
                TextField(
                  onChanged: (value) {
                    setState(() => password = value.trim());
                  },
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Confirm new password',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password Strength',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600,color: Palette.textForeground
                    ),),
                    SizedBox(height: 4,),
                    Text('At least 8 characters with letters, numbers & symbols.',style:
                    TextStyle(fontWeight: FontWeight.w400,fontSize: 11,color: Palette
                        .textSecondaryForeground),),
                  ],
                ),

                SizedBox(height: 24,),
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
                    child: Text('Reset Password', style: TextStyle(
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
