import 'package:inventories_data_source/inventories_data_source.dart';

/// An interface for a inventories data source.
/// A inventories data source supports basic C.R.U.D. operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class InventoriesDataSource {
  /// Create and return the newly created inventory.
  Future<Inventory> create(Inventory inventory);

  /// Return all inventories.
  Future<List<Inventory>> readAll();

  /// Return a inventory with the provided [id] if one exists.
  Future<Inventory?> read(String id);

  /// Update the inventory with the provided [id] to match [inventory] and
  /// return the updated inventory.
  Future<Inventory?> update(String id, Inventory inventory);

  /// Delete the inventory with the provided [id] if one exists.
  Future<void> delete(String id);
}
