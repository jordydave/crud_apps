/// A class representing the data required to interact with an Airtable base.
class AirtableData {
  /// Creates an instance of [AirtableData].
  ///
  /// The [baseId], [tableId], and [token] parameters are required.
  AirtableData({
    required this.baseId,
    required this.tableId,
    required this.token,
  });

  /// The ID of the Airtable base.
  final String baseId;

  /// The ID of the Airtable table.
  final String tableId;

  /// The API token used for authentication.
  final String token;
}
