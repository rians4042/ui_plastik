import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Maintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 36,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/016-effort.svg',
            width: 100,
            height: 100,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8,
              bottom: 4,
            ),
            child: Text(
              'Halaman Sedang Dalam Pengembangan',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'Mohon maaf untuk sementara waktu, halaman yang dituju tidak dapat diakses karena masih pengembangan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
