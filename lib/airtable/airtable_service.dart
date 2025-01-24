import 'package:dio/dio.dart';
import 'package:inventories/airtable/airtable_data.dart';

/// A service class to interact with the Airtable API.
class AirtableService {
  /// Creates an instance of [AirtableService].
  ///
  /// The [AirtableData] parameter is required to configure the
  /// Airtable base and table.
  AirtableService(this._airtableData, {Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  final AirtableData _airtableData;

  /// Creates a new record in the Airtable table.
  ///
  /// The [fields] parameter is required and should contain the
  /// data for the new record.
  ///
  /// Returns a [Map] containing the created record data.
  Future<Map<String, dynamic>> createRecord({
    required Map<String, dynamic> fields,
  }) async {
    try {
      final result = await _dio.post<Map<String, dynamic>>(
        'https://api.airtable.com/v0/${_airtableData.baseId}/${_airtableData.tableId}',
        data: {'fields': fields},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_airtableData.token}',
          },
        ),
      );

      return result.data ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves a record from the Airtable table by its ID.
  ///
  /// The [recordId] parameter is required to identify the record.
  ///
  /// Returns a [Map] containing the record data.
  Future<Map<String, dynamic>> getRecordById({
    required String recordId,
  }) async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        'https://api.airtable.com/v0/${_airtableData.baseId}/${_airtableData.tableId}/$recordId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_airtableData.token}',
          },
        ),
      );

      return result.data ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves all records from the Airtable table.
  ///
  /// Returns a [List] of [Map] objects, each representing a record.
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        'https://api.airtable.com/v0/${_airtableData.baseId}/${_airtableData.tableId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_airtableData.token}',
          },
        ),
      );

      final records = result.data?['records'] as List<dynamic>? ?? [];
      return records.map((record) => record as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves a record from the Airtable table by its title.
  ///
  /// The [title] parameter is required to filter the records.
  ///
  /// Returns a [Map] containing the record data.
  Future<Map<String, dynamic>> getRecordByTitle({
    required String title,
  }) async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        'https://api.airtable.com/v0/${_airtableData.baseId}/${_airtableData.tableId}'
        '?filterByFormula=AND({Title} = "$title")',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_airtableData.token}',
          },
        ),
      );

      return result.data ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Updates an existing record in the Airtable table.
  ///
  /// The [fields] parameter is required and should contain the updated data.
  /// The [recordId] parameter is required to identify the record to update.
  ///
  /// Returns a [Map] containing the updated record data.
  Future<Map<String, dynamic>> updateRecord({
    required Map<String, dynamic> fields,
    required String recordId,
  }) async {
    try {
      final result = await _dio.patch<Map<String, dynamic>>(
        'https://api.airtable.com/v0/${_airtableData.baseId}/${_airtableData.tableId}/$recordId',
        data: {'fields': fields},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_airtableData.token}',
          },
        ),
      );

      return result.data ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a record from the Airtable table.
  ///
  /// The [recordId] parameter is required to identify the record to delete.
  Future<void> deleteRecord({required String recordId}) async {
    try {
      await _dio.delete<void>(
        'https://api.airtable.com/v0/${_airtableData.baseId}/${_airtableData.tableId}/$recordId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_airtableData.token}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
