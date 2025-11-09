import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/resorces/pallete.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../home_page/presentation/screen/home_screen.dart';
import '../../data/model/user_model.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  bool isRobot = false;
  bool passwordVisible = false;

  String email = "";
  String password = "";

  String get currentImage {
    if (email.isEmpty) {
      return 'assets/images/login1.png';
    } else if (email.isNotEmpty && password.isEmpty) {
      return 'assets/images/login2.png';
    } else {
      return 'assets/images/login3.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          final message = state.error.replaceAll('Exception: ', '');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }

        if (state is LoginSuccess) {
          await LocalStorage.saveUser(state.user as UserModel); // cast لازم است
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => HomeScreen(
                  user: state.user
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.2,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_login.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            /// تصویر سه حالته
            Positioned(
              top: screenHeight * 0.20,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset(currentImage),
                ),
              ),
            ),

            Positioned(
              top: screenHeight * 0.50,
              left: 8,
              right: 8,
              bottom: 0,
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) => setState(() => email = value.trim()),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      onChanged: (value) =>
                          setState(() => password = value.trim()),
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => passwordVisible = !passwordVisible);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              'assets/images/ic_password.svg',
                              width: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (val) => setState(() => rememberMe = val!),
                          activeColor: Palette.txtTagForeground3,
                        ),
                        Text('Remember Me',
                            style: TextStyle(
                                fontSize: 14,
                                color: Palette.textForeground,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isRobot,
                            onChanged: (val) => setState(() => isRobot = val!),
                          ),
                          Text("I'm not a robot",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Palette.textForeground,
                                  fontWeight: FontWeight.w500)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child:
                            Image.asset('assets/images/ic_recapta.png'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final isLoading = state is LoginLoading;
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.txtTagForeground3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isLoading
                                ? null
                                : () {
                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Email and password required')));
                                return;
                              }

                              context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email,
                                  password,
                                ),
                              );
                            },
                            child: isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text('Login',
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                    Palette.textPrimaryForeground,
                                    fontWeight: FontWeight.w500)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?',
                          style: TextStyle(
                              color: Palette.textForeground,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
