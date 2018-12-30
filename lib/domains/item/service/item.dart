import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/item/api/item-category.dart';
import 'package:plastik_ui/domains/item/api/item-unit.dart';
import 'package:plastik_ui/domains/item/api/item.dart';
import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/model/dto/item-unit.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/item/model/api/item.dart' as modelItem;
import 'package:plastik_ui/domains/item/model/api/item-category.dart'
    as modelItemCategory;
import 'package:plastik_ui/domains/item/model/api/item-unit.dart'
    as modelItemUnit;
import 'package:plastik_ui/domains/item/transform/item.dart';

abstract class ItemService {
  Future<List<ItemCategory>> getItemCategories();
  Future<List<Item>> getItems();
  Future<ItemCategory> getItemCategoryDetail(String id);
  Future<Item> getItemDetail(String id);
  Future<List<ItemUnit>> getItemUnits();
  Future<bool> createItemCategory(ItemCategory itemCategory);
  Future<bool> createItem(Item item);
  Future<bool> updateItemCategory(String id, ItemCategory itemCategory);
  Future<bool> updateItem(String id, Item item);
  Future<bool> deleteItemCategory(String id);
  Future<bool> deleteItem(String id);
}

class ItemServiceImplementation implements ItemService {
  ItemTransformer transformer;
  ItemAPI itemAPI;
  ItemCategoryAPI itemCategoryAPI;
  ItemUnitAPI itemUnitAPI;

  ItemServiceImplementation(
      {@required this.transformer,
      @required this.itemAPI,
      @required this.itemCategoryAPI});

  @override
  Future<bool> createItem(Item item) async {
    await itemAPI.createItem(transformer.makeModelItemAPI(item));
    return true;
  }

  @override
  Future<bool> createItemCategory(ItemCategory itemCategory) async {
    await itemCategoryAPI
        .createCategory(transformer.makeModelItemCategoryAPI(itemCategory));
    return true;
  }

  @override
  Future<bool> deleteItem(String id) async {
    await itemAPI.deleteItem(id);
    return true;
  }

  @override
  Future<bool> deleteItemCategory(String id) async {
    await itemCategoryAPI.deleteCategory(id);
    return true;
  }

  @override
  Future<List<ItemCategory>> getItemCategories() async {
    final List<modelItemCategory.ItemCategoryAPI> categories =
        await itemCategoryAPI.getCategories();
    return transformer.makeModelItemCategories(categories);
  }

  @override
  Future<ItemCategory> getItemCategoryDetail(String id) async {
    final modelItemCategory.ItemCategoryAPI category =
        await itemCategoryAPI.getCategoryDetail(id);
    return transformer.makeModelItemCategory(category);
  }

  @override
  Future<Item> getItemDetail(String id) async {
    final modelItem.ItemAPI item = await itemAPI.getItemDetail(id);
    return transformer.makeModelItem(item);
  }

  @override
  Future<List<Item>> getItems() async {
    final List<modelItem.ItemAPI> items = await itemAPI.getItems();
    return transformer.makeModelItems(items);
  }

  @override
  Future<bool> updateItem(String id, Item item) async {
    await itemAPI.updateItem(id, transformer.makeModelItemAPI(item));
    return true;
  }

  @override
  Future<bool> updateItemCategory(String id, ItemCategory itemCategory) async {
    await itemCategoryAPI.updateCategory(
        id, transformer.makeModelItemCategoryAPI(itemCategory));
    return true;
  }

  @override
  Future<List<ItemUnit>> getItemUnits() async {
    List<modelItemUnit.ItemUnitAPI> itemUnits =
        await itemUnitAPI.getItemUnits();
    return transformer.makeModelItemUnit(itemUnits);
  }
}
