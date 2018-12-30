import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/010-puzzle.svg',
            width: 100,
            height: 100,
          ),
          Text(
            'Tidak Ada Data',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            'Silahkan Tekan Tombol Tambah Di Bawah Untuk Masukkan Data',
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
