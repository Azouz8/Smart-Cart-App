import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xff5b9ee1),
            selectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(color: Colors.white, size: 30.sp),
            elevation: 0,
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: cubit.bottomItems,
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
          ));
    });
  }
}
