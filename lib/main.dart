import 'package:shoply/core/common/screens/product_details_screen.dart';
import 'package:shoply/feature/app_section/app_section.dart';
import 'package:shoply/feature/auth/view/login_screen.dart';
import 'package:shoply/feature/auth/view/register_screen.dart';
import 'package:shoply/feature/home/view/product_of_category_screen.dart';
import 'package:shoply/feature/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User App",
      initialRoute: AppSection.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        AppSection.routeName: (context) => const AppSection(),
        ProductOfCategoryScreen.routeName: (context) => const ProductOfCategoryScreen(),
        ProductDetailsScreen.routeName: (context) => const ProductDetailsScreen.screen(),
      },
    );
  }
}
