import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/seller/screens/seller-list.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-list.dart';

final List<Map<String, dynamic>> items = [
  {
    'sectionTitle': 'Item',
    'details': [
      {
        'name': 'Kategori',
        'asset': 'assets/svg/010-puzzle.svg',
        'onPress': (BuildContext context) {},
      },
      {
        'name': 'Item',
        'asset': 'assets/svg/010-puzzle.svg',
        'onPress': (BuildContext context) {},
      }
    ]
  },
  {
    'sectionTitle': 'Aktor',
    'details': [
      {
        'name': 'Penyuplai',
        'asset': 'assets/svg/032-networking-1.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SupplierList(),
              settings: RouteSettings(
                name: SupplierList.routerName,
              ),
            ),
          );
        },
      },
      {
        'name': 'Penjual',
        'asset': 'assets/svg/033-networking-2.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SellerList(),
              settings: RouteSettings(
                name: SellerList.routerName,
              ),
            ),
          );
        },
      }
    ]
  },
  {
    'sectionTitle': 'Transaksi',
    'details': [
      {
        'name': 'Masuk',
        'asset': 'assets/svg/036-profit.svg',
        'onPress': (BuildContext context) {},
      },
      {
        'name': 'Keluar',
        'asset': 'assets/svg/047-handshake.svg',
        'onPress': (BuildContext context) {},
      },
      {
        'name': 'Lainnya',
        'asset': 'assets/svg/034-meeting.svg',
        'onPress': (BuildContext context) {},
      },
      {
        'name': 'Tipe Lainnya',
        'asset': 'assets/svg/004-structure.svg',
        'onPress': (BuildContext context) {},
      }
    ]
  }
];
