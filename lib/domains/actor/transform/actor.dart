import 'package:plastik_ui/domains/actor/model/api/seller.dart';
import 'package:plastik_ui/domains/actor/model/api/supplier.dart';
import 'package:plastik_ui/domains/actor/model/dto/seller.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';

abstract class ActorTransformer {
  SellerAPI makeModelSellerAPI(Seller seller);
  Seller makeModelSeller(SellerAPI seller);
  SupplierAPI makeModelSupplierAPI(Supplier supplier);
  Supplier makeModelSupplier(SupplierAPI supplier);
  List<Seller> makeModelSellers(List<SellerAPI> sellers);
  List<Supplier> makeModelSuppliers(List<SupplierAPI> suppliers);
}

class ActorTransformerImplementation implements ActorTransformer {
  @override
  List<Supplier> makeModelSuppliers(List<SupplierAPI> suppliers) {
    List<Supplier> results = [];
    for (int i = 0; i < suppliers.length; i++) {
      Supplier supplier = Supplier(
        id: suppliers[i].id,
        name: suppliers[i].name,
        createdAt: suppliers[i].createdAt,
      );
      results.add(supplier);
    }

    return results;
  }

  @override
  SellerAPI makeModelSellerAPI(Seller seller) {
    return SellerAPI(
      id: seller.id,
      name: seller.name,
      createdAt: seller.createdAt,
    );
  }

  @override
  Seller makeModelSeller(SellerAPI seller) {
    return Seller(
      id: seller.id,
      name: seller.name,
      createdAt: seller.createdAt,
    );
  }

  @override
  List<Seller> makeModelSellers(List<SellerAPI> sellers) {
    List<Seller> results = [];
    sellers.forEach(
      (seller) => results.add(
            Seller(
                id: seller.id, name: seller.name, createdAt: seller.createdAt),
          ),
    );
    return results;
  }

  @override
  SupplierAPI makeModelSupplierAPI(Supplier supplier) {
    return SupplierAPI(
      id: supplier.id,
      name: supplier.name,
      createdAt: supplier.createdAt,
    );
  }

  @override
  Supplier makeModelSupplier(SupplierAPI supplier) {
    return Supplier(
      id: supplier.id,
      name: supplier.name,
      createdAt: supplier.createdAt,
    );
  }
}
