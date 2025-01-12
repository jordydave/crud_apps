import 'package:inventories_data_source/inventories_data_source.dart';
import 'package:uuid/uuid.dart';

/// An in-memory implementation of the [InventoriesDataSource] interface.
class InMemoryInventoriesDataSource implements InventoriesDataSource {
  /// Map of ID -> Inventory
  final _cache = <String, Inventory>{};

  @override
  Future<Inventory> create(Inventory inventory) async {
    final id = const Uuid().v4();
    final createdInventory = inventory.copyWith(id: id);
    _cache[id] = createdInventory;
    return createdInventory;
  }

  @override
  Future<List<Inventory>> readAll() async => _cache.values.toList();

  @override
  Future<Inventory?> read(String id) async => _cache[id];

  @override
  Future<Inventory> update(String id, Inventory inventory) async {
    return _cache[id] = inventory.copyWith(id: id);
  }

  @override
  Future<void> delete(String id) async => _cache.remove(id);
}
