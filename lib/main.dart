import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/home_page/presentation/screen/home_screen.dart';
import 'package:parent_app/resorces/style.dart';

import 'app_provider.dart';
import 'core/utils/local_storage.dart';
import 'features/login/data/model/user_model.dart';
import 'features/login/presentation/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final UserModel? savedUser = await LocalStorage.getUser();

  runApp(MyApp(savedUser: savedUser));
}

class MyApp extends StatelessWidget {
  final UserModel? savedUser;

  const MyApp({super.key, this.savedUser});

  @override
  Widget build(BuildContext context) {
    final user = savedUser; // local variable for promotion
    return MultiBlocProvider(
      providers: buildAppProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
          textTheme: AppTypography.textTheme,
        ),
        home: user != null
            ? HomeScreen(user: user) // ✅ non-nullable now
            : const LoginPage(),
      ),
    );
  }
}
