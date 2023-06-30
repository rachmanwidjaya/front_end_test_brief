import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';
import '../../../widgets/image_screen.dart';
import '../../../widgets/wss_state_widget.dart';
import '../bloc/menu_bloc.dart';
import '../modules/home/page/home_page.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<Widget> screens = [
    const HomePage(),
    const _UC(),
    const _UC(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuBLoc>(
      create: (_) => MenuBLoc(),
      child: BlocBuilder<MenuBLoc, int>(
        builder: (context, state) {
          return Scaffold(
            body: screens.elementAt(state),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const WssStateWidget(),
                BottomNavigationBar(
                  currentIndex: state,
                  onTap: (index) => context.read<MenuBLoc>().setScreen(index),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.auto_awesome_mosaic_outlined,
                        color: context.disabledColor,
                      ),
                      activeIcon: Icon(
                        Icons.auto_awesome_mosaic_outlined,
                        color: context.primaryColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.currency_exchange,
                        color: context.disabledColor,
                      ),
                      activeIcon: Icon(
                        Icons.currency_exchange,
                        color: context.primaryColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_2_outlined,
                        color: context.disabledColor,
                      ),
                      activeIcon: Icon(
                        Icons.person_2_outlined,
                        color: context.primaryColor,
                      ),
                      label: '',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UC extends StatelessWidget {
  const _UC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.sizeWidth,
        child: ImageScreen(
          'https://img.freepik.com/free-vector/website-construction-background_1361-1388.jpg',
          width: context.sizeWidth,
          height: context.sizeHeight,
        ),
      ),
    );
  }
}
