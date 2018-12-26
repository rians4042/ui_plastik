import 'package:get_it/get_it.dart';
import 'package:plastik_ui/cache/user.dart';
import 'package:plastik_ui/domains/actor/api/seller.dart';
import 'package:plastik_ui/domains/actor/api/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/helpers/httpclient/client.dart';

void injector(GetIt getIt) {
  UserCache _user = UserCacheImplementation();
  SellerAPI sellerAPI = SellerAPIImplementation(client: client(_user));
  SupplierAPI supplierAPI = SupplierAPIImplementation(client: client(_user));
  getIt.registerSingleton<ActorService>(ActorServiceImplementation(
      supplierAPI: supplierAPI, sellerAPI: sellerAPI));
}
