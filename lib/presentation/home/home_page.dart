import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nostalgix/application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:nostalgix/presentation/album/album_page.dart';
import 'package:nostalgix/presentation/constants/app_fonts.dart';
import 'package:nostalgix/presentation/extensions/context_extension.dart';
import 'package:nostalgix/presentation/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage._();

  static MaterialPageRoute<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return HomePage._();
    });
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavbarCubit, BottomNavbarState>(
      listener: (context, state) {
        controller.jumpToPage(state.currentIndex);
      },
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: BottomNavbarTab.values.map((e) {
            switch (e) {
              case BottomNavbarTab.album:
                return AlbumPage();
              case BottomNavbarTab.settings:
                return SettingsPage();
            }
          }).toList(),
        ),
        bottomNavigationBar: HomePageBottomNavbar(),
      ),
    );
  }
}

class BottomNavbarItemDecoration {
  const BottomNavbarItemDecoration({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class HomePageBottomNavbar extends StatelessWidget {
  const HomePageBottomNavbar({super.key});

  BottomNavbarItemDecoration tabDecorationFunc(BottomNavbarTab t) {
    switch (t) {
      case BottomNavbarTab.album:
        return BottomNavbarItemDecoration(
          icon: Icons.image,
          label: 'ALBUM',
        );
      case BottomNavbarTab.settings:
        return BottomNavbarItemDecoration(
          label: 'SETTINGS',
          icon: Icons.settings,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: context.appTheme.surface,
          onTap: (index) {
            context.read<BottomNavbarCubit>().selectTab(index);
          },
          currentIndex: state.currentIndex,
          selectedLabelStyle: TextStyle(
            fontFamily: AppFonts.playfair.family,
            fontWeight: FontWeight.w700,
            color: context.appTheme.textPrimary,
          ),
          selectedItemColor: context.appTheme.primary,
          unselectedItemColor: context.appTheme.textSecondary,
          unselectedLabelStyle: TextStyle(
            fontFamily: AppFonts.playfair.family,
            fontWeight: FontWeight.w700,
          ),
          items: BottomNavbarTab.values.map((e) {
            final deco = tabDecorationFunc(e);

            return BottomNavigationBarItem(
              label: deco.label,
              icon: Icon(deco.icon),
            );
          }).toList(),
        );
      },
    );
  }
}
