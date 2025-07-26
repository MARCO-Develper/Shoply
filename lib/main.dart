import 'package:shoply/core/common/screens/product_details_screen.dart';
import 'package:shoply/core/storage_helper/app_shared_preference_helper.dart';
import 'package:shoply/feature/app_section/app_section.dart';
import 'package:shoply/feature/auth/view/login_screen.dart';
import 'package:shoply/feature/auth/view/register_screen.dart';
import 'package:shoply/feature/home/view/product_of_category_screen.dart';
import 'package:shoply/feature/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(const Shoply());
}

class Shoply extends StatelessWidget {
  const Shoply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User App",
      initialRoute: AppSection.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        AppSection.routeName: (context) => const AppSection(),
        ProductOfCategoryScreen.routeName: (context) =>
            const ProductOfCategoryScreen(),
        ProductDetailsScreen.routeName: (context) =>
            const ProductDetailsScreen.screen(),
      },
    );
  }
}
