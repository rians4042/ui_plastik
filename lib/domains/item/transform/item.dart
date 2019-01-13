import 'package:Recet/domains/item/model/api/item-category.dart';
import 'package:Recet/domains/item/model/api/item-unit.dart';
import 'package:Recet/domains/item/model/api/item.dart';
import 'package:Recet/domains/item/model/dto/item-category.dart';
import 'package:Recet/domains/item/model/dto/item-unit.dart';
import 'package:Recet/domains/item/model/dto/item.dart';
import 'package:Recet/helpers/datetime/datetime.dart';

abstract class ItemTransformer {
  ItemAPI makeModelItemAPI(Item item);
  Item makeModelItem(ItemAPI item);
  List<Item> makeModelItems(List<ItemAPI> items);
  ItemCategoryAPI makeModelItemCategoryAPI(ItemCategory itemCategory);
  ItemCategory makeModelItemCategory(ItemCategoryAPI itemCategory);
  List<ItemCategory> makeModelItemCategories(
      List<ItemCategoryAPI> itemCategories);
  List<ItemUnit> makeModelItemUnit(List<ItemUnitAPI> itemUnits);
}

class ItemTransformerImplementation implements ItemTransformer {
  DateTimeCustom datetime;

  ItemTransformerImplementation() {
    datetime = DateTimeCustomImplementation();
  }

  @override
  Item makeModelItem(ItemAPI item) {
    return Item(
      id: item.id,
      name: item.name,
      unitId: item.unitId,
      createdAt: datetime.create(
        item.createdAt,
        DateTimeCustomImplementation.DATEANDTIME,
      ),
      itemCategoryId: item.itemCategoryId,
    );
  }

  @override
  ItemAPI makeModelItemAPI(Item item) {
    return ItemAPI(
      id: item.id,
      name: item.name,
      itemCategoryId: item.itemCategoryId,
      createdAt: datetime.create(
        item.createdAt,
        DateTimeCustomImplementation.DATEANDTIME,
      ),
      unitId: item.unitId,
    );
  }

  @override
  List<Item> makeModelItems(List<ItemAPI> items) {
    List<Item> results = [];
    items.forEach(
      (item) => results.add(
            Item(
              id: item.id,
              name: item.name,
              itemCategoryId: item.itemCategoryId,
              createdAt: datetime.create(
                item.createdAt,
                DateTimeCustomImplementation.DATEANDTIME,
              ),
              unitId: item.unitId,
            ),
          ),
    );

    return results;
  }

  @override
  List<ItemCategory> makeModelItemCategories(
      List<ItemCategoryAPI> itemCategories) {
    List<ItemCategory> results = [];
    itemCategories.forEach(
      (category) => results.add(
            ItemCategory(
              id: category.id,
              name: category.name,
              createdAt: datetime.create(
                category.createdAt,
                DateTimeCustomImplementation.DATEANDTIME,
              ),
            ),
          ),
    );

    return results;
  }

  @override
  ItemCategory makeModelItemCategory(ItemCategoryAPI itemCategory) {
    return ItemCategory(
      id: itemCategory.id,
      name: itemCategory.name,
      createdAt: datetime.create(
        itemCategory.createdAt,
        DateTimeCustomImplementation.DATEANDTIME,
      ),
    );
  }

  @override
  ItemCategoryAPI makeModelItemCategoryAPI(ItemCategory itemCategory) {
    return ItemCategoryAPI(
      id: itemCategory.id,
      name: itemCategory.name,
      createdAt: itemCategory.createdAt,
    );
  }

  @override
  List<ItemUnit> makeModelItemUnit(List<ItemUnitAPI> itemUnits) {
    return itemUnits
        .map(
          (ItemUnitAPI itemUnit) => ItemUnit(
                id: itemUnit.id,
                name: itemUnit.name,
                createdAt: datetime.create(
                  itemUnit.createdAt,
                  DateTimeCustomImplementation.DATEANDTIME,
                ),
              ),
        )
        .toList();
  }
}
