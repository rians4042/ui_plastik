import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/screens/categoryitem-list.dart';
import 'package:plastik_ui/presentations/screens/seller/screens/seller-list.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-list.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/screens/transaction-in-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/screens/transaction-out-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/screens/transaction-type-list.dart';
import 'package:plastik_ui/presentations/screens/item/screens/item-list.dart';

final List<Map<String, dynamic>> items = [
  {
    'sectionTitle': 'Barang',
    'details': [
      {
        'name': 'Kategori',
        'asset': 'assets/svg/010-puzzle.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CategoryItemList(),
              settings: RouteSettings(
                name: CategoryItemList.routeName,
              ),
            ),
          );
        },
      },
      {
        'name': 'Barang',
        'asset': 'assets/svg/010-puzzle.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ItemList(),
              settings: RouteSettings(
                name: ItemList.routeName,
              ),
            ),
          );
        },
      },
      {
        'name': 'Stok',
        'asset': 'assets/svg/008-archive.svg',
        'onPress': (BuildContext context) {},
      }
    ]
  },
  {
    'sectionTitle': 'Aktor',
    'details': [
      {
        'name': 'Penyuplai',
        'asset': 'assets/svg/033-networking-2.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SupplierList(),
              settings: RouteSettings(
                name: SupplierList.routeName,
              ),
            ),
          );
        },
      },
      {
        'name': 'Penjual',
        'asset': 'assets/svg/032-networking-1.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SellerList(),
              settings: RouteSettings(
                name: SellerList.routeName,
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
        'name': 'Beli Barang',
        'asset': 'assets/svg/047-handshake.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TransactionInForm(),
              settings: RouteSettings(
                name: TransactionInForm.routeName,
              ),
            ),
          );
        },
      },
      {
        'name': 'Jual Barang',
        'asset': 'assets/svg/036-profit.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TransactionOutForm(),
              settings: RouteSettings(
                name: TransactionOutForm.routeName,
              ),
            ),
          );
        },
      },
      {
        'name': 'Lainnya',
        'asset': 'assets/svg/034-meeting.svg',
        'onPress': (BuildContext context) {},
      },
      {
        'name': 'Tipe Lainnya',
        'asset': 'assets/svg/004-structure.svg',
        'onPress': (BuildContext context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TransactionTypeList(),
              settings: RouteSettings(
                name: TransactionTypeList.routeName,
              ),
            ),
          );
        },
      }
    ]
  }
];
