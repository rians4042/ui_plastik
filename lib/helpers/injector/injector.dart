import 'package:get_it/get_it.dart';
import 'package:plastik_ui/cache/user.dart';
import 'package:plastik_ui/domains/actor/api/seller.dart';
import 'package:plastik_ui/domains/actor/api/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/domains/actor/transform/actor.dart';
import 'package:plastik_ui/domains/item/api/item-category.dart';
import 'package:plastik_ui/domains/item/api/item-unit.dart';
import 'package:plastik_ui/domains/item/api/item.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/domains/item/transform/item.dart';
import 'package:plastik_ui/domains/report/api/report.dart';
import 'package:plastik_ui/domains/report/service/report.dart';
import 'package:plastik_ui/domains/report/transform/report.dart';
import 'package:plastik_ui/domains/transaction/api/transaction.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/domains/transaction/transform/transaction.dart';
import 'package:plastik_ui/helpers/httpclient/client.dart';

void injector(GetIt getIt) {
  UserCache _user = UserCacheImplementation();
  SellerAPI sellerAPI = SellerAPIImplementation(client: client(_user));
  SupplierAPI supplierAPI = SupplierAPIImplementation(client: client(_user));
  ActorTransformer actorTransformer = ActorTransformerImplementation();
  getIt.registerSingleton<ActorService>(ActorServiceImplementation(
    supplierAPI: supplierAPI,
    sellerAPI: sellerAPI,
    transformer: actorTransformer,
  ));

  ItemAPI itemAPI = ItemAPIImplementation(client: client(_user));
  ItemUnitAPI itemUnitAPI = ItemUnitAPIImplementation(client: client(null));
  ItemCategoryAPI itemCategoryAPI =
      ItemCategoryAPIImplementation(client: client(_user));
  ItemTransformer itemTransformer = ItemTransformerImplementation();
  getIt.registerSingleton<ItemService>(ItemServiceImplementation(
    itemAPI: itemAPI,
    itemUnitAPI: itemUnitAPI,
    itemCategoryAPI: itemCategoryAPI,
    transformer: itemTransformer,
  ));

  TransactionAPI transactionAPI =
      TransactionAPIImplementation(client: client(_user));
  TransactionTransformer transactionTransformer =
      TransactionTransformerImplementation();
  getIt.registerSingleton<TransactionService>(TransactionServiceImplementation(
    api: transactionAPI,
    transformer: transactionTransformer,
  ));

  ReportAPI reportAPI = ReportAPIImplementation(client: client(_user));
  ReportTransformer reportTransformer = ReportTransformerImplementation();
  getIt.registerSingleton<ReportService>(ReportServiceImplementation(
    api: reportAPI,
    transformer: reportTransformer,
  ));
}
