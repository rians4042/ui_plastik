import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
  title: "Pabrik_Plastik",
  home: new HalamanSatu(),
));
}

class HalamanSatu extends StatelessWidget {
  @override
  Widget  build(BuildContext context) {
    return new Scaffold(
    appBar: new AppBar(
      title: new Text("Pabrik Plastik"),
    ),
    );
  }
}

