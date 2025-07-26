import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/feature/cart/view/cart_screen.dart';
import 'package:shoply/feature/favorite/view/favorite_screen.dart';
import 'package:shoply/feature/home/controller/home_cubit.dart';
import 'package:shoply/feature/home/view/home_screen.dart';
import 'package:shoply/feature/profile/controller/profile_cubit.dart';
import 'package:shoply/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSection extends StatefulWidget {
  static const String routeName = 'InitApp';
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffEBEBEB),
        unselectedFontSize: 13,
        selectedFontSize: 14,
        selectedItemColor: const Color(0xff212121),
        unselectedItemColor: const Color(0xff5C5C5C),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xff212121),
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xff5C5C5C),
        ),
        currentIndex: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-home.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 0
                  ? const Color(0xff212121)
                  : const Color(0xff5C5C5C),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-cart.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 1
                  ? const Color(0xff212121)
                  : const Color(0xff5C5C5C),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-favourite.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 2
                  ? const Color(0xff212121)
                  : const Color(0xff5C5C5C),
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-profile.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 3
                  ? const Color(0xff212121)
                  : const Color(0xff5C5C5C),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit()
                ..getCategories()
                ..getProducts(),
              child: const HomeScreen(),
            ),
            const CartScreen(),
            const FavoriteScreen(),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit()
                ..getDataProfile(
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjUsImlhdCI6MTc1MzQ2ODYxMSwiZXhwIjoxNzU1MTk2NjExfQ.F9_ibnnKXdBahEHu88_hXt0sXWLoWIIOpmA8MNgaD4I'),
              child: ProfileScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
