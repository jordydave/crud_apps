import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'inventory.g.dart';

/// {@template inventory}
/// A single inventory item.
///
/// Contains a [title], [description], [id], [quantity], and [price] flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Inventory]s are immutable and can be copied using [copyWith], in addition
/// to being serialized and desserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Inventory extends Equatable {
  /// {@macro inventory}
  Inventory({
    required this.title,
    this.id,
    this.description = '',
    this.quantity = 0,
    this.price = 0.0,
  }) : assert(id == null || id.isNotEmpty, 'id cannot be empty');

  /// The unique identifier for this inventory item.
  ///
  /// Cannot be empty.
  final String? id;

  /// The title of this inventory item.
  ///
  /// Note that the title may be empty;
  final String title;

  /// The description of this inventory item.
  ///
  /// Defaults to an empty string.
  final String description;

  /// The quantity of this inventory item.
  ///
  /// Defaults to 0.
  final int quantity;

  /// The price of this inventory item.
  ///
  /// Defaults to 0.0.
  final double price;

  /// Returns a copy of this inventory with the given values updated.
  ///
  /// {@macro inventory}
  Inventory copyWith({
    String? id,
    String? title,
    String? description,
    int? quantity,
    double? price,
  }) {
    return Inventory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  /// Deserializes the given `Map<String, dynamic>` ` into a [Inventory].
  static Inventory fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);

  /// Converts the [Inventory] into a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$InventoryToJson(this);

  @override
  List<Object?> get props => [id, title, description, quantity, price];
}
