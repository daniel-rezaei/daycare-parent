import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/home_page/presentation/screen/home_screen.dart';
import 'package:parent_app/resorces/style.dart';

import 'app_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: buildAppProviders(), // فقط یک خط
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
          textTheme: AppTypography.textTheme,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
