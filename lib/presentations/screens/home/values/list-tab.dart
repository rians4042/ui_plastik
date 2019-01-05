import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final List<BottomNavigationBarItem> itemsBottomNav = [
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
