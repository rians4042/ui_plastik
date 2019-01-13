import 'package:Recet/domains/actor/model/api/seller.dart';
import 'package:Recet/domains/actor/model/api/supplier.dart';
import 'package:Recet/domains/actor/model/dto/seller.dart';
import 'package:Recet/domains/actor/model/dto/supplier.dart';
import 'package:Recet/helpers/datetime/datetime.dart';

abstract class ActorTransformer {
  SellerAPI makeModelSellerAPI(Seller seller);
  Seller makeModelSeller(SellerAPI seller);
  SupplierAPI makeModelSupplierAPI(Supplier supplier);
  Supplier makeModelSupplier(SupplierAPI supplier);
  List<Seller> makeModelSellers(List<SellerAPI> sellers);
  List<Supplier> makeModelSuppliers(List<SupplierAPI> suppliers);
}

class ActorTransformerImplementation implements ActorTransformer {
  DateTimeCustom datetime;

  ActorTransformerImplementation() {
    datetime = DateTimeCustomImplementation();
  }

  @override
  List<Supplier> makeModelSuppliers(List<SupplierAPI> suppliers) {
    List<Supplier> results = [];
    for (int i = 0; i < suppliers.length; i++) {
      Supplier supplier = Supplier(
        id: suppliers[i].id,
        name: suppliers[i].name,
        phone: suppliers[i].phone,
        address: suppliers[i].address,
        createdAt: datetime.create(
            suppliers[i].createdAt, DateTimeCustomImplementation.DATEANDTIME),
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
      phone: seller.phone,
      address: seller.address,
      createdAt: datetime.create(
          seller.createdAt, DateTimeCustomImplementation.DATEANDTIME),
    );
  }

  @override
  Seller makeModelSeller(SellerAPI seller) {
    return Seller(
      id: seller.id,
      name: seller.name,
      phone: seller.phone,
      address: seller.address,
      createdAt: datetime.create(
          seller.createdAt, DateTimeCustomImplementation.DATEANDTIME),
    );
  }

  @override
  List<Seller> makeModelSellers(List<SellerAPI> sellers) {
    List<Seller> results = [];
    sellers.forEach(
      (seller) => results.add(
            Seller(
              id: seller.id,
              name: seller.name,
              phone: seller.phone,
              address: seller.address,
              createdAt: datetime.create(
                  seller.createdAt, DateTimeCustomImplementation.DATEANDTIME),
            ),
          ),
    );
    return results;
  }

  @override
  SupplierAPI makeModelSupplierAPI(Supplier supplier) {
    return SupplierAPI(
      id: supplier.id,
      name: supplier.name,
      phone: supplier.phone,
      address: supplier.address,
      createdAt: datetime.create(
          supplier.createdAt, DateTimeCustomImplementation.DATEANDTIME),
    );
  }

  @override
  Supplier makeModelSupplier(SupplierAPI supplier) {
    return Supplier(
      id: supplier.id,
      name: supplier.name,
      phone: supplier.phone,
      address: supplier.address,
      createdAt: datetime.create(
          supplier.createdAt, DateTimeCustomImplementation.DATEANDTIME),
    );
  }
}
