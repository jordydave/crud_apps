/// A class representing a record in an Airtable table.
class AirtableRecord {
  /// Creates an instance of [AirtableRecord].
  ///
  /// The [id], [title], [description], [quantity], and [price]
  /// parameters are required.
  AirtableRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
  });

  /// Converts from a JSON object to an [AirtableRecord] object.
  factory AirtableRecord.fromJson(Map<String, dynamic> json) {
    return AirtableRecord(
      id: json['id'] as String?,
      title: json['Title'] as String,
      description: json['Description'] as String,
      quantity: json['Quantity'] as int,
      price: json['Price'] as double,
    );
  }

  /// The unique identifier of the record.
  final String? id;

  /// The title of the record.
  final String title;

  /// The description of the record.
  final String description;

  /// The quantity of the item in the record.
  final int quantity;

  /// The price of the item in the record.
  final double price;
}
