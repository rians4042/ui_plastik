import 'package:plastik_ui/domains/item/model/api/item-category.dart';
import 'package:plastik_ui/domains/item/model/api/item.dart';
import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';

abstract class ItemTransformer {
  ItemAPI makeModelItemAPI(Item item);
  Item makeModelItem(ItemAPI item);
  List<Item> makeModelItems(List<ItemAPI> items);
  ItemCategoryAPI makeModelItemCategoryAPI(ItemCategory itemCategory);
  ItemCategory makeModelItemCategory(ItemCategoryAPI itemCategory);
  List<ItemCategory> makeModelItemCategories(
      List<ItemCategoryAPI> itemCategories);
}

class ItemTransformerImplementation implements ItemTransformer {
  @override
  Item makeModelItem(ItemAPI item) {
    return Item(
      id: item.id,
      name: item.name,
      unitId: item.unitId,
      createdAt: item.createdAt,
      itemCategoryId: item.itemCategoryId,
    );
  }

  @override
  ItemAPI makeModelItemAPI(Item item) {
    return ItemAPI(
      id: item.id,
      name: item.name,
      itemCategoryId: item.itemCategoryId,
      createdAt: item.createdAt,
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
              createdAt: item.createdAt,
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
              createdAt: category.createdAt,
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
      createdAt: itemCategory.createdAt,
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
}
