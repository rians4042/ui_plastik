import 'package:plastik_ui/domains/actor/model/api/supplier.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';

abstract class ActorTransformer {
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
}
