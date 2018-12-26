import 'package:meta/meta.dart';

class SellerAPI {
  String id;
  String name;
  String createdAt;

  SellerAPI({@required this.id, @required this.name, @required this.createdAt});

  factory SellerAPI.fromJSON(Map<String, dynamic> json) => SellerAPI(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'],
      );
}
