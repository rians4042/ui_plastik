import 'package:flutter/material.dart';
import 'package:Recet/presentations/screens/home/blocs/home.dart';
import 'package:Recet/presentations/screens/home/values/list-screen.dart';
import 'package:Recet/presentations/screens/home/values/list-tab.dart';
import 'package:Recet/values/colors.dart';

class HomeTabbarNav extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomeTabbarNavState createState() => _HomeTabbarNavState();
}

class _HomeTabbarNavState extends State<HomeTabbarNav> {
  HomeBloc _homeBloc;

  _HomeTabbarNavState() {
    _homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
        body: SafeArea(
          child: StreamBuilder<int>(
            stream: _homeBloc.index,
            builder: (BuildContext ctx, AsyncSnapshot<int> snapshot) =>
                screens[snapshot.hasData ? snapshot.data : 0],
          ),
        ),
        backgroundColor: BACKGROUND_COLOR,
        bottomNavigationBar: StreamBuilder<int>(
          stream: _homeBloc.index,
          builder: (BuildContext ctx, AsyncSnapshot<int> snapshot) =>
              BottomNavigationBar(
                items: itemsBottomNav,
                currentIndex: snapshot.hasData ? snapshot.data : 0,
                onTap: (int _index) {
                  _homeBloc.changeIndex.add(_index);
                },
                type: BottomNavigationBarType.fixed,
              ),
        ),
      );
}
