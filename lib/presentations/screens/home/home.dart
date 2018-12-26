import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastik_ui/values/colors.dart';

class HomeTabbarNav extends StatefulWidget {
  @override
  _HomeTabbarNavState createState() => _HomeTabbarNavState();
}

class _HomeTabbarNavState extends State<HomeTabbarNav> {
  // final property
  final List<BottomNavigationBarItem> _itemsBottomNav = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/svg/038-startup.svg',
        width: 26,
        height: 26,
      ),
      title: Text('Beranda'),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/svg/049-presentation.svg',
        width: 26,
        height: 26,
      ),
      title: Text('Transaksi'),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/svg/029-management.svg',
        width: 26,
        height: 26,
      ),
      title: Text('Laporan'),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/svg/009-interview.svg',
        width: 26,
        height: 26,
      ),
      title: Text('Akun'),
    ),
  ];

  // state property
  int _currIndexBottomNav = 0;

  void _onTapBottomNav(int index) {}

  @override
  Widget build(BuildContext ctx) => StreamBuilder<dynamic>(
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> data) => Scaffold(
              body: Text("helo"),
              backgroundColor: BACKGROUND_COLOR,
              bottomNavigationBar: BottomNavigationBar(
                items: _itemsBottomNav,
                currentIndex: _currIndexBottomNav,
                onTap: _onTapBottomNav,
                type: BottomNavigationBarType.fixed,
              ),
            ),
      );
}
