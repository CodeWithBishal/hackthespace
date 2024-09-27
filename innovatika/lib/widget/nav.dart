import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:innovatika/homepage.dart';
import 'package:innovatika/widget/appbar.dart';

class NavBar extends StatefulWidget {
  final int? index;
  const NavBar({super.key, this.index});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int _selectedIndex = 0;
  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = [
      const Homepage(),
      const Center(child: Text("2")),
      const Center(child: Text("3")),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonApp(context: context),
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        height: 65,
        iconSize: 22,
        items: [
          FlashyTabBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Iconsax.search_normal),
            title: const Text('Suggest Plants'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Iconsax.setting),
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
